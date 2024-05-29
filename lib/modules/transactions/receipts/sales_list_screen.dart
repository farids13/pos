import 'package:cashier_app/commons/widgets/button/border_button_widget.dart';
import 'package:cashier_app/commons/widgets/list/list_item_widget.dart';
import 'package:cashier_app/commons/widgets/page/empty_page.dart';
import 'package:cashier_app/main.dart';
import 'package:cashier_app/modules/transactions/incoming_goods/incoming_goods_list_screen.dart';
import 'package:cashier_app/modules/transactions/moving_goods/moving_goods_list_screen.dart';
import 'package:cashier_app/modules/transactions/outgoing_goods/outgoing_goods_list_screen.dart';
import 'package:cashier_app/utils/constants/dimens.dart';
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
        title: const Text("Transaction"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IntrinsicHeight(
              child: Row(
                children: _optionMenu(context),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
                future: sales,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Journal> sales = snapshot.data!;
                    return sales.isEmpty
                        ? const EmptyPage("No Transaction yet")
                        : ListView(
                            children: sales.map((e) => ListItem(e)).toList());
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

// ========= Function =========

List<Widget> _optionMenu(BuildContext context) {
  return [
    Expanded(
      child: Padding(
          padding: const EdgeInsets.all(Dimens.dp10),
          child: BorderButton(
            "In",
            isOutlined: false,
            textAlign: TextAlign.center,
            onTap: () {
              Navigator.of(context)
                  .push(
                    MaterialPageRoute(
                        builder: (_) => const IncomingGoodsListScreen()),
                  )
                  .then((val) =>
                      val != null ? (val ? _getRequests() : null) : null);
            },
          )),
    ),
    Expanded(
      child: Padding(
        padding: const EdgeInsets.all(Dimens.dp10),
        child: BorderButton(
          "Out",
          isOutlined: false,
          textAlign: TextAlign.center,
          onTap: () {
            Navigator.of(context)
                .push(
                  MaterialPageRoute(
                      builder: (_) => const OutgoingGoodsListScreen()),
                )
                .then((val) =>
                    val != null ? (val ? _getRequests() : null) : null);
          },
        ),
      ),
    ),
    Expanded(
      child: Padding(
        padding: const EdgeInsets.all(Dimens.dp10),
        child: BorderButton(
          "Move",
          isOutlined: false,
          textAlign: TextAlign.center,
          onTap: () {
            Navigator.of(context)
                .push(
                  MaterialPageRoute(
                      builder: (_) => const MovingGoodsListScreen()),
                )
                .then((val) =>
                    val != null ? (val ? _getRequests() : null) : null);
          },
        ),
      ),
    ),

    // -- deprecated
    // Expanded(
    //   child: Padding(
    //     padding: const EdgeInsets.all(Dimens.dp10),
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
