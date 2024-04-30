import 'package:cashier_app/collections/product/product_price.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

part 'product.g.dart';

final _product = Product();

final productProvider = StateProvider<Product>((ref) => _product);

@collection
class Product {
  Product({this.name = ''});

  Id id = Isar.autoIncrement;
  @Index(unique: true)
  late String code;
  late String name;

  @Backlink(to: 'product')
  final prices = IsarLinks<ProductPrice>();
}
