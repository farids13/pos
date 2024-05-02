import 'package:cashier_app/main.dart';
import 'package:cashier_app/utils/helpers/prepare_journal_list_tiles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import '../../../collections/journal/journal.dart';
import '../../../states/selected_journal_provider.dart';
import '../receipts/sales_management_screen.dart';

class OutgoingGoodsListScreen extends ConsumerStatefulWidget {
  const OutgoingGoodsListScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _OutgoingGoodsListScreen();
}

class _OutgoingGoodsListScreen extends ConsumerState<OutgoingGoodsListScreen> {
  @override
  Widget build(BuildContext context) {
    final isar = ref.watch(isarProvider);
    final outgoingGoods = isar.journals
        .filter()
        .not()
        .journalStatusEqualTo(JournalStatus.cancelled)
        .and()
        .group(
          (q) => q
              .journalTypeEqualTo(JournalType.outgoing)
              .or()
              .journalTypeEqualTo(JournalType.returning)
              .or()
              .journalTypeEqualTo(JournalType.brokenProducts),
        )
        .sortByCreatedDesc()
        .findAll();

    var primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("Outgoing Goods"),
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
                          ref, context, "RTN", JournalType.returning),
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
                      onPressed: () => _createNewReceipt(
                          ref, context, "BRK", JournalType.brokenProducts),
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
