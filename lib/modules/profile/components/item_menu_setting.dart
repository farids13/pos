import 'package:cashier_app/commons/extensions/extensions.dart';
import 'package:cashier_app/commons/widgets/text/regular_text.dart';
import 'package:cashier_app/utils/constants/dimens.dart';
import 'package:flutter/material.dart';

class ItemMenuSetting extends StatelessWidget {
  const ItemMenuSetting({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
    this.subtitle,
  });

  final String title;
  final IconData icon;
  final Function()? onTap;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(Dimens.dp16),
        child: Row(
          children: [
            Icon(icon),
            Dimens.dp12.width,
            Expanded(
              child: RegularText.medium(
                title,
                style: const TextStyle(fontSize: Dimens.dp12),
              ),
            ),
            if (subtitle != null) ...[
              Dimens.dp12.width,
              RegularText.semiBold(
                subtitle!,
                style: const TextStyle(fontSize: Dimens.dp10),
              ),
            ],
            Dimens.dp12.width,
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: context.theme.primaryColor,
              size: Dimens.dp18,
            ),
          ],
        ),
      ),
    );
  }
}
