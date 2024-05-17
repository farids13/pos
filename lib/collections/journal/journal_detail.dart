import 'package:cashier_app/collections/location/storage.dart';
import 'package:cashier_app/collections/product/product.dart';
import 'package:isar/isar.dart';

import 'journal.dart';

part 'journal_detail.g.dart';

@collection
class JournalDetail {
  JournalDetail({this.amount = 0, this.price = 0, this.additionalData = "{}"}) {
    created = DateTime.now();
  }

  Id id = Isar.autoIncrement;

  final journal = IsarLink<Journal>();

  final product = IsarLink<Product>();
  final storage = IsarLink<Storage>();

  late double amount;
  late double price;

  late String additionalData;

  late DateTime created;

  @override
  String toString() {
    return '${product.value?.name} | $amount | Rp.$price | $additionalData';
  }
}
