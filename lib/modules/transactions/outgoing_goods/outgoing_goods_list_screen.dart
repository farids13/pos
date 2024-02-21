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
      body: FutureBuilder(
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
    );
  }
}
