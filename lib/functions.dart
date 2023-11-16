import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:jimmys/constants.dart';

AppBar createAppBar(ThemeData theme, String text, {List<Widget>? actions}) {
  return AppBar(
    centerTitle: true,
    title: Text(
      text,
      style: theme.textTheme.headlineLarge!.copyWith(
        color: theme.colorScheme.onPrimary,
      ),
    ),
    backgroundColor: theme.colorScheme.primary,
    actions: actions,
  );
}

Widget createAddAction(ThemeData theme, void Function()? onPressed) {
  return IconButton(
    iconSize: iconMedium,
    icon: const FaIcon(FontAwesomeIcons.plus),
    color: theme.colorScheme.onPrimary,
    onPressed: onPressed,
  );
}

Widget createDeleteAction(ThemeData theme, BuildContext context, String dataTypeText, void Function()? onPressed) {
  return IconButton(
    iconSize: iconMedium,
    icon: const FaIcon(FontAwesomeIcons.trash),
    color: Colors.red,
    onPressed: () => showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        actionsAlignment: MainAxisAlignment.center,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(radiusMedium))),
        title: Text('Confirm delete', style: getTitleMediumSecondary(theme)),
        content: Text('Are you sure you want to delete the $dataTypeText?', style: getLabelMediumSecondary(theme)),
        actions: [
          IconButton(
            iconSize: iconLarge,
            icon: const FaIcon(FontAwesomeIcons.solidCircleXmark),
            color: Colors.black54,
            onPressed: () => Navigator.pop(context),
          ),
          IconButton(
            iconSize: iconLarge,
            icon: const FaIcon(FontAwesomeIcons.solidCircleCheck),
            color: theme.colorScheme.error,
            onPressed: onPressed,
          ),
        ],
      ),
    ),
  );
}

Widget createFloatingButton(ThemeData theme, IconData icon, void Function() onPressed) {
  return FloatingActionButton(
    onPressed: onPressed,
    shape: const CircleBorder(),
    elevation: theme.popupMenuTheme.elevation,
    backgroundColor: theme.colorScheme.primary,
    child: FaIcon(
      icon,
      color: theme.colorScheme.onPrimary,
      size: iconMedium,
    ),
  );
}

extension DateTimeExtensions on DateTime {
  String time(bool use24HourFormat) {
    if (use24HourFormat) {
      //24h format
      return DateFormat('HH:mm').format(this);
    } else {
      //12h format
      return DateFormat('h:mm a').format(this);
    }
  }
}

Widget createBusy(ThemeData theme) {
  return SpinKitDualRing(
    color: theme.colorScheme.primary,
  );
}

int getIcon(String code) {
  int result = 0;
  int len = code.length;

  for (int i = 0; i < len; i++) {
    int hexDigit = code.codeUnitAt(i);

    if (hexDigit >= 48 && hexDigit <= 57) {
      result += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
    } else if (hexDigit >= 65 && hexDigit <= 70) {
      // A..F
      result += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
    } else if (hexDigit >= 97 && hexDigit <= 102) {
      // a..f
      result += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
    } else {
      throw const FormatException("An error occurred when converting");
    }
  }

  return result;
}

Widget createIconWithPadding(String? icon, ThemeData theme) {
  if (icon == null) return const SizedBox.shrink();

  return Padding(
    padding: const EdgeInsets.fromLTRB(0, 0, spacingSmall, 0),
    child: FaIcon(IconDataSolid(getIcon(icon))),
  );
}

TextStyle getHeadlineLargePrimary(ThemeData theme) {
  return theme.textTheme.headlineLarge!.copyWith(
    color: theme.colorScheme.primary,
  );
}

TextStyle getTitleMediumSecondary(ThemeData theme) {
  return theme.textTheme.titleMedium!.copyWith(
    color: theme.colorScheme.secondary,
  );
}

TextStyle getLabelMediumSecondary(ThemeData theme, {double fontSize = 20}) {
  return theme.textTheme.labelMedium!.copyWith(
    color: theme.colorScheme.secondary,
    fontSize: fontSize,
  );
}

TextStyle getLabelMediumOnPrimary(ThemeData theme, {double fontSize = 20}) {
  return theme.textTheme.labelMedium!.copyWith(
    color: theme.colorScheme.onPrimary,
    fontSize: fontSize,
  );
}