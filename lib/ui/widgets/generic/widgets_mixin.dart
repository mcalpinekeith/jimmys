import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jimmys/ui/theme/constants.dart';
import 'package:jimmys/utilities/icon_service.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:jimmys/core/extensions/string.dart';

mixin WidgetsMixin {
  bool use24HourFormat(BuildContext context) => MediaQuery.of(context).alwaysUse24HourFormat;

  Widget logo() {
    return Container(
      padding: const EdgeInsets.all(spacingMedium),
      width: 300,
      height: 300,
      child: Image.asset('assets/images/logo-color-no-background-high-res.png'),
    );
  }

  Widget userAvatar(User? user) {
    Widget avatar = Image.memory(kTransparentImage);

    if (user != null && user.photoURL != null) {
      avatar = FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: user.photoURL!,
      );
    }

    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        width: imageSmall,
        height: imageSmall,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(shape: BoxShape.circle),
        child: avatar,
      ),
    );
  }

  Widget loader(ThemeData theme) {
    return SpinKitDualRing(
      color: theme.colorScheme.primary,
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(BuildContext context, String message) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  AutoScrollController scrollController(BuildContext context) {
    return AutoScrollController(
      viewportBoundaryGetter: () => Rect.fromLTRB(
        MediaQuery.of(context).padding.left,
        MediaQuery.of(context).padding.top,
        MediaQuery.of(context).padding.right,
        MediaQuery.of(context).padding.bottom
      ),
      axis: Axis.vertical,
      suggestedRowHeight: iconMedium + (spacingMicro * 2),
    );
  }
  Future<dynamic> navigate(BuildContext context, Widget page) {
    return Navigator.push(context, MaterialPageRoute(
        builder: (_) => page
    ));
  }

  AppBar appBar(ThemeData theme, String text, {List<Widget>? actions}) {
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

  Widget addAction(ThemeData theme, void Function()? onPressed) {
    return IconButton(
      iconSize: iconMedium,
      icon: const FaIcon(FontAwesomeIcons.plus),
      color: theme.colorScheme.onPrimary,
      onPressed: onPressed,
    );
  }

  Widget deleteAction(ThemeData theme, BuildContext context, String dataTypeText, void Function()? onPressed) {
    return IconButton(
      iconSize: iconMedium,
      icon: const FaIcon(FontAwesomeIcons.trash),
      color: Colors.red,
      onPressed: () => showDialog<void>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(radiusMedium))),
          title: Text('Confirm delete', style: titleMediumSecondary(theme)),
          content: Text('Are you sure you want to delete the $dataTypeText?', style: labelMediumSecondary(theme)),
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

  Widget fab(ThemeData theme, IconData icon, void Function() onPressed) {
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

  Widget icon(String? icon, ThemeData theme) {
    if (icon.isNullOrEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(right: spacingSmall),
      child: FaIcon(IconDataSolid(IconService.getIcon(icon!))),
    );
  }

  TextStyle headlineLargePrimary(ThemeData theme) {
    return theme.textTheme.headlineLarge!.copyWith(
      color: theme.colorScheme.primary,
    );
  }

  TextStyle titleMediumSecondary(ThemeData theme) {
    return theme.textTheme.titleMedium!.copyWith(
      color: theme.colorScheme.secondary,
    );
  }

  TextStyle labelMediumSecondary(ThemeData theme, {double fontSize = 20}) {
    return theme.textTheme.labelMedium!.copyWith(
      color: theme.colorScheme.secondary,
      fontSize: fontSize,
    );
  }

  TextStyle labelMediumOnPrimary(ThemeData theme, {double fontSize = 20}) {
    return theme.textTheme.labelMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
      fontSize: fontSize,
    );
  }
}