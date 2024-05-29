import 'dart:async';

import 'package:cashier_app/collections/journal/journal_detail.dart';
import 'package:cashier_app/collections/product/product.dart';
import 'package:cashier_app/collections/product/product_price.dart';
import 'package:cashier_app/commons/widgets/input/search_input.dart';
import 'package:cashier_app/commons/widgets/page/empty_page.dart';
import 'package:cashier_app/modules/master_data/products/widget/list_product_widget.dart';
import 'package:cashier_app/states/selected_journal_detail_provider.dart';
import 'package:cashier_app/states/selected_journal_provider.dart';
import 'package:cashier_app/utils/constants/dimens.dart';
import 'package:cashier_app/utils/constants/sizes.dart';
import 'package:cashier_app/widgets/general_widgets/quantity_and_value_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';

import '../../../../main.dart';
import '../../../../states/selected_product_provider.dart';

class SearchAndAddProduct extends ConsumerStatefulWidget {
  const SearchAndAddProduct({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchAndAddProduct();
}

class _SearchAndAddProduct extends ConsumerState<SearchAndAddProduct> {
  Timer? _debounceTimer;
  final int _debounceTime = 500;

  Isar? isar;

  final TextEditingController _searchQueryController = TextEditingController();
  List<Product> products = [];

  NumberFormat numberFormat = NumberFormat("#,##0.00", "en_US");
  late SelectedJournal selectedJournal;
  late SelectedJournalDetail selectedJournalDetail;
  late SelectedProduct selectedProduct;

  @override
  Widget build(BuildContext context) {
    isar = ref.watch(isarProvider);

    selectedJournal = ref.watch(selectedJournalProvider);
    selectedProduct = ref.watch(selectedProductProvider);
    selectedJournalDetail = ref.watch(selectedJournalDetailProvider);

    updateSearchQuery(_searchQueryController.text);
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text("Select Product"),
        actions: _buildActions(),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(Dimens.dp20),
            child: SearchTextInput(
              controller: _searchQueryController,
              hintText: 'Search by product name...',
              onChanged: (query) => _onSearchChanged(query),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                if (products.isEmpty)
                  const EmptyPage("No product found")
                else
                  ...products.map(
                    (e) => Padding(
                      padding: const EdgeInsets.all(Dimens.dp10),
                      child: ListProductWidget(
                        product: e,
                        onDelete: () {},
                        onEdit: () {
                          setState(() {
                            selectedProduct.data = e;
                            selectedJournalDetail.data = JournalDetail();
                          });
                          showDialog(
                            context: context,
                            builder: (context) => const QuantityAndValuePopup(),
                          );
                        },
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // List<Widget> _buildList() {
  //   List<Widget> items = [];
  //   for (var product in products) {
  //     var price = isar?.productPrices
  //             .filter()
  //             .product((q) => q.codeEqualTo(product.code))
  //             .sortByCreatedDesc()
  //             .findFirstSync()
  //             ?.price ??
  //         0;
  //     items.add(Padding(
  //       padding: const EdgeInsets.all(Dimens.dp10),
  //       child:
  //           ListProductWidget(product: product, onDelete: () {}, onEdit: () {}),
  //     ));
  //   }
  //   if (items.isEmpty) {
  //     items.add(
  //       const ListTile(
  //         title: Center(
  //           child: Text("No product found"),
  //         ),
  //       ),
  //     );
  //   }
  //   return items;
  // }

  // Widget _buildSearchField() {
  //   return Column(
  //     children: [
  //       Text("Select Product"),
  //       TextField(
  //         controller: _searchQueryController,
  //         autofocus: true,
  //         decoration: const InputDecoration(
  //           hintText: "Product Name...",
  //           border: InputBorder.none,
  //         ),
  //         onChanged: (query) => _onSearchChanged(query),
  //       ),
  //     ],
  //   );
  // }

  _onSearchChanged(String query) {
    if (_debounceTimer?.isActive ?? false) _debounceTimer?.cancel();
    _debounceTimer = Timer(Duration(milliseconds: _debounceTime), () {
      updateSearchQuery(query);
    });
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  List<Widget> _buildActions() {
    return <Widget>[
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          if (_searchQueryController.text.isEmpty) {
            Navigator.pop(context);
            return;
          }
          _clearSearchQuery();
        },
      ),
    ];
  }

  void updateSearchQuery(String query) {
    setState(() {
      products = isar?.products
              .filter()
              .nameContains(query, caseSensitive: false)
              .sortByCode()
              .findAllSync() ??
          [];
    });
  }

  void _clearSearchQuery() {
    setState(() {
      _searchQueryController.clear();
      updateSearchQuery("");
    });
  }
}
