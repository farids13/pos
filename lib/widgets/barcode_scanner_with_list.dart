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

class _BarcodeScannerWithListState
    extends ConsumerState<BarcodeScannerWithList> {
  @override
  Widget build(BuildContext context) {
    var result = ref.watch(resultProvider);

    var dialogOpened = false;

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
              controller: MobileScannerController(
                detectionSpeed: DetectionSpeed.noDuplicates,
                facing: CameraFacing.back,
                returnImage: false,
              ),
              onDetect: (capture) {
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
              },
            ),
          ),
        ),
        const Text("kentang"),
      ],
    );
  }
}
