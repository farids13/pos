// ignore_for_file: unused_import

import 'package:cashier_app/collections/journal/journal_detail.dart';
import 'package:cashier_app/collections/product/product.dart';
import 'package:cashier_app/commons/extensions/extensions.dart';
import 'package:cashier_app/commons/widgets/button/border_button_widget.dart';
import 'package:cashier_app/commons/widgets/page/empty_page.dart';
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
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:isar/isar.dart';

import '../../../collections/journal/journal.dart';

part 'sections/product_item_section.dart';

class ProductListScreen extends ConsumerWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Isar isar = ref.watch(isarProvider);

    Future<List<Product>> products =
        isar.products.where().sortByCode().findAll();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Product List"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(QSizes.defaultSpace),
            child: BorderButton(
              "Add Product",
              prefixIcon: Iconsax.add,
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
          // ====== List View Product =====
          Expanded(
            child: FutureBuilder(
              future: products,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Product> products = snapshot.data!;
                  return products.isEmpty
                      ? const EmptyPage("No Product Yet")
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
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _ProductItemSection(
                                  product: product,
                                  onDelete: () {},
                                  onEdit: () async {
                                    ref.watch(productProvider.notifier).state =
                                        product;
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
