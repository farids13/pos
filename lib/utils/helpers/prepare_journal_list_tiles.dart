import 'package:cashier_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../collections/journal/journal.dart';
import '../../collections/product/product.dart';
import '../../modules/transactions/receipts/sales_edit_screen.dart';
import '../../states/selected_journal_provider.dart';

List<Widget> prepareJournalListTiles(
    BuildContext context, List<Journal> journals) {
  List<Widget> result = [];

  for (var journal in journals) {
    var value = 0.0;
    List<Product> productInReceipt = [];
    journal.details.loadSync();
    for (var detail in journal.details) {
      if (detail.product.value != null &&
          !productInReceipt
              .any((item) => item.id == detail.product.value?.id)) {
        productInReceipt.add(detail.product.value!);
      }
      value += detail.price * detail.amount;
    }
    productInReceipt = productInReceipt.toSet().toList();
    result.add(ReceiptTile(
        journal: journal, productInReceipt: productInReceipt, value: value));
  }

  return result;
}

class ReceiptTile extends ConsumerWidget {
  const ReceiptTile({
    super.key,
    required this.journal,
    required this.productInReceipt,
    required this.value,
  });

  final Journal journal;
  final List<Product> productInReceipt;
  final double value;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    NumberFormat numberFormat = NumberFormat("#,##0.00", "en_US");
    return Card(
      child: ListTile(
        onTap: () {
          SelectedJournal selectedJournal = ref.watch(selectedJournalProvider);
          selectedJournal.data = journal;
          Navigator.of(context)
              .push(
            MaterialPageRoute(builder: (_) => const SalesEditScreen()),
          )
              .then((value) {
            if (context.mounted) {
              ref.invalidate(isarProvider);
            }
          });
        },
        title: Text(journal.code),
        subtitle: Row(
          children: [
            Flexible(
              child: Text(
                  "${DateFormat('yyyy/MM/dd kk:mm').format(journal.created)} | ${productInReceipt.length} product in receipt"),
            ),
          ],
        ),
        trailing: Text(
          numberFormat.format(value),
          style: const TextStyle(fontSize: 14),
        ),
        leading: Icon(
          journal.status == JournalStatus.posted
              ? Icons.receipt_long_rounded
              : Icons.edit_outlined,
          color: journal.status == JournalStatus.posted
              ? Colors.grey
              : Colors.black,
        ),
      ),
    );
  }
}
