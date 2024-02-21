import 'package:cashier_app/collections/journal/journal_detail.dart';
import 'package:isar/isar.dart';

part 'journal.g.dart';

@collection
class Journal {
  Journal({this.journalStatus = JournalStatus.opened}) {
    created = DateTime.now();
  }

  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String code;

  @enumerated
  late JournalStatus journalStatus;

  @enumerated
  late JournalType journalType;

  @Backlink(to: 'journal')
  final details = IsarLinks<JournalDetail>();

  late DateTime created;
}

List<JournalType> incomingGoodsCollection = [
  JournalType.startingStock,
  JournalType.incoming,
  JournalType.purchase,
];

enum JournalType {
  purchase,
  sale,
  incoming,
  outgoing,
  stockAdjustment,
  startingStock,
}

enum JournalStatus {
  opened,
  posted,
  cancelled,
}
