import 'package:cashier_app/collections/journal/journal_detail.dart';
import 'package:cashier_app/collections/product/product.dart';
import 'package:cashier_app/main.dart';
import 'package:cashier_app/modules/master_data/products/product_management_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import '../../../collections/journal/journal.dart';

class ProductListScreen extends ConsumerWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // get all products
    Isar isar = ref.watch(isarProvider);

    Future<List<Product>> products =
        isar.products.where().sortByCode().findAll();

    var primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Product List"),
        actions: [
          CloseButton(
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
      body: Column(
        children: [

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        side: BorderSide(width: 1, color: primaryColor),
                      ),
                      onPressed: () {},
                      child: const Text("Add New Product"),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: products,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Product> products = snapshot.data!;
                  return products.isEmpty
                      ? const Center(child: Text('Empty'))
                      : ListView.builder(
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            Product product = products[index];
                            List<JournalDetail> journalDetails = isar.journalDetails
                                .filter()
                                .product((q) => q.codeEqualTo(product.code))
                                .findAllSync();
                            var journalAmount = 0.0;
                            for (var journalDetail in journalDetails) {
                              if (incomingGoodsCollection.contains(
                                  journalDetail.journal.value?.journalType)) {
                                journalAmount += journalDetail.amount;
                              } else {
                                journalAmount -= journalDetail.amount;
                              }
                            }
                            return ListTile(
                              title: Text(product.name),
                              subtitle: Text(product.code),
                              trailing: Text(
                                journalAmount.abs().toStringAsFixed(0),
                                style: TextStyle(
                                    fontSize: journalAmount != 0 ? 14 : 10,
                                    color: journalAmount < 0
                                        ? Colors.red
                                        : Colors.black),
                              ),
                              onTap: () async {
                                ref.watch(productProvider.notifier).state = product;
                                await Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => const ProductManagementScreen(),
                                  ),
                                );
                              },
                            );
                          },
                        );
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error.toString()}");
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
