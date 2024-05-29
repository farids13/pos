import 'dart:convert';

import 'package:cashier_app/collections/product/product_price.dart';
import 'package:cashier_app/states/selected_product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import '../../collections/journal/journal.dart';
import '../../collections/journal/journal_detail.dart';
import '../../collections/product/product.dart';
import '../../main.dart';
import '../../states/selected_journal_detail_provider.dart';
import '../../states/selected_journal_provider.dart';

class QuantityAndValuePopup extends ConsumerStatefulWidget {
  const QuantityAndValuePopup({super.key});

  @override
  ConsumerState createState() => _QuantityAndValuePopupState();
}

class _QuantityAndValuePopupState extends ConsumerState<QuantityAndValuePopup> {
  late Product product;
  late SelectedJournal selectedJournal;
  late SelectedJournalDetail selectedJournalDetail;
  late SelectedProduct selectedProduct;
  late Isar isar;

  @override
  Widget build(BuildContext context) {
    selectedJournal = ref.watch(selectedJournalProvider);
    selectedJournalDetail = ref.watch(selectedJournalDetailProvider);
    selectedProduct = ref.watch(selectedProductProvider);

    isar = ref.watch(isarProvider);

    product = selectedProduct.data;

    JournalDetail? journalDetail = selectedJournalDetail.data;

    return productDetailInputForm(
        context: context, product: product, journalDetail: journalDetail);
  }

  Widget productDetailInputForm({
    required BuildContext context,
    required Product product,
    JournalDetail? journalDetail,
  }) {
    final formKey = GlobalKey<FormState>();

    var itemPrice = double.nan;

    var productPrice = isar.productPrices
        .filter()
        .product((q) => q.codeEqualTo(product.code))
        .sortByCreatedDesc()
        .findFirstSync();

    if (selectedJournal.data.type == JournalType.sale) {
      itemPrice = productPrice?.price ?? 0;
    } else {
      itemPrice = journalDetail?.price ?? 0;
    }

    final priceController = TextEditingController();
    final quantityController = TextEditingController();
    final totalController = TextEditingController();
    final sellPriceController = TextEditingController();

    priceController.text = "$itemPrice";
    sellPriceController.text = (productPrice?.price ?? 0).toString();

    bool priceReadOnly = false;
    bool totalReadOnly = false;

    bool withPrice = false;
    bool withTotal = false;
    bool withSellingPrice = false;

    List<Widget> fields = [];

    switch (selectedJournal.data.type) {
      case JournalType.outgoing:
      case JournalType.stockAdjustment:
      case JournalType.sale:
        withPrice = withTotal = false;
        break;
      case JournalType.startingStock:
      case JournalType.incoming:
      case JournalType.purchase:
        withPrice = withTotal = true;
        priceReadOnly = totalReadOnly = false;
        withSellingPrice = true;
        break;
      default:
        break;
    }

    // Quantity
    fields.add(TextFormField(
      autofocus: true,
      controller: quantityController,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        labelText: "Quantity",
      ),
      onChanged: (event) {
        onQuantityChange(priceController, quantityController, totalController);
      },
      validator: (value) {
        if (value == null ||
            value.isEmpty ||
            [double.infinity, double.nan, null]
                .contains(double.tryParse(value))) {
          return "Please enter quantity with decimal value";
        }
        return null;
      },
    ));

    // Item Price
    fields.add(TextFormField(
      controller: priceController,
      readOnly: priceReadOnly,
      enabled: withPrice,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        labelText: "Price",
      ),
      onChanged: (event) {
        onQuantityChange(priceController, quantityController, totalController);
      },
      validator: (value) {
        if (value == null ||
            value.isEmpty ||
            [double.infinity, double.nan, null]
                .contains(double.tryParse(value))) {
          return "Please enter item price with decimal value";
        }
        return null;
      },
    ));

    // Total Price
    fields.add(TextFormField(
      controller: totalController,
      readOnly: totalReadOnly,
      enabled: withTotal,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        labelText: "Total",
      ),
      onChanged: (event) {
        var total = totalController.text;
        var quantity = quantityController.text;
        if (![double.infinity, double.nan, null]
                .contains(double.tryParse(total)) &&
            ![double.infinity, double.nan, null]
                .contains(double.tryParse(quantity))) {
          var price = double.parse(total) / double.parse(quantity);
          priceController.text = price.toString();
        }
      },
      validator: (value) {
        if (value == null ||
            value.isEmpty ||
            [double.infinity, double.nan, null]
                .contains(double.tryParse(value))) {
          return "Please enter total amount for this item with decimal value";
        }
        return null;
      },
    ));

    // Selling Price
    if (withSellingPrice) {
      fields.add(TextFormField(
        controller: sellPriceController,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          labelText: "Selling Price",
        ),
        validator: (value) {
          if (value == null ||
              value.isEmpty ||
              [double.infinity, double.nan, null]
                  .contains(double.tryParse(value))) {
            return "Please enter selling price for this item with decimal value";
          }
          return null;
        },
      ));
    }

    List<Widget> dialogTitle = [
      Text(product.name),
      Text(
        product.code,
        style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 12),
      ),
    ];

    if (selectedJournal.data.type == JournalType.incoming) {
      dialogTitle.add(
        TextButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text(
                    "Product Details",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  content: const SingleChildScrollView(
                    child: Column(
                      children: [
                        Text("TODO: Display price history here"),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      child: const Text("OK"),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                );
              },
            );
          },
          child: const Center(
            child: Text("View Prices"),
          ),
        ),
      );
    }

    if (journalDetail != null) {
      quantityController.text = journalDetail.amount.toString();
      onQuantityChange(priceController, quantityController, totalController);
    }

    return AlertDialog(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: dialogTitle,
      ),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: fields,
        ),
      ),
      actions: [
        TextButton(
          child: const Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text("OK"),
          onPressed: () {
            storeForm(
              formKey,
              quantityController,
              priceController,
              sellPriceController,
              product,
              journalDetail,
              context,
            );
          },
        ),
      ],
    );
  }

  void storeForm(
      GlobalKey<FormState> formKey,
      TextEditingController quantityController,
      TextEditingController priceController,
      TextEditingController sellPriceController,
      Product product,
      JournalDetail? journalDetail,
      BuildContext context) {
    if (formKey.currentState!.validate()) {
      var amount = double.parse(quantityController.text);

      var price = double.nan;

      if (selectedJournal.data.type == JournalType.sale) {
        price = isar.productPrices
                .filter()
                .product((p) => p.idEqualTo(product.id))
                .sortByCreatedDesc()
                .findFirstSync()
                ?.price ??
            0;
      } else {
        price = double.parse(priceController.text);
      }

      Journal j = selectedJournal.data;

      setState(() {
        double sellPrice = double.nan;
        if (incomingGoodsCollection.contains(selectedJournal.data.type) &&
            sellPriceController.text.isNotEmpty) {
          sellPrice = double.parse(sellPriceController.text);
        }

        if (journalDetail == null || journalDetail.journal.value == null) {
          JournalDetail jd = JournalDetail()
            ..journal.value = selectedJournal.data
            ..product.value = product
            ..amount = amount
            ..price = price;
          addJournalDetailAdditionalData(sellPrice, jd);
          j.details.add(jd);
          isar.writeTxnSync(() => j.details.saveSync());
        } else {
          journalDetail.amount = amount;
          journalDetail.price = price;
          addJournalDetailAdditionalData(sellPrice, journalDetail);
          isar.writeTxnSync(() => isar.journalDetails.putSync(journalDetail));
        }
        selectedJournal.data = j;
      });
      ref.invalidate(isarProvider);
      Navigator.of(context).pop();
    }
  }

  void addJournalDetailAdditionalData(double sellPrice, JournalDetail jd) {
    if (!sellPrice.isNaN) {
      var additionalDataKey = "selling_price";
      updateAdditionalData(jd, additionalDataKey, sellPrice);
      Product p = jd.product.value!;
      ProductPrice pp = ProductPrice()
        ..product.value = p
        ..price = sellPrice;
      isar.writeTxnSync(() => isar.productPrices.putSync(pp));
    }
  }

  void updateAdditionalData(
      JournalDetail jd, String additionalDataKey, Object sellPrice) {
    var additionalData = jsonDecode(jd.additionalData);
    additionalData[additionalDataKey] = sellPrice;
    jd.additionalData = jsonEncode(additionalData);
  }

  void onQuantityChange(
      TextEditingController priceController,
      TextEditingController quantityController,
      TextEditingController totalController) {
    var price = priceController.text;
    var quantity = quantityController.text;
    if (![double.infinity, double.nan, null].contains(double.tryParse(price)) &&
        ![double.infinity, double.nan, null]
            .contains(double.tryParse(quantity))) {
      var total = double.parse(price) * double.parse(quantity);
      totalController.text = total.toString();
    }
  }
}
