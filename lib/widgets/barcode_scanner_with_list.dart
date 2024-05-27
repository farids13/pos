import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

final resultProvider = Provider<String>((_) => '');

class BarcodeScannerWithList extends ConsumerStatefulWidget {
  const BarcodeScannerWithList({super.key});

  @override
  ConsumerState<BarcodeScannerWithList> createState() =>
      _BarcodeScannerWithListState();
}

class _BarcodeScannerWithListState extends ConsumerState<BarcodeScannerWithList>
    with WidgetsBindingObserver {
  MobileScannerController scannerController = MobileScannerController(
    detectionSpeed: DetectionSpeed.normal,
    detectionTimeoutMs: 750,
    facing: CameraFacing.back,
    returnImage: false,
  );
  StreamSubscription<Object?>? _subscription;

  String result = '';
  bool dialogOpened = false;

  @override
  void initState() {
    super.initState();
    // Start listening to lifecycle changes.
    WidgetsBinding.instance.addObserver(this);

    // Start listening to the barcode events.
    _subscription = scannerController.barcodes.listen(_handleBarcode);

    // Finally, start the scanner itself.
    unawaited(scannerController.start());
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // If the controller is not ready, do not try to start or stop it.
    // Permission dialogs can trigger lifecycle changes before the controller is ready.
    if (!scannerController.value.isInitialized) {
      return;
    }

    switch (state) {
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
        return;
      case AppLifecycleState.resumed:
        // Restart the scanner when the app is resumed.
        // Don't forget to resume listening to the barcode events.
        _subscription = scannerController.barcodes.listen(_handleBarcode);

        unawaited(scannerController.start());
      case AppLifecycleState.inactive:
        // Stop the scanner when the app is paused.
        // Also stop the barcode events subscription.
        unawaited(_subscription?.cancel());
        _subscription = null;
        unawaited(scannerController.stop());
    }
  }

  @override
  Widget build(BuildContext context) {
    result = ref.watch(resultProvider);

    var aspectRatio = MediaQuery.of(context).size.aspectRatio;
    return Column(
      children: [
        SizedBox(
          height: aspectRatio > 1
              ? MediaQuery.of(context).size.height - 96
              : MediaQuery.of(context).size.width,
          width: aspectRatio < 1
              ? MediaQuery.of(context).size.width
              : MediaQuery.of(context).size.height,
          child: Center(
            child: MobileScanner(
              fit: BoxFit.cover,
              controller: scannerController,
            ),
          ),
        ),
        Text("Text from the camera: $result"),
      ],
    );
  }

  @override
  Future<void> dispose() async {
    // Stop listening to lifecycle changes.
    WidgetsBinding.instance.removeObserver(this);
    // Stop listening to the barcode events.
    unawaited(_subscription?.cancel());
    _subscription = null;
    // Dispose the widget itself.
    super.dispose();
    // Finally, dispose of the controller.
    await scannerController.dispose();
  }

  void _handleBarcode(BarcodeCapture? capture) {
    if (capture != null) {
      final List<Barcode> barcodes = capture.barcodes;
      // final Uint8List? image = capture.image;
      for (final barcode in barcodes) {
        setState(() {
          result = barcode.rawValue!;
        });
        debugPrint('Barcode found! ${barcode.rawValue}');
      }
      if (!dialogOpened) {
        showDialog(
          context: context,
          builder: (context) => Dialog.fullscreen(
            child: Column(
              children: [
                Center(
                  child: Text(result),
                ),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Close"),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    }
  }
}
