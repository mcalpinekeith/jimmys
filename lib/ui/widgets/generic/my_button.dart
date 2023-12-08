import 'package:flutter/material.dart';
import 'package:jimmys/ui/theme/constants.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    this.size = Sizes.medium,
    required this.label,
    required this.icon,
    this.padding = const EdgeInsets.symmetric(vertical: spacingMedium, horizontal: 0.0),
    this.onPressed,
  });

  final Sizes size;
  final Widget label;
  final Widget icon;
  final EdgeInsetsGeometry padding;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    var height = 45.0 + padding.vertical;
    var width = 0.0 + padding.horizontal;

    switch (size) {
      case Sizes.small:
        width += 10.0;
        break;
      case Sizes.medium:
        width += 200.0;
        break;
      case Sizes.large:
        width += 250.0;
        break;
    }

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints.tightForFinite(width: width, height: height),
        child: Padding(
          padding: padding,
          child: ElevatedButton.icon(
            label: label,
            icon: icon,
            onPressed: onPressed,
          ),
        ),
      ),
    );
  }
}