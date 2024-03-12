import 'package:flutter/material.dart';
import 'package:team_finder_app/features/auth/presentation/widgets/custom_text_field.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    super.key,
    required this.nameConttroler,
    this.hintText,
    required this.onSubmitted,
  });

  final TextEditingController nameConttroler;
  final String? hintText;
  final Function(String) onSubmitted;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      nameConttroler: nameConttroler,
      hintText: hintText,
      onSubmitted: onSubmitted,
      prefixIcon: Icons.search,
    );
  }
}
