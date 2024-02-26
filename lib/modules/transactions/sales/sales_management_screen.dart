import 'package:cashier_app/collections/journal/journal.dart';
import 'package:cashier_app/collections/journal/journal_detail.dart';
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
  double _totalSales = 0;
  final double _discount = 0;

  List<JournalDetail> journalDetails = [];

  @override
  void initState() {
    super.initState();
    calculateTransactionValue();
  }

  @override
  Widget build(BuildContext context) {
    NumberFormat numberFormat = NumberFormat("#,##0.00", "en_US");
    journalDetails = ref.watch(selectedProductProvider);

    calculateTransactionValue();

    var title = "Receipt Page";
    if (journalDetails.isNotEmpty) {
      title = "Edit Receipt";
    }

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              List<JournalDetail> journalDetail =
                  ref.watch(selectedProductProvider);
              journalDetail.clear();
              Navigator.of(context).pop(false);
            },
          ),
          title: Text(title),
        ),
        body: ListView(
          children: [
            Column(
              children: journalDetails.isNotEmpty
                  ? journalDetails
                      .map(
                        (e) => ListTile(
                          title: Text(e.product.value?.name ?? "-"),
                          subtitle: Text("@${numberFormat.format(e.price)}"),
                          trailing: Text(
                              "x${e.amount} = Rp.${numberFormat.format(e.amount * e.price)}"),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                  onPressed: () async {
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const SearchAndAddProduct(),
                      ),
                    );
                    setState(() {});
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Add items in stock"),
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
                        "Rp.${numberFormat.format(_totalSales)}",
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
                        "Rp.${numberFormat.format(_totalSales - _discount)}",
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(onPressed: () {}, child: const Text("Proceed")),
            ),
          ],
        ));
  }

  void calculateTransactionValue() {
    setState(() {
      _totalSales = 0;
      for (var jd in journalDetails) {
        _totalSales += jd.price * jd.amount;
      }
    });
  }
}
