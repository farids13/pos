import 'package:cashier_app/collections/journal/journal.dart';
import 'package:cashier_app/commons/widgets/navigation_menu.dart';
import 'package:cashier_app/main.dart';
import 'package:cashier_app/modules/dashboard/controller/bottom_navigation_controller.dart';
import 'package:cashier_app/modules/transactions/incoming_goods/incoming_goods_list_screen.dart';
import 'package:cashier_app/modules/transactions/receipts/sales_list_screen.dart';
import 'package:cashier_app/modules/transactions/receipts/sales_management_screen.dart';
import 'package:cashier_app/states/selected_journal_provider.dart';
import 'package:cashier_app/utils/constants/constant.dart';
import 'package:cashier_app/utils/helpers/prepare_journal_list_tiles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:isar/isar.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../utils/helpers/random_data.dart';
import '../master_data/products/product_list_screen.dart';
import '../transactions/moving_goods/moving_goods_list_screen.dart';
import '../transactions/outgoing_goods/outgoing_goods_list_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class CashierHomePage extends ConsumerStatefulWidget {
  final String title;

  const CashierHomePage({super.key, required this.title});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CashierHomePage();
}

class _CashierHomePage extends ConsumerState<CashierHomePage> {
  @override
  Widget build(BuildContext context) {
    var primaryColor = Theme.of(context).colorScheme.primary;

    List<Widget> menus = [];
    menus = _buildMenu(primaryColor, context);

    List<Widget> data = [];

    Isar isar = ref.watch(isarProvider);
    var sales = isar.journals
        .filter()
        .journalTypeEqualTo(JournalType.sale)
        .sortByCreatedDesc()
        .findAllSync();

    TextButton randomButton = TextButton(
      style: TextButton.styleFrom(
        side: BorderSide(width: 1, color: primaryColor),
      ),
      onPressed: () {
        setState(() {
          randomData(isar);
        });
      },
      child: const Text("Random"),
    );
    data.add(Padding(
      padding: const EdgeInsets.all(8.0),
      child: randomButton,
    ));

    if (sales.isEmpty) {
      data.add(const Center(child: Text("Empty")));
    } else {
      List<Journal> salesPending = sales
          .where((element) => element.journalStatus == JournalStatus.opened)
          .toList();
      List<Journal> salesPostedToday = sales
          .where((element) => element.journalStatus == JournalStatus.posted)
          .where(
            (element) => DateUtils.isSameDay(
              element.created,
              DateTime.now(),
            ),
          )
          .toList();

      List<Journal> lastFourWeeks = sales
          .where((element) =>
              element.created.compareTo(DateTime.now()
                      .copyWith(hour: 23, minute: 59, second: 59)
                      .subtract(const Duration(days: 28))) >=
                  0 &&
              element.journalStatus != JournalStatus.cancelled &&
              element.journalStatus != JournalStatus.opened)
          .toList();

      List<Map<String, dynamic>> thisMonthSet = [
        {"quantity": 0, "title": "today"}, //0
        {"quantity": 0, "title": "yesterday"}, //1
        {"quantity": 0, "title": "2 days ago"}, //2
        {"quantity": 0, "title": "3 days ago"}, //3
        {"quantity": 0, "title": "4 days ago"}, //4
        {"quantity": 0, "title": "5 days ago"}, //5
        {"quantity": 0, "title": "6 days ago"}, //6
        {"quantity": 0, "title": "last week"}, //7
        {"quantity": 0, "title": "2 weeks ago"}, //8
        {"quantity": 0, "title": "3 weeks ago"}, //9
      ];

      for (var journal in lastFourWeeks) {
        double value = 0;

        for (var journalDetail in journal.details) {
          value += journalDetail.amount;
        }

        var difference =
            journal.created.difference(DateTime.now()).inDays.abs();

        // Check the difference value:
        if (difference < 7) {
          // If difference is less than 7, add value to the "quantity" property of the element at index 'difference' in thisMonthSet.
          thisMonthSet[difference]["quantity"] += value;
        } else {
          // If difference is 7 or more, add value to the "quantity" property of specific elements in thisMonthSet based on ranges:
          // - If difference is 7-13, add to index 7.
          // - If difference is 14-20, add to index 8.
          // - If difference is 21 or more, add to index 9.
          var indexToAdd = difference < 14
              ? 7
              : difference < 21
                  ? 8
                  : 9;
          thisMonthSet[indexToAdd]["quantity"] += value;
        }
      }
      List<ListTile> summary = [];
      DateTime today = DateTime.now();
      today = today.copyWith(hour: 0, minute: 0, second: 0);
      for (var element in thisMonthSet) {
        DateTime dayFrom = DateTime(0);
        DateTime dayTo = DateTime(0);
        int index = thisMonthSet.indexOf(element);
        if (index < 7) {
          dayFrom = today.add(Duration(days: -index));
          dayTo =
              dayFrom.add(const Duration(hours: 23, minutes: 59, seconds: 59));
        } else {
          var weeksBefore = index - 5;
          dayFrom = today.add(Duration(days: -weeksBefore * 7));
          dayTo = dayFrom.add(
              const Duration(days: 6, hours: 23, minutes: 59, seconds: 59));
        }

        summary.add(
          ListTile(
            onTap: () => Navigator.of(context)
                .push(
                  MaterialPageRoute(
                    builder: (_) => SalesListScreen(
                      from: dayFrom,
                      to: dayTo,
                    ),
                  ),
                )
                .then((val) =>
                    val != null ? (val ? _getRequests() : null) : null),
            title: Text(element['title']),
            trailing: Text(
              ("${element['quantity'].toStringAsFixed(0)} item(s) sold"),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        );
      }

      data.add(
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Center(
            child: Text(
              "Open Receipt",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ),
      );
      data.add(
        Card(
          elevation: 0,
          child: salesPending.isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      "Empty",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                  ),
                )
              : Column(
                  children: prepareJournalListTiles(context, salesPending),
                ),
        ),
      );
      data.add(
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Center(
            child: Text(
              "Sales Today",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ),
      );
      data.add(
        Card(
          elevation: 0,
          child: salesPostedToday.isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      "Empty",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                  ),
                )
              : Column(
                  children: prepareJournalListTiles(context, salesPostedToday),
                ),
        ),
      );

      data.add(
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Center(
            child: Text(
              "Summaries",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ),
      );
      data.add(
        Card(
          child: summary.isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      "Empty",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                  ),
                )
              : Column(
                  children: summary,
                ),
        ),
      );

      data.add(
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
            onPressed: () {
              Navigator.of(context)
                  .push(
                    MaterialPageRoute(builder: (_) => const SalesListScreen()),
                  )
                  .then((val) =>
                      val != null ? (val ? _getRequests() : null) : null);
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("more..."),
            ),
          ),
        ),
      );
    }

    final indexPosition = ref.watch(selectIndexStateProvider);
    void onTap(int index) {
      ref.watch(selectIndexStateProvider.notifier).setIndexPosition(index);
      switch (index) {
        case 0:
          context.go("/productList");
          break;
        case 1:
          context.go("/favorite");
          break;
        case 2:
          context.go("/notification");
          break;
        case 3:
          context.go("/login");
          break;
        default:
      }
    }

    return Scaffold(
      bottomNavigationBar: Material(
        elevation: 2,
        child: CustomCurvedNavigationWidget(
          items: [
            CurvedNavigationBarItem(
                iconData: MdiIcons.homeOutline,
                selectedIconData: MdiIcons.home),
            CurvedNavigationBarItem(
                iconData: MdiIcons.heartOutline,
                selectedIconData: MdiIcons.heart),
            CurvedNavigationBarItem(
                iconData: MdiIcons.bellOutline,
                selectedIconData: MdiIcons.bellAlert),
            CurvedNavigationBarItem(
                iconData: MdiIcons.accountOutline,
                selectedIconData: MdiIcons.account),
          ],
          currentIndex: indexPosition,
          onTap: (indexPosition) => onTap(indexPosition),
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return constraints.maxWidth < 600
              ? _singleColumn(context, menus, data)
              : _twoColumn(context, menus, data);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            _createNewReceipt(ref, context, "SLS", JournalType.sale),
        tooltip: 'Create New Receipt',
        child: const Icon(Icons.point_of_sale),
      ),
    );
  }

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
                        builder: (_) => const ProductListScreen()),
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
                "Product",
              ),
            ),
          ),
        ),
      ),
    ];
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

  Widget _singleColumn(
      BuildContext context, List<Widget> menus, List<Widget> data) {
    List<Widget> menu = [
      Padding(
        padding: const EdgeInsets.all(4.0),
        child: IntrinsicHeight(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: menus,
          ),
        ),
      ),
    ];
    menu.addAll(data);
    return ListView(
      children: menu,
    );
  }

  Widget _twoColumn(
      BuildContext context, List<Widget> menus, List<Widget> data) {
    List<Widget> content = [];

    content.addAll(data);

    List<Widget> sidebar = [
      Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(
            "posIT - Cashier App",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor),
          ),
        ),
      ),
    ];
    sidebar.addAll(menus);
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.topLeft,
            width: 200,
            padding: const EdgeInsets.all(8),
            child: IntrinsicHeight(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: sidebar,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: content,
            ),
          ),
        ],
      ),
    );
  }
}
