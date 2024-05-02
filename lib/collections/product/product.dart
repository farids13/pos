import 'package:cashier_app/collections/product/product_price.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

part 'product.g.dart';

final _product = Product();

final productProvider = StateProvider<Product>((ref) => _product);

@collection
class Product {
  Product({
    this.code = '',
    this.name = '',
    this.unit = '',
    this.category = '',
    this.barcode = '',
    this.description = '',
  });

  Id id = Isar.autoIncrement;
  @Index(unique: true)
  late String code;
  late String name;

  late String unit;
  late String category;
  late String barcode;

  late String description;

  @Backlink(to: 'product')
  final prices = IsarLinks<ProductPrice>();
}
