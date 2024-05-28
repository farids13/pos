import 'package:cashier_app/collections/journal/journal.dart';
import 'package:cashier_app/collections/journal/journal_detail.dart';
import 'package:cashier_app/collections/location/location.dart';
import 'package:cashier_app/collections/product/product.dart';
import 'package:cashier_app/collections/product/product_price.dart';
import 'package:cashier_app/commons/router/router.dart';
import 'package:cashier_app/utils/helpers/random_data.dart';
import 'package:cashier_app/utils/theme/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'collections/location/storage.dart';

final isarProvider = Provider<Isar>((_) => throw UnimplementedError());

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
    directory: dir.path,
    [
      JournalSchema,
      JournalDetailSchema,
      ProductSchema,
      ProductPriceSchema,
      LocationSchema,
      StorageSchema
    ],
  );
  if (kDebugMode) {
    randomData(isar);
  }
  runApp(
    ProviderScope(
      overrides: [
        isarProvider.overrideWithValue(isar),
      ],
      child: const CashierApp(),
    ),
  );
}

class CashierApp extends ConsumerWidget {
  const CashierApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Home',
      theme: QAppTheme.lightTheme,
      // darkTheme: QAppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: appRouter,
    );
  }
}
