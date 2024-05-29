import 'package:cashier_app/commons/extensions/extensions.dart';
import 'package:cashier_app/utils/constants/dimens.dart';
import 'package:cashier_app/utils/theme/colors.dart';
import 'package:flutter/material.dart';

class LabelInput extends StatelessWidget {
  const LabelInput({
    super.key,
    required this.label,
    this.required = false,
  });

  final String? label;
  final bool required;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: label,
        style: context.theme.textTheme.labelMedium?.copyWith(
          color: AppColors.black,
        ),
        children: [
          if (required)
            TextSpan(
              text: ' Required ',
              style: TextStyle(
                fontSize: Dimens.dp10,
                color: context.theme.primaryColor,
              ),
            ),
        ],
      ),
    );
  }
}
