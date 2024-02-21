import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReceiptListItem extends ConsumerWidget {
  const ReceiptListItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: Text(
          "RCPT/${DateTime.now().month}/${DateTime.now().day}/GYR/${DateTime.now().millisecondsSinceEpoch}"),
      subtitle: Text("${Random().nextInt(15) + 1} Item(s)"),
      trailing: Text(
        "${Random().nextInt(1000) * 100},-",
        style: const TextStyle(fontSize: 14),
      ),
    );
  }
}
