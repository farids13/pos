import 'package:cashier_app/collections/location/storage.dart';
import 'package:isar/isar.dart';

part 'location.g.dart';

@collection
class Location {
  Location({this.name = '', this.address = ''}) {
    created = DateTime.now();
  }

  Id id = Isar.autoIncrement;

  late String name;
  late String address;
  late DateTime created;

  @Backlink(to: 'location')
  final storages = IsarLinks<Storage>();
}
