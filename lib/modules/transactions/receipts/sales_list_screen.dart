import 'package:cashier_app/main.dart';
import 'package:cashier_app/utils/helpers/prepare_journal_list_tiles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import '../../../collections/journal/journal.dart';

class SalesListScreen extends ConsumerWidget {
  const SalesListScreen({super.key, this.from, this.to});

  final DateTime? from;
  final DateTime? to;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isar = ref.watch(isarProvider);
    var salesBuilder = isar.journals
        .filter()
        .not()
        .journalStatusEqualTo(JournalStatus.cancelled)
        .and()
        .group(
          (q) => q.journalTypeEqualTo(JournalType.sale),
        );

    if (from != null && to != null) {
      salesBuilder = salesBuilder.createdBetween(from!, to!);
    }

    var sales = salesBuilder.sortByCreatedDesc().findAll();

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

                    List<Widget> data = [];
                    data.add(
                      ListTile(
                        title: Center(
                            child: Text(
                                "${from?.year}/${from?.month}/${from?.day} : ${to?.year}/${to?.month}/${to?.day}")),
                      ),
                    );

                    data.addAll(prepareJournalListTiles(context, sales));

                    return sales.isEmpty
                        ? Center(
                            child: Text(
                                '${from?.year}/${from?.month}/${from?.day} : ${to?.year}/${to?.month}/${to?.day} is Empty'))
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
