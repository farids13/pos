import 'package:cashier_app/collections/journal/journal.dart';
import 'package:cashier_app/commons/extensions/extensions.dart';
import 'package:cashier_app/commons/widgets/text/regular_text.dart';
import 'package:cashier_app/main.dart';
import 'package:cashier_app/modules/transactions/receipts/sales_edit_screen.dart';
import 'package:cashier_app/states/selected_journal_provider.dart';
import 'package:cashier_app/utils/constants/dimens.dart';
import 'package:cashier_app/utils/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

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

    String total = formatCurrency.format(widget.journal.details
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
                    horizontal: Dimens.dp12,
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
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RegularText.semiBold(
                      widget.journal.code,
                    ),
                    Dimens.dp8.height,
                    RegularText.semiBold(
                      total,
                      style: TextStyle(color: context.theme.primaryColor),
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimens.dp12,
                    vertical: Dimens.dp6,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimens.dp4),
                      color: AppColors.green[800]),
                  child: RegularText.semiBold(
                    widget.journal.status.name.toUpperCase(),
                    style: const TextStyle(
                      fontSize: Dimens.dp10,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
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
