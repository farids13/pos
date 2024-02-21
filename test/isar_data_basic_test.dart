import 'package:cashier_app/collections/journal/journal.dart';
import 'package:cashier_app/collections/journal/journal_detail.dart';
import 'package:cashier_app/collections/location/location.dart';
import 'package:cashier_app/collections/location/storage.dart';
import 'package:cashier_app/collections/product/product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

const String kTemporaryPath = 'temporaryPath';
const String kApplicationSupportPath = 'applicationSupportPath';
const String kDownloadsPath = 'downloadsPath';
const String kLibraryPath = 'libraryPath';
const String kApplicationDocumentsPath = 'applicationDocumentsPath';
const String kExternalCachePath = 'externalCachePath';
const String kExternalStoragePath = 'externalStoragePath';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUp(() async {
    PathProviderPlatform.instance = FakePathProviderPlatform();
  });
  test('Isar populate test', () async {
    await Isar.initializeIsarCore(download: true);
    final dir = await getApplicationDocumentsDirectory();
    final isar = await Isar.open(
      directory: dir.path,
      [
        JournalSchema,
        JournalDetailSchema,
        ProductSchema,
        LocationSchema,
        StorageSchema
      ],
    );

    final product = Product()
      ..code = "B-002"
      ..name = "ByeGone Ulir";

    await isar.writeTxn(() async {
      await isar.products.put(product);
    });

    expect(product.code, "B-002");
    expect(product.name, "ByeGone Ulir");
  });
}

class FakePathProviderPlatform extends Fake
    with MockPlatformInterfaceMixin
    implements PathProviderPlatform {
  @override
  Future<String?> getTemporaryPath() async {
    return kTemporaryPath;
  }

  @override
  Future<String?> getApplicationSupportPath() async {
    return kApplicationSupportPath;
  }

  @override
  Future<String?> getLibraryPath() async {
    return kLibraryPath;
  }

  @override
  Future<String?> getApplicationDocumentsPath() async {
    return kApplicationDocumentsPath;
  }

  @override
  Future<String?> getExternalStoragePath() async {
    return kExternalStoragePath;
  }

  @override
  Future<List<String>?> getExternalCachePaths() async {
    return <String>[kExternalCachePath];
  }

  @override
  Future<List<String>?> getExternalStoragePaths({
    StorageDirectory? type,
  }) async {
    return <String>[kExternalStoragePath];
  }

  @override
  Future<String?> getDownloadsPath() async {
    return kDownloadsPath;
  }
}
