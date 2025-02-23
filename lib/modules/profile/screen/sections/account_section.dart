part of '../profile_screen.dart';

class _AccountSection extends StatelessWidget {
  const _AccountSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(Dimens.dp16),
          child: RegularText.semiBold('Akun'),
        ),
        ItemMenuSetting(
          title: 'Informasi Usaha',
          icon: Iconsax.receipt,
          onTap: () {
            // Navigator.pushNamed(context, ProfilePage.routeName);
          },
        ),
        const Divider(height: 0),
        ItemMenuSetting(
          title: 'API Key Xendit',
          icon: Iconsax.card,
          onTap: () {
            // Navigator.pushNamed(context, XenditPage.routeName);
          },
        ),
      ],
    );
  }
}
