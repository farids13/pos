import 'package:barcode_widget/barcode_widget.dart';
import 'package:cashier_app/collections/product/product.dart';
import 'package:cashier_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductManagementScreen extends ConsumerStatefulWidget {
  const ProductManagementScreen({super.key});

  @override
  ConsumerState createState() => _ProductManagementScreenState();
}

class _ProductManagementScreenState
    extends ConsumerState<ProductManagementScreen> {
  late Product product;
  var barcode = "";

  final formKey = GlobalKey<FormState>();

  final productCodeController = TextEditingController();
  final productNameController = TextEditingController();
  final productUnitController = TextEditingController();
  final productCategoryController = TextEditingController();
  final productBarcodeController = TextEditingController();
  final productDescriptionController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    product = ref.watch(productProvider);

    barcode = product.barcode;

    productCodeController.text = product.code;
    productNameController.text = product.name;
    productUnitController.text = product.unit;
    productCategoryController.text = product.category;
    productBarcodeController.text = product.barcode;
    productDescriptionController.text = product.description;
  }

  @override
  Widget build(BuildContext context) {
    final isNewProduct = product.name == "" && product.code == "";

    var primaryColor = Theme.of(context).colorScheme.primary;
    var errorColor = Theme.of(context).colorScheme.error;

    return Scaffold(
      appBar: AppBar(
        title: Text(isNewProduct ? "Create Product" : "Edit Product"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: productNameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Product name required";
                    }
                    return null;
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: productCodeController,
                        decoration:
                            const InputDecoration(labelText: 'Product Code'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Product code required";
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 32.0),
                    Expanded(
                      child: TextFormField(
                        controller: productUnitController,
                        decoration: const InputDecoration(labelText: 'Unit'),
                      ),
                    ),
                  ],
                ),
                TextFormField(
                  controller: productCategoryController,
                  decoration: const InputDecoration(labelText: 'Category'),
                ),
                const SizedBox(height: 24.0),
                TextFormField(
                  controller: productDescriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
                const SizedBox(height: 24.0),
                BarcodeWidget(
                  data: barcode,
                  barcode: Barcode.code128(),
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  controller: productBarcodeController,
                  decoration: const InputDecoration(
                    labelText: 'Barcode',
                  ),
                  validator: (value) {
                    if (value != null &&
                        value != "" &&
                        double.tryParse(value) == null) {
                      return "Product barcode must be numeric.";
                    }
                    return null;
                  },
                  onChanged: (event) {
                    setState(() {
                      barcode = event;
                    });
                  },
                ),
                const SizedBox(height: 24.0),
                isNewProduct
                    ? const SizedBox(height: 0.0)
                    : TextButton(
                        style: TextButton.styleFrom(
                          side: BorderSide(width: 1, color: errorColor),
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            Navigator.of(context).pop();
                          }
                        },
                        child: Text('Disable',
                            style: TextStyle(color: errorColor)),
                      ),
                isNewProduct
                    ? const SizedBox(height: 0.0)
                    : const SizedBox(height: 8.0),
                TextButton(
                  style: TextButton.styleFrom(
                    side: BorderSide(width: 1, color: primaryColor),
                  ),
                  onPressed: () {
                    var isar = ref.watch(isarProvider);
                    if (formKey.currentState!.validate()) {
                      product.name = productNameController.text;
                      product.code = productCodeController.text;
                      product.unit = productUnitController.text;
                      product.category = productCategoryController.text;
                      product.barcode = productBarcodeController.text;
                      product.description = productDescriptionController.text;

                      isar.writeTxnSync(() async {
                        isar.products.putSync(product);
                      });

                      ref.invalidate(productProvider);
                      ref.watch(productProvider.notifier).state = product;
                      ref.invalidate(isarProvider);

                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
