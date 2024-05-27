part of "../sales_edit_screen.dart";

class SaleEditSection extends ConsumerStatefulWidget {
  final SelectedJournal journal;
  final Function() addProduct;
  final Function() scanBarcode;

  const SaleEditSection(this.journal,
      {super.key, required this.addProduct, required this.scanBarcode});

  @override
  ConsumerState<SaleEditSection> createState() => _SaleEditSectionState();
}

class _SaleEditSectionState extends ConsumerState<SaleEditSection> {
  @override
  Widget build(BuildContext context) {
    updateJournalDetailAmount(JournalDetail journalDetail, double amount) {
      var isar = ref.watch(isarProvider);
      if (amount > 0 || journalDetail.amount > 0) {
        setState(() {
          journalDetail.amount += amount;
        });
        isar.writeTxnSync(() {
          isar.journalDetails.putSync(journalDetail);
        });
      }
    }

    double totalSales() {
      var data = ref.watch(selectedJournalProvider);
      var tmp = 0.0;
      for (var jd in data.data.details) {
        tmp += jd.price * jd.amount;
      }

      return tmp;
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(QSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RegularText.semiBold(
                      "Pesanan",
                      style: context.theme.textTheme.headlineSmall,
                    ),
                    SizedBox(
                      child: Row(
                        children: [
                          widget.journal.data.status == JournalStatus.opened
                              ?
                          BorderButton(
                            "+",
                            isOutlined: false,
                            onTap: widget.addProduct,
                          ):const SizedBox(),
                          Dimens.dp8.width,
                          widget.journal.data.status == JournalStatus.opened
                              ? BorderButton(
                                  "֎",
                                  isOutlined: false,
                                  onTap: widget.scanBarcode,
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                  ],
                ),
                ...widget.journal.data.details.map((e) => _ItemsList(
                    e,
                    () => updateJournalDetailAmount(e, 1),
                    () => updateJournalDetailAmount(e, -1))),
              ],
            ),
          ),
          const Divider(
            thickness: Dimens.dp10,
          ),
          Padding(
            padding: const EdgeInsets.all(QSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RegularText(
                  "Detail Transaksi",
                  style: context.theme.textTheme.headlineSmall,
                ),
                const Divider(
                  thickness: Dimens.dp2,
                ),
                _SpaceBetweenField("Jumlah Product",
                    widget.journal.data.details.length.toString()),
                _SpaceBetweenField("Sub Total",
                    QFormatter.formatCurrencyIndonesia(totalSales())),
                const _SpaceBetweenField("Pajak", "Rp 0"),
                const _SpaceBetweenField("Diskon", "Rp 0"),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: DottedDivider(
                    color: AppColors.white[500]!,
                    spaceLength: 5,
                    strokeWidth: 2,
                  ),
                ),
                _SpaceBetweenField(
                  "Total",
                  QFormatter.formatCurrencyIndonesia(totalSales()),
                  style: context.theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Dimens.dp14.height,
                const _InfoWidget("Additional Info"),
                Dimens.dp14.height,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
