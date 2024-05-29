import 'package:cashier_app/commons/widgets/input/regular_input.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SearchTextInput extends StatelessWidget {
  const SearchTextInput({
    super.key,
    required this.hintText,
    this.controller,
    this.onChanged,
  });

  final String hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return RegularTextInput(
      hintText: hintText,
      controller: controller,
      onChanged: onChanged,
      prefixIcon: Iconsax.search_normal,
    );
  }
}
