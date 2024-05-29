import 'package:cashier_app/collections/journal/journal.dart';
import 'package:cashier_app/collections/journal/journal_detail.dart';
import 'package:cashier_app/commons/extensions/extensions.dart';
import 'package:cashier_app/commons/widgets/button/border_button_widget.dart';
import 'package:cashier_app/commons/widgets/divider/dotted_divider_widget.dart';
import 'package:cashier_app/commons/widgets/text/regular_text.dart';
import 'package:cashier_app/commons/widgets/text/text.dart';
import 'package:cashier_app/main.dart';
import 'package:cashier_app/states/selected_journal_provider.dart';
import 'package:cashier_app/states/selected_product_provider.dart';
import 'package:cashier_app/utils/constants/dimens.dart';
import 'package:cashier_app/utils/constants/sizes.dart';
import 'package:cashier_app/utils/formatters/formatter.dart';
import 'package:cashier_app/utils/logging/logger.dart';
import 'package:cashier_app/utils/theme/colors.dart';
import 'package:cashier_app/utils/theme/theme.dart';
import 'package:cashier_app/widgets/general_widgets/quantity_and_value_popup.dart';
import 'package:cashier_app/modules/master_data/products/widget/search_and_add_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';

import '../../../states/selected_journal_detail_provider.dart';
import '../../../widgets/barcode_scanner_with_list.dart';

part 'sections/item_list_section.dart';
part 'sections/sale_edit_section.dart';

class SalesEditScreen extends ConsumerStatefulWidget {
  const SalesEditScreen({super.key});

  @override
  ConsumerState<SalesEditScreen> createState() => _SalesManagementScreenState();
}

class _SalesManagementScreenState extends ConsumerState<SalesEditScreen> {
  late SelectedJournal selectedJournal;
  late SelectedJournalDetail selectedJournalDetail;
  late SelectedProduct selectedProduct;
  Isar? isar;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    selectedJournal = ref.watch(selectedJournalProvider);
    selectedJournalDetail = ref.watch(selectedJournalDetailProvider);
    selectedProduct = ref.watch(selectedProductProvider);
    isar = ref.watch(isarProvider);

    String journalType = "";

    switch (selectedJournal.data.type) {
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

    bool isClosed = selectedJournal.data.status == JournalStatus.posted;

    var title = isClosed ? "$journalType Receipt" : "Edit $journalType Receipt";

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text(title),
      ),
      bottomNavigationBar: _BottomBarWidget(() {
        var isar = ref.watch(isarProvider);
        setState(() {
          selectedJournal.data.status = JournalStatus.posted;
        });
        isar.writeTxnSync(() {
          isar.journals.putSync(selectedJournal.data);
        });
        ref.invalidate(isarProvider);
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      }),
      body: false
          ? _buildTest(
              selectedJournal: selectedJournal,
              selectedJournalDetail: selectedJournalDetail,
              selectedProduct: selectedProduct)
          : SaleEditSection(
              selectedJournal,
              addProduct: () async {
                await Navigator.of(context)
                    .push(MaterialPageRoute(
                        builder: (_) => const SearchAndAddProduct()))
                    .then((value) {
                  selectedJournal.data.details.loadSync();
                  setState(() {});
                });
              },
              scanBarcode: () async {
                await Navigator.of(context)
                    .push(MaterialPageRoute(
                        builder: (_) => const BarcodeScannerWithList()))
                    .then((value) {
                  selectedJournal.data.details.loadSync();
                  setState(() {});
                });
              },
            ),
    );
  }
}

class _BottomBarWidget extends StatelessWidget {
  final Function() onPressed;

  const _BottomBarWidget(this.onPressed);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: context.theme.scaffoldBackgroundColor,
          blurRadius: 10,
          offset: const Offset(0, -5),
        ),
      ]),
      child: Padding(
        padding: const EdgeInsets.all(Dimens.dp16),
        child: BorderButton(
          "Save Changes",
          textAlign: TextAlign.center,
          isOutlined: true,
          fontSize: QSizes.md,
          borderRadius: QSizes.sm,
          paddingVertical: QSizes.md,
          onTap: () {
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
                      onPressed: onPressed,
                      child: const Text("OK"),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _InfoWidget extends StatelessWidget {
  final String text;

  const _InfoWidget(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            const Icon(
              Iconsax.info_circle,
              color: AppColors.orange,
            ),
            const SizedBox(
              width: 8,
            ),
            RegularText(text),
          ],
        ),
      ),
    );
  }
}

class _SpaceBetweenField extends StatelessWidget {
  final String prefix;
  final String suffix;
  final TextStyle? style;

  const _SpaceBetweenField(this.prefix, this.suffix, {super.key, this.style});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RegularText(
            prefix,
            style: context.theme.textTheme.bodyLarge?.merge(style),
          ),
          RegularText(
            suffix,
            style: context.theme.textTheme.bodyLarge?.merge(style),
          ),
        ],
      ),
    );
  }
}

class _buildTest extends ConsumerStatefulWidget {
  final SelectedProduct selectedProduct;
  final SelectedJournal selectedJournal;
  final SelectedJournalDetail selectedJournalDetail;

  const _buildTest({
    super.key,
    required this.selectedJournal,
    required this.selectedJournalDetail,
    required this.selectedProduct,
  });

  @override
  ConsumerState<_buildTest> createState() => _buildTestState();
}

class _buildTestState extends ConsumerState<_buildTest> {
  @override
  Widget build(BuildContext context) {
    NumberFormat numberFormat = NumberFormat("#,##0.00", "en_US");

    final double _discount = 0;

    bool _isClosed = false;

    late SelectedJournal selectedJournal;
    late SelectedJournalDetail selectedJournalDetail;
    late SelectedProduct selectedProduct;
    Isar? isar;

    selectedJournal = ref.watch(selectedJournalProvider);
    selectedJournalDetail = ref.watch(selectedJournalDetailProvider);
    selectedProduct = ref.watch(selectedProductProvider);
    isar = ref.watch(isarProvider);

    String journalType = "";

    if (selectedJournal.data.status == JournalStatus.posted) {
      setState(() {
        _isClosed = true;
      });
    }
    switch (selectedJournal.data.type) {
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

    // totalSales();

    // selectedJournal.data.details.loadSync();

    var title =
        _isClosed ? "$journalType Receipt Posted" : "Edit $journalType Receipt";
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                widget.selectedJournal.data.code,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    fontStyle: FontStyle.italic),
              ),
              Text(DateFormat('yyyy-MM-dd kk:mm:ss')
                  .format(widget.selectedJournal.data.created)),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Divider(thickness: 0.5),
        ),
        Column(
          children: widget.selectedJournal.data.details.isNotEmpty
              ? widget.selectedJournal.data.details
                  .map(
                    (journalDetail) => InkWell(
                      onTap: () {
                        if (widget.selectedJournal.data.status !=
                            JournalStatus.posted) {
                          setState(() {
                            widget.selectedProduct.data =
                                journalDetail.product.value!;
                            widget.selectedJournalDetail.data = journalDetail;
                          });
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const QuantityAndValuePopup();
                              });
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Table(
                          children: [
                            TableRow(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      journalDetail.product.value?.name ?? "-",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      " @${numberFormat.format(journalDetail.price)}",
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
                                        Table(
                                          defaultVerticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          columnWidths: const {
                                            0: FlexColumnWidth(8),
                                            1: FlexColumnWidth(4),
                                          },
                                          children: [
                                            TableRow(
                                              children: [
                                                Row(
                                                  children: [
                                                    _isClosed
                                                        ? Container()
                                                        : IconButton(
                                                            icon: const Icon(
                                                                Icons.remove),
                                                            onPressed: () =>
                                                                updateJournalDetailAmount(
                                                                    journalDetail,
                                                                    -1.0),
                                                          ),
                                                    Expanded(
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                            "${journalDetail.amount}"),
                                                      ),
                                                    ),
                                                    _isClosed
                                                        ? Container()
                                                        : IconButton(
                                                            icon: const Icon(
                                                                Icons.add),
                                                            onPressed: () =>
                                                                updateJournalDetailAmount(
                                                                    journalDetail,
                                                                    1.0),
                                                          ),
                                                  ],
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    "Rp.${numberFormat.format(journalDetail.amount * journalDetail.price)}",
                                                  ),
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
                                  widget.selectedJournal.data.status =
                                      JournalStatus.posted;
                                });
                                isar.writeTxnSync(() {
                                  isar.journals
                                      .putSync(widget.selectedJournal.data);
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
    );
  }

  double totalSales() {
    var tmp = 0.0;
    for (var jd in widget.selectedJournal.data.details) {
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
