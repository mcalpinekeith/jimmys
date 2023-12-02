import 'dart:core';
import 'package:flutter/material.dart';
import 'package:jimmys/core/function_types.dart';
import 'package:jimmys/ui/widgets/my_text_form_field.dart';

class MyAutocomplete extends StatelessWidget {
  const MyAutocomplete({
    super.key,
    this.initialValue,
    this.validator,
    this.labelText,
    this.padding,
    required this.options,
    required this.onSelected,
  });

  final String? initialValue;
  final String? Function(String?)? validator;
  final String? labelText;
  final EdgeInsetsGeometry? padding;
  final List<String> options;
  final StringToVoidFunc onSelected;

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) return const Iterable<String>.empty();

        var result = options.where((String option) {
          return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
        });

        return result;
      },
      onSelected: onSelected,
      fieldViewBuilder: (context, controller, focus, onFieldSubmitted) => MyTextFormField(
        initialValue: initialValue,
        validator: validator,
        labelText: labelText,
        padding: padding,
        controller: controller,
        focusNode: focus,
        onChanged: onSelected,
        onSubmitted: onFieldSubmitted,
      ),
    );
  }
}