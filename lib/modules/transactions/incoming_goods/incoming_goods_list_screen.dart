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
      body: FutureBuilder(
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
    );
  }
}
