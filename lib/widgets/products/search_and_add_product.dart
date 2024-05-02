import 'dart:async';

import 'package:cashier_app/collections/journal/journal_detail.dart';
import 'package:cashier_app/collections/product/product.dart';
import 'package:cashier_app/collections/product/product_price.dart';
import 'package:cashier_app/modules/transactions/receipts/quantity_and_value_popup.dart';
import 'package:cashier_app/states/selected_journal_detail_provider.dart';
import 'package:cashier_app/states/selected_journal_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';

import '../../main.dart';
import '../../states/selected_product_provider.dart';

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
        title: _buildSearchField(),
        actions: _buildActions(),
      ),
      body: Center(child: ListView(children: _buildList())),
    );
  }

  List<Widget> _buildList() {
    List<Widget> items = [];
    for (var product in products) {
      var price = isar?.productPrices
              .filter()
              .product((q) => q.codeEqualTo(product.code))
              .findFirstSync()
              ?.price ??
          0;
      items.add(
        ListTile(
          title: Text(product.name),
          subtitle: Text(product.code),
          trailing: Text("@Rp.${numberFormat.format(price)}"),
          onTap: () {
            setState(() {
              selectedProduct.data = product;
              selectedJournalDetail.data = JournalDetail();
            });
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return const QuantityAndValuePopup();
                // return productDetailInputForm(
                //   context: context,
                //   product: product,
                // );
              },
            );
          },
        ),
      );
    }
    if (items.isEmpty) {
      items.add(
        const ListTile(
          title: Center(
            child: Text("No product found"),
          ),
        ),
      );
    }
    return items;
  }

  // Widget productDetailInputForm(
  //     {required BuildContext context, required Product product, JournalDetail? journalDetail}) {
  //   final formKey = GlobalKey<FormState>();
  //
  //   var selectedJournal = ref.watch(selectedJournalProvider);
  //
  //   var productPrice = isar?.productPrices
  //       .filter()
  //       .product((q) => q.codeEqualTo(product.code))
  //       .sortByCreatedDesc()
  //       .findFirstSync();
  //
  //   var itemPrice = productPrice?.price ?? 0;
  //
  //   final priceController = TextEditingController();
  //   final quantityController = TextEditingController();
  //   final totalController = TextEditingController();
  //   final sellPriceController = TextEditingController();
  //
  //   priceController.text = "$itemPrice";
  //
  //   bool priceReadOnly = false;
  //   bool totalReadOnly = false;
  //
  //   bool withPrice = false;
  //   bool withTotal = false;
  //   bool withSellingPrice = false;
  //
  //   List<Widget> fields = [];
  //
  //   switch (selectedJournal.data.journalType) {
  //     case JournalType.incoming:
  //     case JournalType.outgoing:
  //     case JournalType.stockAdjustment:
  //     case JournalType.sale:
  //       withPrice = withTotal = false;
  //       break;
  //     case JournalType.startingStock:
  //     case JournalType.purchase:
  //       withPrice = withTotal = true;
  //       priceReadOnly = totalReadOnly = false;
  //       withSellingPrice = true;
  //       break;
  //     default:
  //       break;
  //   }
  //
  //   // Quantity
  //   fields.add(TextFormField(
  //     autofocus: true,
  //     controller: quantityController,
  //     keyboardType: TextInputType.number,
  //     decoration: const InputDecoration(
  //       labelText: "Quantity",
  //     ),
  //     onChanged: (event) {
  //       var price = priceController.text;
  //       var quantity = quantityController.text;
  //       if (![double.infinity, double.nan, null]
  //               .contains(double.tryParse(price)) &&
  //           ![double.infinity, double.nan, null]
  //               .contains(double.tryParse(quantity))) {
  //         var total = double.parse(price) * double.parse(quantity);
  //         totalController.text = total.toString();
  //       }
  //     },
  //     validator: (value) {
  //       if (value == null ||
  //           value.isEmpty ||
  //           [double.infinity, double.nan, null]
  //               .contains(double.tryParse(value))) {
  //         return "Please enter quantity";
  //       }
  //       return null;
  //     },
  //   ));
  //
  //   // Item Price
  //   fields.add(TextFormField(
  //     controller: priceController,
  //     readOnly: priceReadOnly,
  //     enabled: withPrice,
  //     keyboardType: TextInputType.number,
  //     decoration: const InputDecoration(
  //       labelText: "Price",
  //     ),
  //     onChanged: (event) {
  //       var price = priceController.text;
  //       var quantity = quantityController.text;
  //       if (![double.infinity, double.nan, null]
  //               .contains(double.tryParse(price)) &&
  //           ![double.infinity, double.nan, null]
  //               .contains(double.tryParse(quantity))) {
  //         var total = double.parse(price) * double.parse(quantity);
  //         totalController.text = total.toString();
  //       }
  //     },
  //     validator: (value) {
  //       if (value == null ||
  //           value.isEmpty ||
  //           [double.infinity, double.nan, null]
  //               .contains(double.tryParse(value))) {
  //         return "Please enter item price";
  //       }
  //       return null;
  //     },
  //   ));
  //
  //   // Total Price
  //   fields.add(TextFormField(
  //     controller: totalController,
  //     readOnly: totalReadOnly,
  //     enabled: withTotal,
  //     keyboardType: TextInputType.number,
  //     decoration: const InputDecoration(
  //       labelText: "Total",
  //     ),
  //     onChanged: (event) {
  //       var total = totalController.text;
  //       var quantity = quantityController.text;
  //       if (![double.infinity, double.nan, null]
  //               .contains(double.tryParse(total)) &&
  //           ![double.infinity, double.nan, null]
  //               .contains(double.tryParse(quantity))) {
  //         var price = double.parse(total) / double.parse(quantity);
  //         priceController.text = price.toString();
  //       }
  //     },
  //     validator: (value) {
  //       if (value == null ||
  //           value.isEmpty ||
  //           [double.infinity, double.nan, null]
  //               .contains(double.tryParse(value))) {
  //         return "Please enter total amount for this item";
  //       }
  //       return null;
  //     },
  //   ));
  //
  //   // Selling Price
  //   if (withSellingPrice) {
  //     fields.add(TextFormField(
  //       controller: sellPriceController,
  //       keyboardType: TextInputType.number,
  //       decoration: const InputDecoration(
  //         labelText: "Selling Price",
  //       ),
  //       validator: (value) {
  //         if (value == null ||
  //             value.isEmpty ||
  //             [double.infinity, double.nan, null]
  //                 .contains(double.tryParse(value))) {
  //           return "Please enter selling price for this item";
  //         }
  //         return null;
  //       },
  //     ));
  //   }
  //
  //   List<Widget> dialogTitle = [
  //     Text(product.name),
  //     Text(
  //       product.code,
  //       style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 12),
  //     ),
  //   ];
  //
  //   if (selectedJournal.data.journalType == JournalType.incoming) {
  //     dialogTitle.add(
  //       TextButton(
  //         onPressed: () {
  //           showDialog(
  //             context: context,
  //             builder: (BuildContext context) {
  //               return AlertDialog(
  //                 content: const Column(
  //                   children: [
  //                     Text(
  //                       "Product Details",
  //                       style: TextStyle(
  //                         fontSize: 20,
  //                       ),
  //                     ),
  //                     Text("Rp. 2500"),
  //                   ],
  //                 ),
  //                 actions: [
  //                   TextButton(
  //                     child: const Text("OK"),
  //                     onPressed: () => Navigator.of(context).pop(),
  //                   ),
  //                 ],
  //               );
  //             },
  //           );
  //         },
  //         child: const Center(
  //           child: Text("View Prices"),
  //         ),
  //       ),
  //     );
  //   }
  //
  //   return AlertDialog(
  //     title: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: dialogTitle,
  //     ),
  //     content: Form(
  //       key: formKey,
  //       child: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: fields,
  //       ),
  //     ),
  //     actions: [
  //       TextButton(
  //         child: const Text("Cancel"),
  //         onPressed: () {
  //           Navigator.of(context).pop();
  //         },
  //       ),
  //       TextButton(
  //         child: const Text("OK"),
  //         onPressed: () {
  //           if (formKey.currentState!.validate()) {
  //             var amount = double.parse(quantityController.text);
  //             var price = isar?.productPrices
  //                     .filter()
  //                     .product((p) => p.idEqualTo(product.id))
  //                     .sortByCreatedDesc()
  //                     .findFirstSync()
  //                     ?.price ??
  //                 0;
  //             Journal j = selectedJournal.data;
  //             setState(() {
  //               if(journalDetail == null) {
  //                 JournalDetail jd = JournalDetail()
  //                   ..journal.value = selectedJournal.data
  //                   ..product.value = product
  //                   ..amount = amount
  //                   ..price = price;
  //                 j.details.add(jd);
  //                 isar?.writeTxnSync(() => j.details.saveSync());
  //               }
  //               else{
  //                 journalDetail.amount = amount;
  //                 journalDetail.price = price;
  //                 isar?.writeTxnSync(() => isar?.journalDetails.putSync(journalDetail));
  //               }
  //               selectedJournal.data = j;
  //             });
  //             ref.invalidate(isarProvider);
  //             Navigator.of(context).pop();
  //           }
  //         },
  //       ),
  //     ],
  //   );
  // }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchQueryController,
      autofocus: true,
      decoration: const InputDecoration(
        hintText: "Product Name...",
        border: InputBorder.none,
      ),
      onChanged: (query) => _onSearchChanged(query),
    );
  }

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
