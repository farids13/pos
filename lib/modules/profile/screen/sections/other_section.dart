part of '../profile_screen.dart';

class _OtherSection extends StatelessWidget {
  const _OtherSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(Dimens.dp16),
          child: RegularText.semiBold('Info Lainnya'),
        ),
        ItemMenuSetting(
          title: 'Kebijakan Privasi',
          icon: Iconsax.verify,
          onTap: () {},
        ),
        const Divider(height: 0),
        const ItemMenuSetting(
          title: 'Beri Rating',
          icon: Iconsax.star,
          subtitle: 'v 1.0.0',
        ),
      ],
    );
  }
}
