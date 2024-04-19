import 'package:cashier_app/main.dart';
import 'package:cashier_app/utils/helpers/prepare_journal_list_tiles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import '../../../collections/journal/journal.dart';

class OutgoingGoodsListScreen extends ConsumerWidget {
  const OutgoingGoodsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isar = ref.watch(isarProvider);
    final outgoingGoods = isar.journals
        .filter()
        .not()
        .journalStatusEqualTo(JournalStatus.cancelled)
        .and()
        .group(
          (q) => q.journalTypeEqualTo(JournalType.outgoing),
        )
        .sortByCreatedDesc()
        .findAll();

    var primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("Outgoing Goods"),
        actions: [
          CloseButton(
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        side: BorderSide(width: 1, color: primaryColor),
                      ),
                      onPressed: () {},
                      child: const Text("Product Return"),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        side: BorderSide(width: 1, color: primaryColor),
                      ),
                      onPressed: () {},
                      child: const Text("Broken Product"),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder(
                future: outgoingGoods,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Journal> outgoingGoods = snapshot.data!;

                    List<Widget> data =
                        prepareJournalListTiles(context, outgoingGoods);
                    return outgoingGoods.isEmpty
                        ? const Center(child: Text('Empty'))
                        : ListView(
                            children: data,
                          );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
