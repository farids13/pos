part of '../list_item_widget.dart';

class _StatusBorder extends StatelessWidget {
  const _StatusBorder({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimens.dp12,
        vertical: Dimens.dp6,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimens.dp4),
          color: _getStatusColor(text)),
      child: RegularText.semiBold(
        text,
        style: TextStyle(
          fontSize: Dimens.dp10,
          color: context.theme.canvasColor,
        ),
      ),
    );
  }
}

Color _getStatusColor(String status) {
  switch (status.toUpperCase()) {
    case 'OPENED':
      return QColors.success;
    case 'CANCELLED':
      return QColors.error;
    case 'POSTED':
      return QColors.info;
    default:
      return AppColors.green[800]!;
  }
}
