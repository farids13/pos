import 'package:cashier_app/collections/journal/journal.dart';
import 'package:cashier_app/collections/journal/journal_detail.dart';
import 'package:cashier_app/collections/product/product.dart';
import 'package:cashier_app/modules/master_data/products/product_management_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';

import '../../../main.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductDetailScreen();
}

class _ProductDetailScreen extends ConsumerState<ProductDetailScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var product = ref.watch(productProvider);
    var price = product.prices.isNotEmpty ? product.prices.last.price : 0.0;
    var isar = ref.read(isarProvider);

    var journalDetails = isar.journalDetails
        .where()
        .filter()
        .journal((q) => q.statusEqualTo(JournalStatus.posted))
        .product((q) => q.codeEqualTo(product.code))
        .findAllSync();

    journalDetails.sort(
      (a, b) {
        var now = DateTime.now();
        var ja = b.journal.value?.created ?? now;
        var jb = a.journal.value?.created ?? now;
        return ja.compareTo(jb);
      },
    );

    var journals = journalDetails.map(
      (journalDetail) => ListTile(
        tileColor: incomingGoodsCollection
                .contains(journalDetail.journal.value?.type)
            ? Theme.of(context).colorScheme.secondary.withOpacity(0.1)
            : Theme.of(context).colorScheme.inversePrimary.withOpacity(0.25),
        title: Text("${journalDetail.journal.value?.code}"),
        subtitle: Text(DateFormat('yyyy-MM-dd kk:mm')
            .format(journalDetail.journal.value!.created)),
        trailing: Text(
          "${(journalDetail.amount).toStringAsFixed(0)} item(s)",
          style: TextStyle(
            fontSize: 14,
            color: incomingGoodsCollection
                    .contains(journalDetail.journal.value?.type)
                ? Colors.black
                : Colors.red,
          ),
        ),
      ),
    );

    var journalAmount = 0.0;
    for (var journalDetail in journalDetails) {
      if (incomingGoodsCollection.contains(journalDetail.journal.value?.type)) {
        journalAmount += journalDetail.amount;
      } else {
        journalAmount -= journalDetail.amount;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(product.code),
        actions: [
          IconButton(
              icon: const Icon(Icons.edit_outlined),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const ProductManagementScreen(),
                  ),
                );
              }),
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(
              product.name,
              style: const TextStyle(
                fontSize: 24,
              ),
            ),
            subtitle: Text("@Rp$price"),
            trailing: Text(
              "${journalAmount.toStringAsFixed(0)} item(s)",
              style: TextStyle(
                fontWeight: FontWeight.normal,
                color: journalAmount < 0.0 ? Colors.red : Colors.black,
                fontSize: 24,
              ),
            ),
          ),
          const Divider(),
        ].followedBy(journals).toList(),
      ),
    );
  }
}
