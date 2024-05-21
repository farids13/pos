import 'package:cashier_app/main.dart';
import 'package:cashier_app/modules/transactions/incoming_goods/incoming_goods_list_screen.dart';
import 'package:cashier_app/modules/transactions/moving_goods/moving_goods_list_screen.dart';
import 'package:cashier_app/modules/transactions/outgoing_goods/outgoing_goods_list_screen.dart';
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
    var primaryColor = Theme.of(context).colorScheme.primary;
    List<Widget> menus = [];
    menus = _buildMenu(primaryColor, context);

    final isar = ref.watch(isarProvider);
    var salesBuilder = isar.journals
        .filter()
        .not()
        .statusEqualTo(JournalStatus.cancelled)
        .and()
        .group(
          (q) => q.typeEqualTo(JournalType.sale),
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IntrinsicHeight(
              child: Row(
                children: menus,
              ),
            ),
          ),
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

// -- Functions

List<Widget> _buildMenu(Color primaryColor, BuildContext context) {
  return [
    Expanded(
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: TextButton(
          style: TextButton.styleFrom(
            side: BorderSide(width: 1, color: primaryColor),
          ),
          onPressed: () {
            Navigator.of(context)
                .push(
                  MaterialPageRoute(
                      builder: (_) => const IncomingGoodsListScreen()),
                )
                .then((val) =>
                    val != null ? (val ? _getRequests() : null) : null);
          },
          child: const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 4,
              vertical: 2,
            ),
            child: Text(
              textAlign: TextAlign.center,
              "In",
            ),
          ),
        ),
      ),
    ),
    Expanded(
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: TextButton(
          style: TextButton.styleFrom(
            side: BorderSide(width: 1, color: primaryColor),
          ),
          onPressed: () {
            Navigator.of(context)
                .push(
                  MaterialPageRoute(
                      builder: (_) => const OutgoingGoodsListScreen()),
                )
                .then((val) =>
                    val != null ? (val ? _getRequests() : null) : null);
          },
          child: const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 4,
              vertical: 2,
            ),
            child: Text(
              textAlign: TextAlign.center,
              "Out",
            ),
          ),
        ),
      ),
    ),
    Expanded(
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: TextButton(
          style: TextButton.styleFrom(
            side: BorderSide(width: 1, color: primaryColor),
          ),
          onPressed: () {
            Navigator.of(context)
                .push(
                  MaterialPageRoute(
                      builder: (_) => const MovingGoodsListScreen()),
                )
                .then((val) =>
                    val != null ? (val ? _getRequests() : null) : null);
          },
          child: const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 4,
              vertical: 2,
            ),
            child: Text(
              textAlign: TextAlign.center,
              "Move",
            ),
          ),
        ),
      ),
    ),

    // -- deprecated
    // Expanded(
    //   child: Padding(
    //     padding: const EdgeInsets.all(2.0),
    //     child: TextButton(
    //       style: TextButton.styleFrom(
    //         side: BorderSide(width: 1, color: primaryColor),
    //       ),
    //       onPressed: () {
    //         Navigator.of(context)
    //             .push(
    //               MaterialPageRoute(
    //                   builder: (_) => const ProductListScreen()),
    //             )
    //             .then((val) =>
    //                 val != null ? (val ? _getRequests() : null) : null);
    //       },
    //       child: const Padding(
    //         padding: EdgeInsets.symmetric(
    //           horizontal: 4,
    //           vertical: 2,
    //         ),
    //         child: Text(
    //           textAlign: TextAlign.center,
    //           "Product",
    //         ),
    //       ),
    //     ),
    //   ),
    // ),
  ];
}

_getRequests() async {}
