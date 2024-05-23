import 'package:cashier_app/collections/journal/journal.dart';
import 'package:cashier_app/main.dart';
import 'package:cashier_app/modules/transactions/receipts/sales_edit_screen.dart';
import 'package:cashier_app/states/selected_journal_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

class DashboardUtils {
  static void createNewReceipt(WidgetRef ref, BuildContext context,
      String receiptCode, JournalType journalType) {
    Isar isar = ref.watch(isarProvider);
    SelectedJournal s = ref.watch(selectedJournalProvider);
    Journal j = Journal()
      ..created = DateTime.now()
      ..code =
          "$receiptCode-${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}${DateTime.now().hour}${DateTime.now().minute}${DateTime.now().second}"
      ..journalType = journalType;

    isar.writeTxnSync(() => isar.journals.putSync(j));

    s.data = j; // Hapus setState karena ini bukan dalam StatefulWidget

    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const SalesEditScreen()),
    );
  }
}
