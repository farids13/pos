import 'package:cashier_app/collections/journal/journal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectedJournal {
  Journal journal = Journal();
}

final selectedJournalProvider =
    Provider<SelectedJournal>((_) => SelectedJournal());
