import 'package:cashier_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../collections/journal/journal.dart';
import '../../collections/product/product.dart';
import '../../modules/transactions/sales/sales_management_screen.dart';
import '../../states/selected_journal_provider.dart';

List<Widget> prepareJournalListTiles(
    BuildContext context, List<Journal> journals,
    [ConsumerState<ConsumerStatefulWidget>? state]) {
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
        journal: journal,
        productInReceipt: productInReceipt,
        value: value,
        state: state));
  }

  return result;
}

class ReceiptTile extends ConsumerWidget {
  const ReceiptTile({
    super.key,
    required this.journal,
    required this.productInReceipt,
    required this.value,
    this.state,
  });

  final Journal journal;
  final List<Product> productInReceipt;
  final double value;

  final ConsumerState<ConsumerStatefulWidget>? state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: ListTile(
        onTap: () {
          SelectedJournal selectedJournal = ref.watch(selectedJournalProvider);
          selectedJournal.journal = journal;
          Navigator.of(context)
              .push(
                MaterialPageRoute(
                    builder: (_) => const SalesManagementScreen()),
              )
              .then((value) => ref.invalidate(isarProvider));
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
          "${value.toStringAsFixed(0)},-",
          style: const TextStyle(fontSize: 14),
        ),
      ),
    );
  }

  void popUpDisplay(BuildContext context) {
    List<TableRow> tableData = [];
    for (var detail in journal.details) {
      tableData.add(
        TableRow(
          children: [
            TableCell(
              child: Text(
                detail.product.value?.name ?? "",
              ),
            ),
          ],
        ),
      );
      tableData.add(
        TableRow(
          children: [
            TableCell(
                child: Table(
              columnWidths: const {
                0: FlexColumnWidth(6),
                1: FlexColumnWidth(1),
                2: FlexColumnWidth(2),
                3: FlexColumnWidth(3),
              },
              children: [
                TableRow(
                  children: [
                    Text(
                      "@${detail.price.toStringAsFixed(0)},-",
                      textAlign: TextAlign.end,
                    ),
                    const TableCell(
                      child: Text(
                        "x",
                        textAlign: TextAlign.end,
                      ),
                    ),
                    Text(
                      "${detail.amount}",
                      textAlign: TextAlign.end,
                    ),
                    Text(
                      "${(detail.price * detail.amount).toStringAsFixed(0)},-",
                      textAlign: TextAlign.end,
                    ),
                  ],
                ),
              ],
            )),
          ],
        ),
      );
    }
    Table t = Table(
      children: tableData,
    );
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                journal.code,
                textAlign: TextAlign.end,
              ),
              content: t,
            ));
  }
}
