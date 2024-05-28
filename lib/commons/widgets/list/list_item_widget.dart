import 'package:cashier_app/collections/journal/journal.dart';
import 'package:cashier_app/commons/extensions/extensions.dart';
import 'package:cashier_app/commons/widgets/text/regular_text.dart';
import 'package:cashier_app/main.dart';
import 'package:cashier_app/modules/transactions/receipts/sales_edit_screen.dart';
import 'package:cashier_app/states/selected_journal_provider.dart';
import 'package:cashier_app/utils/constants/constant.dart';
import 'package:cashier_app/utils/constants/dimens.dart';
import 'package:cashier_app/utils/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

part 'section/status_section.dart';

class ListItem extends ConsumerStatefulWidget {
  final Journal journal;
  const ListItem(this.journal, {super.key});

  @override
  ConsumerState<ListItem> createState() => ListItemSection();
}

class ListItemSection extends ConsumerState<ListItem> {
  @override
  Widget build(BuildContext context) {
    final formatCurrency =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

    String total = widget.journal.details.isEmpty
        ? '0'
        : formatCurrency.format(widget.journal.details
            .map((e) => e.price * e.amount)
            .reduce((v, e) => v + e));

    return InkWell(
      onTap: () {
        SelectedJournal selectedJournal = ref.watch(selectedJournalProvider);
        selectedJournal.data = widget.journal;
        Navigator.of(context)
            .push(
              MaterialPageRoute(builder: (_) => const SalesEditScreen()),
            )
            .then((value) => ref.invalidate(isarProvider));
      },
      child: Padding(
        padding: const EdgeInsets.all(Dimens.dp16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimens.dp16,
                    vertical: Dimens.dp6,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimens.dp4),
                    border: Border.all(color: context.theme.primaryColor),
                  ),
                  child: RegularText.semiBold(
                    '${widget.journal.details.length} Product',
                    style: TextStyle(
                      fontSize: Dimens.dp10,
                      color: context.theme.primaryColor,
                    ),
                  ),
                ),
                Expanded(
                  child: RegularText.semiBold(
                    DateFormat('dd MMM yyyy • kk:mm')
                        .format(widget.journal.created),
                    style: const TextStyle(fontSize: Dimens.dp10),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
            Dimens.dp16.height,
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RegularText.semiBold(
                        _getTypeName(widget.journal.type),
                      ),
                      Dimens.dp8.height,
                      RegularText(
                        widget.journal.code,
                        style: const TextStyle(fontSize: Dimens.dp10),
                      ),
                      Dimens.dp8.height,
                      RegularText.medium(
                        total,
                      ),
                    ],
                  ),
                  _StatusBorder(
                    text: widget.journal.status.name.toUpperCase(),
                  )
                ],
              ),
            ),
            const Divider(
              thickness: 1,
            ),
          ],
        ),
      ),
    );
  }
}

// Function Private
String _getTypeName(JournalType type) {
  switch (type) {
    case JournalType.incoming:
      return "Incoming Goods";
    case JournalType.outgoing:
      return "Outgoing Goods";
    case JournalType.purchase:
      return "Purchasing";
    case JournalType.sale:
      return "Sales";
    case JournalType.startingStock:
      return "Starting Stock";
    case JournalType.stockAdjustment:
      return "Stock Adjustment";
    default:
      return "No Options";
  }
}
