import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../collections/journal/journal.dart';
import '../../collections/product/product.dart';

List<Widget> prepareJournalListTiles(
    BuildContext context, List<Journal> journals) {
  List<Widget> result = [];

  for (var item in journals) {
    var value = 0.0;
    List<Product> productInReceipt = [];
    for (var detail in item.details) {
      if (detail.product.value != null &&
          !productInReceipt
              .any((item) => item.id == detail.product.value?.id)) {
        productInReceipt.add(detail.product.value!);
      }
      value += detail.price * detail.amount;
    }
    productInReceipt = productInReceipt.toSet().toList();
    result.add(ReceiptTile(
        item: item, productInReceipt: productInReceipt, value: value));
  }
  return result;
}

class ReceiptTile extends StatelessWidget {
  const ReceiptTile({
    super.key,
    required this.item,
    required this.productInReceipt,
    required this.value,
  });

  final Journal item;
  final List<Product> productInReceipt;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          List<TableRow> tableData = [];
          for (var detail in item.details) {
            tableData.add(
              TableRow(
                children: [
                  TableCell(
                    child: Text(
                      detail.product.value?.name ?? "",
                    ),
                  ),
                ],
              ),
            );
            tableData.add(
              TableRow(
                children: [
                  TableCell(
                      child: Table(
                    columnWidths: const {
                      0: FlexColumnWidth(6),
                      1: FlexColumnWidth(1),
                      2: FlexColumnWidth(2),
                      3: FlexColumnWidth(3),
                    },
                    children: [
                      TableRow(
                        children: [
                          Text(
                            "@${detail.price.toStringAsFixed(0)},-",
                            textAlign: TextAlign.end,
                          ),
                          const TableCell(
                            child: Text(
                              "x",
                              textAlign: TextAlign.end,
                            ),
                          ),
                          Text(
                            "${detail.amount}",
                            textAlign: TextAlign.end,
                          ),
                          Text(
                            "${(detail.price * detail.amount).toStringAsFixed(0)},-",
                            textAlign: TextAlign.end,
                          ),
                        ],
                      ),
                    ],
                  )),
                ],
              ),
            );
          }
          Table t = Table(
            children: tableData,
          );
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text(
                      item.code,
                      textAlign: TextAlign.end,
                    ),
                    content: t,
                  ));
        },
        title: Text(item.code),
        subtitle: Row(
          children: [
            Flexible(
              child: Text(
                  "${DateFormat('yyyy/MM/dd kk:mm').format(item.created)} | ${productInReceipt.length} product in receipt"),
            ),
          ],
        ),
        trailing: Text(
          "${value.toStringAsFixed(0)},-",
          style: const TextStyle(fontSize: 14),
        ),
      ),
    );
  }
}
