import 'package:cashier_app/collections/journal/journal.dart';
import 'package:cashier_app/commons/extensions/extensions.dart';
import 'package:cashier_app/commons/styles/spacing_styles.dart';
import 'package:cashier_app/commons/widgets/text/regular_text.dart';
import 'package:cashier_app/main.dart';
import 'package:cashier_app/modules/transactions/receipts/sales_edit_screen.dart';
import 'package:cashier_app/states/selected_journal_provider.dart';
import 'package:cashier_app/utils/constants/dimens.dart';
import 'package:cashier_app/utils/constants/image_strings.dart';
import 'package:cashier_app/utils/constants/sizes.dart';
import 'package:cashier_app/utils/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  @override
  Widget build(BuildContext context) {
    Isar isar = ref.watch(isarProvider);

    var sales = isar.journals
        .filter()
        .typeEqualTo(JournalType.sale)
        .sortByCreatedDesc()
        .findAllSync();

    List<Journal> salesPending = sales
        .where((element) => element.status == JournalStatus.opened)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
      ),
      body: salesPending.isNotEmpty
          ? ListView.builder(
              itemBuilder: (context, index) {
                return _ItemSection(salesPending[index]);
              },
              itemCount: salesPending.length,
            )
          : const _EmptyCart(),
    );
  }
}

class _ItemSection extends ConsumerStatefulWidget {
  final Journal journal;
  const _ItemSection(this.journal);

  @override
  ConsumerState<_ItemSection> createState() => _ItemSectionState();
}

class _ItemSectionState extends ConsumerState<_ItemSection> {
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

class _EmptyCart extends StatelessWidget {
  const _EmptyCart();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: QSpacingStyle.paddingWithAppHeightBar,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(image: AssetImage(QImages.emptyImage)),
            const SizedBox(
              height: QSizes.defaultSpace,
            ),
            Text(
              "There are no cart here",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
    );
  }
}
