import 'package:flutter/material.dart';

extension BuildContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get text => theme.textTheme;

  ColorScheme get color => theme.colorScheme;

  PopupMenuThemeData get popupTheme => theme.popupMenuTheme;

  DefaultTextStyle get textStyle => DefaultTextStyle.of(this);

  MediaQueryData get media => MediaQuery.of(this);

  NavigatorState get navigator => Navigator.of(this);

  FocusScopeNode get focus => FocusScope.of(this);

  ScaffoldState get scaffold => Scaffold.of(this);

  ScaffoldMessengerState get messenger => ScaffoldMessenger.of(this);
}