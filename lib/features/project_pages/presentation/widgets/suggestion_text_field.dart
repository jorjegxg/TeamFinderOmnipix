// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: diagnostic_describe_all_properties, inference_failure_on_function_return_type, prefer_final_locals, prefer_final_in_for_each, lines_longer_than_80_chars, must_be_immutable, unnecessary_statements, inference_failure_on_collection_literal, unused_local_variable, use_decorated_box, avoid_redundant_argument_values, prefer_null_aware_method_calls, use_if_null_to_convert_nulls_to_bools

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class SuggestionTextField extends StatelessWidget {
  const SuggestionTextField({
    super.key,
    required this.options,
    required this.onSubmitted,
    required this.controller,
    this.width,
  });
  final TextEditingController controller;
  final List<String> options;
  final void Function(String) onSubmitted;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TypeAheadField<String>(
        emptyBuilder: (context) => const SizedBox(),
        controller: controller,
        suggestionsCallback: (search) {
          return listToSuggestion(options, search);
        },
        builder: (context, controller, focusNode) {
          return TextField(
              onSubmitted: onSubmitted,
              controller: controller,
              focusNode: focusNode,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Text',
              ));
        },
        itemBuilder: (context, city) {
          return ListTile(
            title: Text(city),
          );
        },
        onSelected: (city) {
          controller.text = city;
        },
      ),
    );
  }
}

List<String> listToSuggestion(List<String> fullList, String text) {
  List<String> sugestedList = [];
  for (String item in fullList) {
    String lowerItem = item.toLowerCase();
    String lowerText = text.toLowerCase();

    lowerItem.contains(lowerText) ? sugestedList.add(item) : {};
  }
  return sugestedList;
}
