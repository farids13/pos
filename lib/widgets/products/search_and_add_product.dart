import 'dart:async';

import 'package:cashier_app/collections/journal/journal_detail.dart';
import 'package:cashier_app/collections/product/product.dart';
import 'package:cashier_app/collections/product/product_price.dart';
import 'package:cashier_app/widgets/general_widgets/quantity_and_value_popup.dart';
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
