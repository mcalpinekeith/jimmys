import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jimmys/core/extensions/build_context.dart';
import 'package:jimmys/ui/theme/constants.dart';
import 'package:jimmys/utilities/icon_service.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:jimmys/core/extensions/string.dart';

mixin WidgetsMixin {
  bool use24HourFormat(BuildContext context) => context.mediaQuery.alwaysUse24HourFormat;
  Widget get nothing => const SizedBox.shrink();

  Widget logo() => Container(
    padding: const EdgeInsets.all(spacingMedium),
    width: 300,
    height: 300,
    child: Image.asset('assets/images/logo-color-no-background-high-res.png'),
  );

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

  Widget loader(BuildContext context, {double size = 45.0, EdgeInsets? padding}) => _paddingWrapper(
    child: SpinKitDualRing(
      size: size,
      color: context.colorScheme.primary,
    ),
    padding: padding,
  );

  Widget _paddingWrapper({required Widget child, EdgeInsets? padding}) {
    if (padding == null) return child;

    return Padding(
      padding: padding,
      child: child,
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(BuildContext context, String message) => context.scaffoldMessenger.showSnackBar(SnackBar(
    content: Text(message),
  ));

  AutoScrollController scrollController(BuildContext context) => AutoScrollController(
    viewportBoundaryGetter: () => Rect.fromLTRB(
      context.mediaQuery.padding.left,
      context.mediaQuery.padding.top,
      context.mediaQuery.padding.right,
      context.mediaQuery.padding.bottom
    ),
    axis: Axis.vertical,
    suggestedRowHeight: iconMedium + (spacingMicro * 2),
  );

  Future<void> navigate(BuildContext context, Widget page) async {
    await context.navigator.push(MaterialPageRoute(
      builder: (_) => page
    ));
  }

  void pop(BuildContext context) => context.navigator.pop();

  AppBar appBar(BuildContext context, String text, {List<Widget>? actions}) => AppBar(
    centerTitle: true,
    title: Text(text,
      style: context.textTheme.headlineLarge!.copyWith(
        color: context.colorScheme.onPrimary,
      ),
    ),
    backgroundColor: context.colorScheme.primary,
    actions: actions,
  );

  AppBar emptyAppBar() => AppBar(
    toolbarHeight: iconLarge,
    backgroundColor: Colors.transparent,
  );

  SearchBar searchBar(BuildContext context, TextEditingController controller) => SearchBar(
    hintText: 'Search',
    controller: controller,
    leading: const FaIcon(FontAwesomeIcons.magnifyingGlass),
    trailing: const [FaIcon(FontAwesomeIcons.microphone)],
  );

  Widget addAction(BuildContext context, void Function()? onPressed) => IconButton(
    iconSize: iconMedium,
    icon: const FaIcon(FontAwesomeIcons.plus),
    color: context.colorScheme.onPrimary,
    onPressed: onPressed,
  );

  Widget deleteAction(BuildContext context, String dataTypeText, void Function()? onPressed) => IconButton(
    iconSize: iconMedium,
    icon: const FaIcon(FontAwesomeIcons.trash),
    color: Colors.red,
    onPressed: () => showDialog<void>(
      context: context,
      builder: (BuildContext context) => deleteActionDialog(context, dataTypeText, onPressed),
    ),
  );

  AlertDialog deleteActionDialog(BuildContext context, String dataTypeText, void Function()? onPressed) => AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(radiusMedium))),
      title: Text('Confirm delete',
        style: titleMediumSecondary(context)
      ),
      content: Text('Are you sure you want to delete the $dataTypeText?',
        style: labelMediumSecondary(context)
      ),
      actions: [
        IconButton(
          iconSize: iconLarge,
          icon: const FaIcon(FontAwesomeIcons.solidCircleXmark),
          color: Colors.black54,
          onPressed: () => pop(context),
        ),
        IconButton(
          iconSize: iconLarge,
          icon: const FaIcon(FontAwesomeIcons.solidCircleCheck),
          color: context.colorScheme.error,
          onPressed: onPressed,
        ),
      ],
    );

  void dismissKeyboard() => FocusManager.instance.primaryFocus?.unfocus();

  Widget fab(BuildContext context, IconData icon, void Function() onPressed) => FloatingActionButton(
    onPressed: onPressed,
    shape: const CircleBorder(),
    elevation: context.popupMenuTheme.elevation,
    backgroundColor: context.colorScheme.primary,
    child: FaIcon(
      icon,
      color: context.colorScheme.onPrimary,
      size: iconMedium,
    ),
  );

  Widget icon(String? icon) {
    if (icon.isNullOrEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(right: spacingSmall),
      child: FaIcon(IconDataSolid(IconService.getIcon(icon!))),
    );
  }

  TextStyle headlineLargePrimary(BuildContext context) => context.textTheme.headlineLarge!.copyWith(
    color: context.colorScheme.primary,
  );

  TextStyle titleMediumSecondary(BuildContext context) => context.textTheme.titleMedium!.copyWith(
    color: context.colorScheme.secondary,
  );

  TextStyle labelMediumSecondary(BuildContext context, {double fontSize = 20}) => context.textTheme.labelMedium!.copyWith(
    color: context.colorScheme.secondary,
    fontSize: fontSize,
  );

  TextStyle labelMediumOnPrimary(BuildContext context, {double fontSize = 20}) => context.textTheme.labelMedium!.copyWith(
    color: context.colorScheme.onPrimary,
    fontSize: fontSize,
  );
}