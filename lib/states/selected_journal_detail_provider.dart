import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../collections/journal/journal_detail.dart';

class SelectedJournalDetail {
  JournalDetail? data;
}

final selectedJournalDetailProvider =
    Provider<SelectedJournalDetail>((_) => SelectedJournalDetail());
