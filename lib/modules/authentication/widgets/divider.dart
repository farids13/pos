import 'package:cashier_app/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';

class DividerWidget extends StatelessWidget {
  final String text;
  const DividerWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final isDark = QHelperFunction.isDarkMode(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Flexible(
            child: Divider(
          thickness: 1,
          indent: 60,
          endIndent: 5,
        )),
        Text(
          text,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(),
        ),
        const Flexible(
            child: Divider(
          thickness: 1,
          indent: 5,
          endIndent: 60,
        )),
      ],
    );
  }
}
