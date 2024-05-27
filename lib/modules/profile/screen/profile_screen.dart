import 'package:cashier_app/commons/extensions/extensions.dart';
import 'package:cashier_app/commons/widgets/text/regular_text.dart';
import 'package:cashier_app/data/api/google/google_sign_in_api.dart';
import 'package:cashier_app/modules/profile/components/item_menu_setting.dart';
import 'package:cashier_app/utils/constants/dimens.dart';
import 'package:cashier_app/utils/helpers/image_helper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

part 'sections/profile_section.dart';
part 'sections/account_section.dart';
part 'sections/device_section.dart';
part 'sections/other_section.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lainnya')),
      body: ListView(
        children: [
          const _ProfileSection(),
          const Divider(thickness: Dimens.dp8),
          const _AccountSection(),
          const Divider(thickness: Dimens.dp8),
          const _DeviceSection(),
          const Divider(thickness: Dimens.dp8),
          const _OtherSection(),
          Padding(
            padding: const EdgeInsets.all(Dimens.dp16),
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: context.theme.colorScheme.error,
                side: BorderSide(color: context.theme.colorScheme.error),
              ),
              onPressed: () {
                GoogleSignInAPI.handleSignOut();
                context.pushReplacement("/login");
              },
              child: const Text('Keluar'),
            ),
          ),
        ],
      ),
    );
  }
}
