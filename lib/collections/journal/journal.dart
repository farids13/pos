import 'package:cashier_app/collections/journal/journal_detail.dart';
import 'package:isar/isar.dart';

part 'journal.g.dart';

@collection
class Journal {
  Journal({
    this.status = JournalStatus.opened,
    this.type = JournalType.other,
  }) {
    created = DateTime.now();
  }

  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String code;

  @enumerated
  late JournalStatus status;

  @enumerated
  late JournalType type;

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
  returning,
  stockAdjustment,
  startingStock,
  brokenProducts,
  other,
}

enum JournalStatus {
  // draft,
  opened,
  posted,
  cancelled,
}
