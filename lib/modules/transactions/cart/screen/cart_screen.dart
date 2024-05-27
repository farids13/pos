import 'package:cashier_app/collections/journal/journal.dart';
import 'package:cashier_app/commons/styles/spacing_styles.dart';
import 'package:cashier_app/commons/widgets/list/list_item_widget.dart';
import 'package:cashier_app/main.dart';
import 'package:cashier_app/utils/constants/image_strings.dart';
import 'package:cashier_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
        title: const Text("Open Receipts"),
      ),
      body: salesPending.isNotEmpty
          ? ListView.builder(
              itemBuilder: (context, index) {
                return ListItem(salesPending[index]);
              },
              itemCount: salesPending.length,
            )
          : const _EmptyCart(),
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
