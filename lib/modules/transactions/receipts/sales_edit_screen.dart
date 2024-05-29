import 'package:cashier_app/collections/journal/journal.dart';
import 'package:cashier_app/collections/journal/journal_detail.dart';
import 'package:cashier_app/commons/extensions/extensions.dart';
import 'package:cashier_app/commons/widgets/button/border_button_widget.dart';
import 'package:cashier_app/commons/widgets/divider/dotted_divider_widget.dart';
import 'package:cashier_app/commons/widgets/text/regular_text.dart';
import 'package:cashier_app/commons/widgets/text/text.dart';
import 'package:cashier_app/main.dart';
import 'package:cashier_app/modules/master_data/products/widget/search_and_add_product.dart';
import 'package:cashier_app/states/selected_journal_provider.dart';
import 'package:cashier_app/states/selected_product_provider.dart';
import 'package:cashier_app/utils/constants/dimens.dart';
import 'package:cashier_app/utils/constants/sizes.dart';
import 'package:cashier_app/utils/formatters/formatter.dart';
import 'package:cashier_app/utils/logging/logger.dart';
import 'package:cashier_app/utils/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
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
      body: SaleEditSection(
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

  const _SpaceBetweenField(this.prefix, this.suffix, {this.style});

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
