import 'package:cashier_app/main.dart';
import 'package:cashier_app/utils/helpers/prepare_journal_list_tiles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import '../../../collections/journal/journal.dart';

class SalesListScreen extends ConsumerWidget {
  const SalesListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isar = ref.watch(isarProvider);
    final sales = isar.journals
        .filter()
        .not()
        .journalStatusEqualTo(JournalStatus.cancelled)
        .and()
        .group(
          (q) => q.journalTypeEqualTo(JournalType.sale),
        )
        .sortByCreatedDesc()
        .findAll();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("Sales"),
        actions: [
          CloseButton(
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: sales,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Journal> sales = snapshot.data!;

                    List<Widget> data =
                        prepareJournalListTiles(context, sales);
                    return sales.isEmpty
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
