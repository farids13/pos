part of '../product_list_screen.dart';

class _ProductItemSection extends ConsumerWidget {
  const _ProductItemSection({
    required this.product,
    required this.onDelete,
    required this.onEdit,
  });

  final Product product;
  final Function() onEdit;
  final Function() onDelete;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var isar = ref.read(isarProvider);
    var journalDetails = isar.journalDetails
        .where()
        .filter()
        .journal((q) => q.statusEqualTo(JournalStatus.posted))
        .product((q) => q.codeEqualTo(product.code))
        .findAllSync();

    var journalAmount = 0.0;
    for (var journalDetail in journalDetails) {
      if (incomingGoodsCollection.contains(journalDetail.journal.value?.type)) {
        journalAmount += journalDetail.amount;
      } else {
        journalAmount -= journalDetail.amount;
      }
    }
    return InkWell(
      onTap: onEdit,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(Dimens.dp8),
                child: product.description.isEmpty
                    ? Image.network(
                        'https://indonesiakaya.com/wp-content/uploads/2020/10/langsat1200.jpg',
                        width: 74,
                        height: 74,
                        fit: BoxFit.cover,
                      )
                    : Image.memory(
                        ImageHelper.convertToUint8List(product.name),
                        width: 74,
                        height: 74,
                        fit: BoxFit.cover,
                      ),
              ),
              Dimens.dp12.width,
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RegularText(
                          product.name,
                          style: const TextStyle(fontSize: Dimens.dp20),
                        ),
                        Dimens.dp4.height,
                        RegularText(product.code),
                        Dimens.dp4.height,
                        RegularText.semiBold(QFormatter.formatCurrencyIndonesia(
                            product.prices.last.price)),
                      ],
                    ),
                    BorderButton(
                      journalAmount.toStringAsFixed(0),
                      isOutlined: journalAmount < 0 ? true : false,
                      width: 80,
                      height: 40,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Dimens.dp16.height,
          // Row(
          //   children: [
          //     Expanded(
          //       child: OutlinedButton(
          //         onPressed: onEdit,
          //         child: const Text('Edit'),
          //       ),
          //     ),
          //     Dimens.dp16.width,
          //     Expanded(
          //       child: OutlinedButton(
          //         onPressed: onDelete,
          //         child: const Text('Delete'),
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
