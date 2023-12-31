import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jimmys/ui/theme/constants.dart';
import 'package:jimmys/ui/widgets/generic/widgets_mixin.dart';

class MyNumberStepper extends StatefulWidget {
  const MyNumberStepper({
    super.key,
    required this.initialValue,
    this.minValue = 1,
    this.maxValue = 9999999,
    required this.step,
    required this.onChanged,
  });

  final int initialValue;
  final int minValue;
  final int maxValue;
  final int step;
  final Function(int) onChanged;

  @override
  State<MyNumberStepper> createState() => _MyNumberStepperState();
}

class _MyNumberStepperState extends State<MyNumberStepper> with WidgetsMixin {
  int _currentValue = 0;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          iconSize: iconMedium,
          icon: const FaIcon(FontAwesomeIcons.circleMinus),
          onPressed: _decreaseOnPressed,
        ),
        ConstrainedBox(
          constraints: const BoxConstraints.tightForFinite(width: 100),
          child: Text(_currentValue.toString(),
            style: labelMediumSecondary(context),
            textAlign: TextAlign.center,
          ),
        ),
        IconButton(
          iconSize: iconMedium,
          icon: const FaIcon(FontAwesomeIcons.circlePlus),
          onPressed: _increaseOnPressed,
        ),
      ],
    );
  }

  void _decreaseOnPressed() {
    setState(() {
      if (_currentValue > widget.minValue) _currentValue -= widget.step;
      widget.onChanged(_currentValue);
    });
  }

  void _increaseOnPressed() {
    setState(() {
      if (_currentValue < widget.maxValue) _currentValue += widget.step;
      widget.onChanged(_currentValue);
    });
  }
}