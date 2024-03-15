import 'package:cashier_app/collections/journal/journal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import '../../../main.dart';
import '../../../utils/helpers/prepare_journal_list_tiles.dart';

class IncomingGoodsListScreen extends ConsumerWidget {
  const IncomingGoodsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isar = ref.watch(isarProvider);
    final incomingGoods = isar.journals
        .filter()
        .not()
        .journalStatusEqualTo(JournalStatus.cancelled)
        .and()
        .group(
          (q) => q
              .journalTypeEqualTo(JournalType.startingStock)
              .or()
              .journalTypeEqualTo(JournalType.incoming),
        )
        .sortByCreatedDesc()
        .findAll();

    var primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("Incoming Goods"),
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
                      child: const Text("New Purchase"),
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
                      child: const Text("Starting Stock"),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder(
                future: incomingGoods,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Journal> incomingGoods = snapshot.data!;

                    List<Widget> data =
                        prepareJournalListTiles(context, incomingGoods);
                    return incomingGoods.isEmpty
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
