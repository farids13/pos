part of '../sales_edit_screen.dart';

class _ItemsList extends ConsumerStatefulWidget {
  final JournalDetail detail;
  final Function()? onTapPlus;
  final Function()? onTapMin;

  const _ItemsList(this.detail, this.onTapPlus, this.onTapMin);

  @override
  ConsumerState<_ItemsList> createState() => _ItemsListState();
}

class _ItemsListState extends ConsumerState<_ItemsList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(
          thickness: 2,
        ),
        Dimens.dp10.height,
        RegularText.semiBold(
          widget.detail.product.value!.name,
          style: context.theme.textTheme.bodyLarge,
        ),
        QSizes.spaceBetweenInputFields.height,
        Row(
          children: [
            RegularText.semiBold(
              widget.detail.product.value!.prices.first.price.toString(),
              style: context.theme.textTheme.titleLarge,
            ),
            const RegularText(" / pcs"),
          ],
        ),
        Dimens.dp16.height,
        Row(
          children: [
            BorderButton(
              onTap: () => {QLoggerHelper.info("test")},
              "Detail",
              isOutlined: false,
              style: context.theme.textTheme.bodyMedium,
            ),
            const Spacer(),
            Row(
              children: [
                widget.detail.journal.value?.status == JournalStatus.opened
                    ? BorderButton("-",
                        isOutlined: false, onTap: widget.onTapMin)
                    : const SizedBox(),
                Dimens.dp24.width,
                widget.detail.journal.value?.status == JournalStatus.opened
                    ? RegularText("${widget.detail.amount.ceil()}")
                    : Row(
                        children: [
                          RegularText.semiBold(
                            "${widget.detail.amount.ceil()}",
                            style: context.theme.textTheme.titleLarge,
                          ),
                          const RegularText(" pcs"),
                        ],
                      ),
                Dimens.dp24.width,
                widget.detail.journal.value?.status == JournalStatus.opened
                    ? BorderButton("+",
                        isOutlined: true, onTap: widget.onTapPlus)
                    : const SizedBox(),
              ],
            )
          ],
        ),
      ],
    );
  }
}
