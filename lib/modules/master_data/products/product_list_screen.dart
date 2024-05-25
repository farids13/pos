import 'package:cashier_app/collections/journal/journal_detail.dart';
import 'package:cashier_app/collections/product/product.dart';
import 'package:cashier_app/commons/extensions/extensions.dart';
import 'package:cashier_app/commons/widgets/button/border_button_widget.dart';
import 'package:cashier_app/commons/widgets/text/regular_text.dart';
import 'package:cashier_app/commons/widgets/text/text.dart';
import 'package:cashier_app/main.dart';
import 'package:cashier_app/modules/master_data/products/product_detail_screen.dart';
import 'package:cashier_app/modules/master_data/products/product_management_screen.dart';
import 'package:cashier_app/utils/constants/dimens.dart';
import 'package:cashier_app/utils/constants/sizes.dart';
import 'package:cashier_app/utils/formatters/formatter.dart';
import 'package:cashier_app/utils/helpers/image_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import '../../../collections/journal/journal.dart';

part 'sections/product_item_section.dart';

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
                    padding: const EdgeInsets.all(Dimens.dp10),
                    child: BorderButton(
                      "Add Product",
                      textAlign: TextAlign.center,
                      isOutlined: true,
                      onTap: () {
                        ref.watch(productProvider.notifier).state = Product();
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const ProductManagementScreen(),
                        ));
                      },
                    ),
                  ),
                )
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
                            List<JournalDetail> journalDetails = isar
                                .journalDetails
                                .filter()
                                .journal((q) =>
                                    q.statusEqualTo(JournalStatus.posted))
                                .product((q) => q.codeEqualTo(product.code))
                                .findAllSync();

                            for (var journalDetail in journalDetails) {
                              if (incomingGoodsCollection.contains(
                                  journalDetail.journal.value?.type)) {
                              } else {}
                            }
                            return Padding(
                              padding: const EdgeInsets.all(Dimens.dp24),
                              child: Column(
                                children: [
                                  _ProductItemSection(
                                    product: product,
                                    onDelete: () {},
                                    onEdit: () async {
                                      ref
                                          .watch(productProvider.notifier)
                                          .state = product;
                                      await Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              const ProductDetailScreen(),
                                        ),
                                      );
                                    },
                                  ),
                                  const Divider(
                                    thickness: Dimens.dp10,
                                  )
                                ],
                              ),
                            );
                            // return ListTile(
                            //   title: Text(product.name),
                            //   subtitle: Text(product.code),
                            //   trailing: Text(
                            //     journalAmount.abs().toStringAsFixed(0),
                            //     style: TextStyle(
                            //         fontSize: journalAmount != 0 ? 14 : 10,
                            //         color: journalAmount < 0
                            //             ? Colors.red
                            //             : Colors.black),
                            //   ),
                            //   onTap: () async {
                            //     ref.watch(productProvider.notifier).state =
                            //         product;
                            //     await Navigator.of(context).push(
                            //       MaterialPageRoute(
                            //         builder: (_) => const ProductDetailScreen(),
                            //       ),
                            //     );
                            //   },
                            // );
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
