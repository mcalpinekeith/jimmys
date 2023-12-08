import 'dart:async';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:jimmys/ui/widgets/generic/my_text_form_field.dart';

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
  final Function(String) onSelected;

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: _optionsBuilder,
      onSelected: onSelected,
      fieldViewBuilder: _fieldViewBuilder,
    );
  }

  FutureOr<Iterable<String>> _optionsBuilder(TextEditingValue textEditingValue) {
    if (textEditingValue.text.isEmpty) return const Iterable<String>.empty();

    return options.where((String option) {
      return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
    });
  }

  Widget _fieldViewBuilder(context, controller, focus, onFieldSubmitted) => MyTextFormField(
    initialValue: initialValue,
    validator: validator,
    labelText: labelText,
    padding: padding,
    controller: controller,
    focusNode: focus,
    onChanged: onSelected,
    onSubmitted: onFieldSubmitted,
  );
}