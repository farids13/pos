import 'package:cashier_app/collections/journal/journal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import '../../../main.dart';
import '../../../states/selected_journal_provider.dart';
import '../../../utils/helpers/prepare_journal_list_tiles.dart';
import '../receipts/sales_management_screen.dart';

class IncomingGoodsListScreen extends ConsumerStatefulWidget {
  const IncomingGoodsListScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _IncomingGoodsListScreen();
}

class _IncomingGoodsListScreen extends ConsumerState<IncomingGoodsListScreen> {
  @override
  Widget build(BuildContext context) {
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
              .journalTypeEqualTo(JournalType.incoming)
              .or()
              .journalTypeEqualTo(JournalType.purchase),
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
                      onPressed: () => _createNewReceipt(
                          ref, context, "PRC", JournalType.purchase),
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
                      onPressed: () => _createNewReceipt(
                          ref, context, "STR", JournalType.startingStock),
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

  void _createNewReceipt(WidgetRef ref, BuildContext context,
      String receiptCode, JournalType journalType) {
    Isar isar = ref.watch(isarProvider);
    SelectedJournal s = ref.watch(selectedJournalProvider);
    Journal j = Journal()
      ..created = DateTime.now()
      ..code =
          "$receiptCode-${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}${DateTime.now().hour}${DateTime.now().minute}${DateTime.now().second}"
      ..journalType = journalType;

    isar.writeTxnSync(() => isar.journals.putSync(j));

    setState(() {
      s.data = j;
    });
    Navigator.of(context)
        .push(
      MaterialPageRoute(builder: (_) => const SalesManagementScreen()),
    )
        .then((val) => val != null ? (val ? _getRequests() : null) : null);
  }

  _getRequests() async {}
}
