import 'package:cashier_app/collections/journal/journal.dart';
import 'package:cashier_app/collections/journal/journal_detail.dart';
import 'package:cashier_app/main.dart';
import 'package:cashier_app/states/selected_journal_provider.dart';
import 'package:cashier_app/widgets/products/search_and_add_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

final temporaryJournalProvider = Provider<List<Journal>>((_) => []);

class SalesManagementScreen extends ConsumerStatefulWidget {
  const SalesManagementScreen({super.key});

  @override
  ConsumerState<SalesManagementScreen> createState() =>
      _SalesManagementScreenState();
}

class _SalesManagementScreenState extends ConsumerState<SalesManagementScreen> {
  final double _discount = 0;

  bool _isClosed = false;

  late SelectedJournal selectedJournal;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    NumberFormat numberFormat = NumberFormat("#,##0.00", "en_US");
    selectedJournal = ref.watch(selectedJournalProvider);

    String journalType = "";

    if (selectedJournal.journal.journalStatus == JournalStatus.posted) {
      setState(() {
        _isClosed = true;
      });
    }

    switch (selectedJournal.journal.journalType) {
      case JournalType.incoming:
        journalType = "Incoming Goods";
        break;
      case JournalType.outgoing:
        journalType = "Outgoing Goods";
        break;
      case JournalType.purchase:
        journalType = "Purchasing";
        break;
      case JournalType.sale:
        journalType = "Sales";
        break;
      case JournalType.startingStock:
        journalType = "Starting Stock";
        break;
      case JournalType.stockAdjustment:
        journalType = "Stock Adjustment";
        break;
      default:
        journalType = "";
        break;
    }

    totalSales();

    selectedJournal.journal.details.loadSync();

    var title =
        _isClosed ? "$journalType Receipt Posted" : "Edit $journalType Receipt";

    return Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              selectedJournal.journal = Journal();
              Navigator.of(context).pop();
            },
          ),
          title: Text(title),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical:8.0,horizontal:24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    selectedJournal.journal.code,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        fontStyle: FontStyle.italic),
                  ),
                  Text(DateFormat('yyyy-MM-dd kk:mm:ss').format(selectedJournal.journal.created)),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Divider(thickness: 0.5),
            ),
            Column(
              children: selectedJournal.journal.details.isNotEmpty
                  ? selectedJournal.journal.details
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          child: Table(
                            children: [
                              TableRow(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        e.product.value?.name ?? "-",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        " @${numberFormat.format(e.price)}",
                                        style: const TextStyle(
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  Table(
                                    children: [
                                      TableRow(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                  "Rp.${numberFormat.format(e.amount * e.price)}"),
                                              Row(
                                                children: [
                                                  _isClosed
                                                      ? Container()
                                                      : IconButton(
                                                          icon: const Icon(
                                                              Icons.remove),
                                                          onPressed: () =>
                                                              updateJournalDetailAmount(
                                                                  e, -1.0),
                                                        ),
                                                  Container(
                                                    width: 48,
                                                    alignment: Alignment.center,
                                                    child: Text("${e.amount}"),
                                                  ),
                                                  _isClosed
                                                      ? Container()
                                                      : IconButton(
                                                          icon: const Icon(
                                                              Icons.add),
                                                          onPressed: () =>
                                                              updateJournalDetailAmount(
                                                                  e, 1.0),
                                                        ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList()
                  : [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            "No Item",
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                    ],
            ),
            _isClosed
                ? const SizedBox()
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                        onPressed: () async {
                          await Navigator.of(context)
                              .push(
                            MaterialPageRoute(
                              builder: (_) => const SearchAndAddProduct(),
                            ),
                          )
                              .then((value) {
                            setState(() {});
                          });
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Add items from stock"),
                        )),
                  ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Divider(thickness: 0.5),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Table(
                columnWidths: const {
                  0: FlexColumnWidth(8),
                  1: FlexColumnWidth(0.25),
                  2: FlexColumnWidth(3.75)
                },
                children: [
                  TableRow(
                    children: [
                      const Text("Selling price"),
                      const Text(
                        ":",
                        textAlign: TextAlign.end,
                      ),
                      Text(
                        "Rp.${numberFormat.format(totalSales())}",
                        textAlign: TextAlign.end,
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      const Text("Discount"),
                      const Text(
                        ":",
                        textAlign: TextAlign.end,
                      ),
                      Text(
                        "Rp.${numberFormat.format(_discount)}",
                        textAlign: TextAlign.end,
                      ),
                    ],
                  ),
                  const TableRow(
                    children: [
                      Text(""),
                      Divider(thickness: 0.5),
                      Divider(thickness: 0.5),
                    ],
                  ),
                  TableRow(
                    children: [
                      const Text("Total"),
                      const Text(
                        ":",
                        textAlign: TextAlign.end,
                      ),
                      Text(
                        "Rp.${numberFormat.format(totalSales() - _discount)}",
                        textAlign: TextAlign.end,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Divider(thickness: 0.5),
            ),
            _isClosed
                ? const SizedBox()
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      child: const Text("Proceed"),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Confirmation"),
                              content: const Text(
                                  "Are you sure? Finalized receipt cannot be edited."),
                              actions: [
                                TextButton(
                                  child: const Text("Cancel"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: const Text("OK"),
                                  onPressed: () {
                                    var isar = ref.watch(isarProvider);
                                    setState(() {
                                      selectedJournal.journal.journalStatus =
                                          JournalStatus.posted;
                                    });
                                    isar.writeTxnSync(() {
                                      isar.journals
                                          .putSync(selectedJournal.journal);
                                    });
                                    ref.invalidate(isarProvider);
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
          ],
        ));
  }

  double totalSales() {
    var tmp = 0.0;
    for (var jd in selectedJournal.journal.details) {
      tmp += jd.price * jd.amount;
    }

    return tmp;
  }

  updateJournalDetailAmount(JournalDetail journalDetail, double amount) {
    var isar = ref.watch(isarProvider);
    if (amount > 0 || journalDetail.amount > 0) {
      setState(() {
        journalDetail.amount += amount;
      });
      isar.writeTxnSync(() {
        isar.journalDetails.putSync(journalDetail);
      });
    }
  }
}
