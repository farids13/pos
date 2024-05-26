import 'package:cashier_app/commons/extensions/extensions.dart';
import 'package:cashier_app/commons/widgets/text/regular_text.dart';
import 'package:cashier_app/utils/constants/dimens.dart';
import 'package:flutter/material.dart';

class BorderButton extends StatelessWidget {
  final String text;
  final Color? borderColor;
  final bool? isOutlined;
  final Color? colorText;
  final double? height;
  final double? width;
  final double? paddingHorizontal;
  final double? paddingVertical;
  final double? fontSize;
  final TextStyle? style;
  final Function()? onTap;
  final TextAlign? textAlign;
  final double? borderRadius;
  const BorderButton(
    this.text, {
    super.key,
    this.borderColor,
    this.isOutlined,
    this.colorText,
    this.height,
    this.width,
    this.fontSize,
    this.style,
    this.onTap,
    this.textAlign,
    this.borderRadius,
    this.paddingHorizontal,
    this.paddingVertical,
  });

  @override
  Widget build(BuildContext context) {
    final style = context.theme.textTheme.bodyMedium;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        padding: EdgeInsets.symmetric(
          horizontal: paddingHorizontal ?? Dimens.dp12,
          vertical: paddingVertical ?? Dimens.dp6,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? Dimens.dp4),
          color: isOutlined != null && !isOutlined!
              ? null
              : context.theme.primaryColor,
          border: isOutlined != null && !isOutlined!
              ? Border.all(color: borderColor ?? context.theme.primaryColor)
              : null,
        ),
        child: RegularText(
          textAlign: textAlign,
          text,
          style: style?.copyWith(
            fontSize: fontSize,
            color: isOutlined != null && isOutlined!
                ? (colorText != null ? colorText! : context.theme.canvasColor)
                : (colorText != null ? colorText! : context.theme.primaryColor),
          ),
        ),
      ),
    );
  }
}
