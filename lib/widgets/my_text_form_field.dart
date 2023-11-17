import 'dart:core';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jimmys/constants.dart';
import 'package:jimmys/functions.dart';
import 'package:jimmys/types.dart';

class MyTextFormField extends StatefulWidget {
  const MyTextFormField({
    Key? key,
    this.initialValue,
    this.validator,
    this.labelText,
    this.padding,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.onSubmitted,
    this.disabled = false,
    this.keyboardType = TextInputType.text,
    this.maxLines = 5,
  }) : super(key: key);

  final String? initialValue;
  final String? Function(String?)? validator;
  final String? labelText;
  final EdgeInsetsGeometry? padding;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final StringToVoidFunc? onChanged;
  final VoidFunc? onSubmitted;
  final bool disabled;
  final TextInputType keyboardType;
  final int maxLines;

  @override
  State<MyTextFormField> createState() => _MyTextState();
}

class _MyTextState extends State<MyTextFormField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();

    _controller = widget.controller ?? TextEditingController(); 

    if (widget.initialValue != null) _controller.text = widget.initialValue!;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: widget.padding ?? const EdgeInsets.all(spacingMedium),
      child: TextFormField(
        readOnly: widget.disabled,
        canRequestFocus: !widget.disabled,
        keyboardType: widget.keyboardType,
        minLines: 1,
        maxLines: widget.keyboardType == TextInputType.multiline ? widget.maxLines : 1,
        //initialValue: initialValue, use controller to set initialValue
        style: getLabelMediumSecondary(theme),
        cursorColor: theme.colorScheme.primary,
        controller: _controller,
        validator: widget.validator,
        decoration: InputDecoration(
          labelText: widget.labelText,
          contentPadding: const EdgeInsets.symmetric(horizontal: spacingSmall),
          suffix: _createSuffix(),
          errorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: theme.colorScheme.primary),
          ),
          focusedErrorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          disabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: theme.colorScheme.shadow),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: theme.colorScheme.secondary),
          ),
        ),
        focusNode: widget.focusNode,
        onChanged: widget.onChanged,
        onFieldSubmitted: (String value) {
          if (widget.onSubmitted != null) widget.onSubmitted!();
        },
      ),
    );
  }

  Widget _createSuffix() {
    if (_controller.text.trim().isEmpty) return const SizedBox.shrink();

    return InkWell(
      onTap: () {
        _controller.clear();
        widget.onChanged!('');
      },
      child: const Padding(
        padding: EdgeInsets.only(top: 5),
        child: FaIcon(FontAwesomeIcons.xmark),
      ),
    );
  }
}