part of '../sales_edit_screen.dart';

class _ItemsList extends ConsumerStatefulWidget {
  final JournalDetail detail;
  final Function()? onTapPlus;
  final Function()? onTapMin;
  final Function()? onTapDel;

  const _ItemsList(this.detail, this.onTapPlus, this.onTapMin, this.onTapDel);

  @override
  ConsumerState<_ItemsList> createState() => _ItemsListState();
}

class _ItemsListState extends ConsumerState<_ItemsList> {
  @override
  Widget build(BuildContext context) {
    bool hasAmount = widget.detail.amount > 0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(
          thickness: 2,
        ),
        Dimens.dp10.height,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RegularText.semiBold(
              widget.detail.product.value!.name,
              style: context.theme.textTheme.bodyLarge,
            ),
            RegularText.medium(
              QFormatter.formatCurrencyIndonesia(
                  widget.detail.price * widget.detail.amount.ceil()),
              style: const TextStyle(fontSize: Dimens.dp16),
            )
          ],
        ),
        QSizes.spaceBetweenInputFields.height,
        Row(
          children: [
            RegularText.medium(
              QFormatter.formatCurrencyIndonesia(
                widget.detail.product.value!.prices.first.price,
              ),
            ),
            const RegularText(" / pcs"),
          ],
        ),
        Dimens.dp16.height,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BorderButton(
              onTap: () => {QLoggerHelper.info("test")},
              "Detail",
              isOutlined: false,
              style: context.theme.textTheme.bodyMedium,
            ),
            if (widget.detail.journal.value?.status == JournalStatus.opened)
              SizedBox(
                width: 120,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    hasAmount
                        ? BorderButton("-",
                            isOutlined: true, onTap: widget.onTapMin)
                        : BorderButton("x",
                            borderColor: context.theme.colorScheme.error,
                            colorText: context.theme.colorScheme.error,
                            isOutlined: true,
                            onTap: widget.onTapDel),
                    RegularText("${widget.detail.amount.ceil()}"),
                    BorderButton("+",
                        isOutlined: false, onTap: widget.onTapPlus),
                  ],
                ),
              ),
            if (widget.detail.journal.value?.status != JournalStatus.opened)
              RegularText("${widget.detail.amount.ceil()} pcs"),
          ],
        ),
      ],
    );
  }
}
