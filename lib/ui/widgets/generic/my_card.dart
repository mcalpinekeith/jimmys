import 'package:flutter/material.dart';
import 'package:jimmys/ui/theme/constants.dart';

class MyCard extends StatelessWidget {
  const MyCard({
    super.key,
    required this.animation,
    required this.child,
    this.isInteractive = true,
    this.onTap,
  });

  final Animation<double> animation;
  final Widget child;
  final bool isInteractive;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizeTransition(
      sizeFactor: animation,
      child: _childWrapper(Card(
        color: theme.colorScheme.onPrimary,
        elevation: theme.popupMenuTheme.elevation,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(radiusMedium))
        ),
        child: child,
      )),
    );
  }

  Widget _childWrapper(Card card) {
    if (!isInteractive) return card;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: card,
    );
  }
}