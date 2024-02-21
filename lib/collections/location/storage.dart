import 'package:cashier_app/collections/location/location.dart';
import 'package:isar/isar.dart';

part 'storage.g.dart';

@collection
class Storage {
  Storage({this.name = ''}) {
    created = DateTime.now();
  }

  Id id = Isar.autoIncrement;
  final location = IsarLink<Location>();
  late String name;
  late DateTime created;
}
