import 'package:cashier_app/collections/product/product.dart';
import 'package:isar/isar.dart';

part 'product_price.g.dart';

@collection
class ProductPrice {
  ProductPrice({this.price = 0}) {
    created = DateTime.now();
  }

  Id id = Isar.autoIncrement;
  final product = IsarLink<Product>();
  late double price;
  late DateTime created;
}
