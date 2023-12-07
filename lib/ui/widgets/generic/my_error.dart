import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jimmys/ui/theme/constants.dart';

class MyError extends StatelessWidget {
  const MyError({
    super.key,
    required this.errorMessage,
    required this.animation,
    this.isInteractive = true,
    this.onTap,
  });

  final String errorMessage;
  final Animation<double> animation;
  final bool isInteractive;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.sizeOf(context).width;

    final card = Card(
      color: theme.colorScheme.onPrimary,
      elevation: theme.popupMenuTheme.elevation,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(radiusMedium))),
      child: Container(
        padding: const EdgeInsets.all(spacingSmall),
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(right: spacingSmall),
              child: FaIcon(FontAwesomeIcons.bug),
            ),
            SizedBox(
              width: width - (spacingMedium * 2),
              child: Text(
                errorMessage,
                style: theme.textTheme.titleLarge,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
          ],
        ),
      ),
    );

    if (isInteractive) {
      return SizeTransition(
        sizeFactor: animation,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          child: card,
        ),
      );
    }
    else {
      return SizeTransition(
        sizeFactor: animation,
        child: card,
      );
    }
  }
}