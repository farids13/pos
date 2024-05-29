import 'package:cashier_app/collections/journal/journal.dart';
import 'package:cashier_app/commons/widgets/list/list_item_widget.dart';
import 'package:cashier_app/commons/widgets/page/empty_page.dart';
import 'package:cashier_app/main.dart';
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
          : const EmptyPage("There No Cart Yet"),
    );
  }
}
