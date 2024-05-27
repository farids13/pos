import 'package:cashier_app/commons/extensions/extensions.dart';
import 'package:flutter/material.dart';

class SubtitleText extends StatelessWidget {
  const SubtitleText(
    this.text, {
    super.key,
    this.align,
    this.style,
  });

  final String text;
  final TextStyle? style;
  final TextAlign? align;

  @override
  Widget build(BuildContext context) {
    final baseStyle = context.theme.textTheme.titleLarge;

    return Text(
      text,
      style: baseStyle?.merge(style),
      textAlign: align,
    );
  }
}
