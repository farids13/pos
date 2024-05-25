part of '../profile_screen.dart';

class _DeviceSection extends StatelessWidget {
  const _DeviceSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(Dimens.dp16),
          child: RegularText.semiBold('Perangkat Tambahan'),
        ),
        ItemMenuSetting(
          title: 'Printer',
          icon: Icons.print_outlined,
          onTap: () {
            // Navigator.pushNamed(context, PrinterPage.routeName);
          },
        ),
        const Divider(height: 0),
        ItemMenuSetting(
          title: 'Atur Struk',
          icon: Iconsax.copy_success,
          onTap: () {
            // Navigator.pushNamed(context, StruckPage.routeName);
          },
        ),
      ],
    );
  }
}
