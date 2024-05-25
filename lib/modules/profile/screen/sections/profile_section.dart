part of '../profile_screen.dart';

class _ProfileSection extends StatelessWidget {
  const _ProfileSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimens.dp16),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(Dimens.dp48),
            child: Image.network(
              'https://cdn.antaranews.com/cache/1200x800/2023/06/18/20230618_080945.jpg',
              width: 64,
              height: 64,
              fit: BoxFit.cover,
            ),
          ),
          Dimens.dp16.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RegularText.semiBold('Some One'),
                Dimens.dp4.height,
                const RegularText(
                  'someone@example.com',
                  style: TextStyle(fontSize: Dimens.dp12),
                ),
                Dimens.dp4.height,
                const RegularText(
                  '+6289123123123',
                  style: TextStyle(fontSize: Dimens.dp12),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              // Navigator.pushNamed(context, ProfilePage.routeName);
            },
            icon: const Icon(Iconsax.edit),
            color: context.theme.primaryColor,
          ),
        ],
      ),
    );
  }
}
