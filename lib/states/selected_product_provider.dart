import 'package:cashier_app/collections/product/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectedProduct {
  Product data = Product();
}

final selectedProductProvider =
    Provider<SelectedProduct>((_) => SelectedProduct());
