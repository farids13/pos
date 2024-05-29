import 'package:cashier_app/commons/extensions/extensions.dart';
import 'package:cashier_app/commons/widgets/text/regular_text.dart';
import 'package:cashier_app/utils/constants/dimens.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

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
  final IconData? suffixIcon;
  final IconData? prefixIcon;
  final MainAxisAlignment? iconAlign;
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
    this.suffixIcon,
    this.prefixIcon,
    this.iconAlign,
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
          color: isOutlined != null && isOutlined!
              ? null
              : context.theme.primaryColor,
          border: isOutlined != null && isOutlined!
              ? Border.all(color: borderColor ?? context.theme.primaryColor)
              : null,
        ),
        child: Row(
          mainAxisAlignment: iconAlign ?? MainAxisAlignment.center,
          children: [
            // First Icon
            if (prefixIcon != null)
              Icon(
                prefixIcon,
                size: fontSize ?? Dimens.dp20,
                color: isOutlined != null && !isOutlined!
                    ? (colorText != null
                        ? colorText!
                        : context.theme.scaffoldBackgroundColor)
                    : (colorText != null
                        ? colorText!
                        : context.theme.primaryColor),
              ),
            RegularText(
              textAlign: textAlign,
              text,
              style: style?.copyWith(
                fontSize: fontSize,
                color: isOutlined != null && !isOutlined!
                    ? (colorText != null
                        ? colorText!
                        : context.theme.scaffoldBackgroundColor)
                    : (colorText != null
                        ? colorText!
                        : context.theme.primaryColor),
              ),
            ),
            // Last Icon
            if (suffixIcon != null)
              Icon(
                suffixIcon,
                size: fontSize ?? Dimens.dp20,
                color: isOutlined != null && !isOutlined!
                    ? (colorText != null
                        ? colorText!
                        : context.theme.scaffoldBackgroundColor)
                    : (colorText != null
                        ? colorText!
                        : context.theme.primaryColor),
              ),
          ],
        ),
      ),
    );
  }
}
