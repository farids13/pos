import 'package:cashier_app/collections/journal/journal.dart';
import 'package:cashier_app/commons/widgets/list/list_item_widget.dart';
import 'package:cashier_app/main.dart';
import 'package:cashier_app/utils/helpers/prepare_journal_list_tiles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

class MovingGoodsListScreen extends ConsumerWidget {
  const MovingGoodsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Isar isar = ref.watch(isarProvider);

    final movingGoods = isar.journals
        .filter()
        .not()
        .statusEqualTo(JournalStatus.cancelled)
        .and()
        .group(
          (q) => q
              .typeEqualTo(JournalType.incoming)
              .or()
              .typeEqualTo(JournalType.outgoing),
        )
        .sortByCreatedDesc()
        .findAll();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("Moving Goods"),
        actions: [
          CloseButton(
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
      body: FutureBuilder(
          future: movingGoods,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Journal> movingGoods = snapshot.data!;

              List<Widget> data = [];
              prepareJournalListTiles(context, movingGoods);
              for (var sale in movingGoods) {
                data.add(ListItem(sale));
              }
              return movingGoods.isEmpty
                  ? const Center(child: Text('Empty'))
                  : ListView(
                      children: data,
                    );
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
