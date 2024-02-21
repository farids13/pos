import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PurchaseListScreen extends ConsumerWidget {
  const PurchaseListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Purchases"),
        actions: [
          CloseButton(
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
      body: const Center(
        child: Text("Purchases"),
      ),
    );
  }
}
