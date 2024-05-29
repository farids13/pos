import 'package:cashier_app/commons/styles/spacing_styles.dart';
import 'package:cashier_app/utils/constants/image_strings.dart';
import 'package:cashier_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class EmptyPage extends StatelessWidget {
  final String text;
  const EmptyPage(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: QSpacingStyle.paddingWithAppHeightBar,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(image: AssetImage(QImages.emptyImage)),
            const SizedBox(
              height: QSizes.defaultSpace,
            ),
            Text(
              text,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
    );
  }
}
