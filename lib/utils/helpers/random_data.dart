import 'package:cashier_app/collections/journal/journal.dart';
import 'package:cashier_app/collections/journal/journal_detail.dart';
import 'package:cashier_app/collections/location/location.dart';
import 'package:cashier_app/collections/location/storage.dart';
import 'package:cashier_app/collections/product/product_price.dart';
import 'package:faker/faker.dart';
import 'package:isar/isar.dart';

import '../../collections/product/product.dart';

void randomData(Isar isar) {
  // clean up
  isar.writeTxnSync(() {
    isar.journals.clearSync();
    isar.journalDetails.clearSync();
    isar.products.clearSync();
    isar.productPrices.clearSync();
    isar.locations.clearSync();
    isar.storages.clearSync();
  });

  // buat produk baru
  List<Product> pds = [];
  List<ProductPrice> pdps = [];
  final pdsAmount = Faker().randomGenerator.integer(32, min: 16);
  for (int i = 0; i < pdsAmount; i++) {
    var name = Faker().food.dish();
    var initial = getNameInitials(name);
    var product = Product()
      ..code =
          "$initial-${Faker().randomGenerator.integer(999).toString().padLeft(3, "0")}"
      ..name = name;
    var productPrice = ProductPrice()
    ..product.value = product
    ..price = 4000 + (Faker().randomGenerator.integer(10) * 100);
    pds.add(product);
    pdps.add(productPrice);
  }

  // buat lokasi baru
  final lc = Location()
    ..name = Faker().company.name()
    ..address = Faker().address.streetAddress()
    ..created = DateTime.now();

  // buat gudang baru
  List<Storage> sts = [];
  sts.add(Storage()
    ..name = "Etalase"
    ..location.value = lc
    ..created = DateTime.now());
  sts.add(Storage()
    ..name = "Gudang"
    ..location.value = lc
    ..created = DateTime.now());

  // buat jurnal baru
  List<Journal> js = [];
  List<JournalDetail> jds = [];
  // buat jurnal detail baru

  // new product
  randomizeJournal(js, "ST", JournalType.startingStock, jds, pds, sts);

  // perform sale
  randomizeJournal(js, "SL", JournalType.sale, jds, pds, sts);

  // perform out
  randomizeJournal(js, "OT", JournalType.outgoing, jds, pds, sts);

  // perform in
  randomizeJournal(js, "IN", JournalType.incoming, jds, pds, sts);

  isar.writeTxnSync(() async {
    isar.products.putAllSync(pds);
    isar.productPrices.putAllSync(pdps);
    isar.locations.putAllSync([lc]);
    isar.storages.putAllSync(sts);
    isar.journalDetails.putAllSync(jds);
    isar.journals.putAllSync(js);
  });
}

void randomizeJournal(
    List<Journal> journals,
    String code,
    JournalType journalType,
    List<JournalDetail> journalDetails,
    List<Product> performedProducts,
    List<Storage> storages) {
  List<Journal> tmps = [];

  var journalAmount = RandomGenerator().integer(10, min: 1);

  for (int i = 0; i < journalAmount; i++) {
    var created = journalType != JournalType.startingStock
        ? faker.date.dateTimeBetween(
            DateTime.now().subtract(const Duration(days: 30)), DateTime.now())
        : faker.date.dateTimeBetween(
            DateTime.now().subtract(const Duration(days: 40)),
            DateTime.now().subtract(const Duration(days: 30)));

    generateJournal(tmps, code, i, journalType, created, journalDetails,
        performedProducts, storages);
  }

  generateJournal(tmps, code, journalAmount, journalType, DateTime.now(),
      journalDetails, performedProducts, storages);

  journals.addAll(tmps);
}

void generateJournal(
    List<Journal> tmps,
    String code,
    int iteration,
    JournalType journalType,
    DateTime created,
    List<JournalDetail> journalDetails,
    List<Product> performedProducts,
    List<Storage> storages) {
  tmps.add(Journal()
    ..code =
        "$code-${(iteration + 1).toString().padLeft(3, "0")}-${RandomGenerator().integer(1000).toString().padLeft(3, "0")}"
    ..journalType = journalType
    ..journalStatus = RandomGenerator().element(JournalStatus.values)
    ..created = created);
  for (int j = 0; j < RandomGenerator().integer(10, min: 1); j++) {
    journalDetails.add(JournalDetail()
      ..journal.value = tmps[iteration]
      ..product.value =
          performedProducts[RandomGenerator().integer(performedProducts.length)]
      ..storage.value = storages[0]
      ..amount = Faker().randomGenerator.integer(15, min: 1).toDouble()
      ..price = 4000 + (Faker().randomGenerator.integer(10) * 100)
      ..created = DateTime.now());
  }
}

String getNameInitials(String fullName) {
  final name = fullName.split(" ");
  String result = "";
  if (name.isNotEmpty) {
    for (int i = 0; i < name.length; i++) {
      if (i > 1) break;
      result += name[i][0].toUpperCase();
    }
  }
  return result;
}
