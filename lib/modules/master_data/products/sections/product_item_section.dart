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
      child: Padding(
        padding: const EdgeInsets.only(left: Dimens.dp18, right: Dimens.dp18),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(Dimens.dp8),
                child: product.description.isEmpty
                    ? Image.network(
                        'https://store.storeimages.cdn-apple.com/1/as-images.apple.com/is/iphone-13-finish-select-202207-product-red?wid=5120&hei=2880&fmt=webp&qlt=70&.v=WGQwVDZoTWdLODlMWERUbVY5M013a1NCSGJEVklzV3dtVWxKME5oOWltbkt6V25EMGNydWRwby94NjVGeDRTU2d2S3NaRzcrU0dmYjNHTUFiMnlsWFRocXAvNjVVaCtjTTZGTUNzOU8wNkVrTVNTQnN4UXUvYlU2WmdlRmt1Y3o=&traceId=1',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      )
                    : Image.memory(
                        ImageHelper.convertToUint8List(product.name),
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            Dimens.dp12.width,
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width <= 400
                        ? 100
                        : MediaQuery.of(context).size.width - 250,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          overflow: TextOverflow.ellipsis,
                          product.name,
                          style: const TextStyle(fontSize: Dimens.dp20),
                        ),
                        Dimens.dp4.height,
                        RegularText(product.code),
                        Dimens.dp4.height,
                        RegularText.semiBold(
                          QFormatter.formatCurrencyIndonesia(
                            product.prices.last.price,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Stock View
                  BorderButton(
                    journalAmount.toStringAsFixed(0),
                    isOutlined: journalAmount >= 0 ? true : false,
                    width: 80,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
