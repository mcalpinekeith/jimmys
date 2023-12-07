import 'package:firebase_core/firebase_core.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glassy/glassy.dart';
import 'package:glassy/glassy_config.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jimmys/core/global.dart';
import 'package:jimmys/core/locator.dart';
import 'package:jimmys/data/modules/services/user_service.dart';
import 'package:jimmys/ui/screens/sign_in/sign_in_view.dart';
import 'package:jimmys/ui/theme/constants.dart';
import 'package:jimmys/firebase_options.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  Glassy().setConfig(GlassyConfig(radius: radiusSmall, backgroundColor: Colors.transparent, backgroundOpacity: 0, borderOpacity: 0));

  initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserService>(create: (_) => getIt<UserService>()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      gestures: const [
        GestureType.onTap,
        GestureType.onDoubleTap,
        GestureType.onHorizontalDragStart,
        GestureType.onVerticalDragStart,
        GestureType.onPanUpdateDownDirection,
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Jimmy\'s',
        theme: FlexThemeData.light(
          scheme: FlexScheme.blueM3,
          surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
          blendLevel: 10,
          appBarStyle: FlexAppBarStyle.background,
          bottomAppBarElevation: 1.0,
          subThemesData: const FlexSubThemesData(
            blendOnLevel: 20,
            blendTextTheme: true,
            useTextTheme: true,
            useM2StyleDividerInM3: true,
            thickBorderWidth: 2.0,
            elevatedButtonSchemeColor: SchemeColor.onPrimaryContainer,
            elevatedButtonSecondarySchemeColor: SchemeColor.primaryContainer,
            outlinedButtonOutlineSchemeColor: SchemeColor.primary,
            toggleButtonsBorderSchemeColor: SchemeColor.primary,
            segmentedButtonSchemeColor: SchemeColor.primary,
            segmentedButtonBorderSchemeColor: SchemeColor.primary,
            unselectedToggleIsColored: true,
            sliderValueTinted: true,
            inputDecoratorSchemeColor: SchemeColor.primary,
            inputDecoratorBackgroundAlpha: 15,
            inputDecoratorRadius: 10.0,
            inputDecoratorPrefixIconSchemeColor: SchemeColor.primary,
            chipRadius: 10.0,
            popupMenuRadius: 6.0,
            popupMenuElevation: 6.0,
            alignedDropdown: true,
            useInputDecoratorThemeInDialogs: true,
            appBarScrolledUnderElevation: 8.0,
            drawerWidth: 280.0,
            drawerIndicatorSchemeColor: SchemeColor.primary,
            bottomNavigationBarMutedUnselectedLabel: false,
            bottomNavigationBarMutedUnselectedIcon: false,
            menuRadius: 6.0,
            menuElevation: 6.0,
            menuBarRadius: 0.0,
            menuBarElevation: 1.0,
            navigationBarSelectedLabelSchemeColor: SchemeColor.primary,
            navigationBarMutedUnselectedLabel: false,
            navigationBarSelectedIconSchemeColor: SchemeColor.onPrimary,
            navigationBarMutedUnselectedIcon: false,
            navigationBarIndicatorSchemeColor: SchemeColor.primary,
            navigationBarIndicatorOpacity: 1.00,
            navigationBarElevation: 2.0,
            navigationBarHeight: 70.0,
            navigationRailSelectedLabelSchemeColor: SchemeColor.primary,
            navigationRailMutedUnselectedLabel: false,
            navigationRailSelectedIconSchemeColor: SchemeColor.onPrimary,
            navigationRailMutedUnselectedIcon: false,
            navigationRailIndicatorSchemeColor: SchemeColor.primary,
            navigationRailIndicatorOpacity: 1.00,
          ),
          keyColors: const FlexKeyColors(
            useTertiary: true,
            keepPrimary: true,
            keepTertiary: true,
          ),
          visualDensity: FlexColorScheme.comfortablePlatformDensity,
          useMaterial3: true,
          swapLegacyOnMaterial3: true,
          textTheme: GoogleFonts.latoTextTheme(),
          fontFamily: GoogleFonts.lato().fontFamily,
        ),
        darkTheme: FlexThemeData.dark(
          scheme: FlexScheme.blueM3,
          surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
          blendLevel: 15,
          appBarStyle: FlexAppBarStyle.background,
          bottomAppBarElevation: 2.0,
          subThemesData: const FlexSubThemesData(
            blendOnLevel: 40,
            blendTextTheme: true,
            useTextTheme: true,
            useM2StyleDividerInM3: true,
            thickBorderWidth: 2.0,
            elevatedButtonSchemeColor: SchemeColor.onPrimaryContainer,
            elevatedButtonSecondarySchemeColor: SchemeColor.primaryContainer,
            outlinedButtonOutlineSchemeColor: SchemeColor.primary,
            toggleButtonsBorderSchemeColor: SchemeColor.primary,
            segmentedButtonSchemeColor: SchemeColor.primary,
            segmentedButtonBorderSchemeColor: SchemeColor.primary,
            unselectedToggleIsColored: true,
            sliderValueTinted: true,
            inputDecoratorSchemeColor: SchemeColor.primary,
            inputDecoratorBackgroundAlpha: 22,
            inputDecoratorRadius: 10.0,
            chipRadius: 10.0,
            popupMenuRadius: 6.0,
            popupMenuElevation: 6.0,
            alignedDropdown: true,
            useInputDecoratorThemeInDialogs: true,
            drawerWidth: 280.0,
            drawerIndicatorSchemeColor: SchemeColor.primary,
            bottomNavigationBarMutedUnselectedLabel: false,
            bottomNavigationBarMutedUnselectedIcon: false,
            menuRadius: 6.0,
            menuElevation: 6.0,
            menuBarRadius: 0.0,
            menuBarElevation: 1.0,
            navigationBarSelectedLabelSchemeColor: SchemeColor.primary,
            navigationBarMutedUnselectedLabel: false,
            navigationBarSelectedIconSchemeColor: SchemeColor.onPrimary,
            navigationBarMutedUnselectedIcon: false,
            navigationBarIndicatorSchemeColor: SchemeColor.primary,
            navigationBarIndicatorOpacity: 1.00,
            navigationBarElevation: 2.0,
            navigationBarHeight: 70.0,
            navigationRailSelectedLabelSchemeColor: SchemeColor.primary,
            navigationRailMutedUnselectedLabel: false,
            navigationRailSelectedIconSchemeColor: SchemeColor.onPrimary,
            navigationRailMutedUnselectedIcon: false,
            navigationRailIndicatorSchemeColor: SchemeColor.primary,
            navigationRailIndicatorOpacity: 1.00,
          ),
          keyColors: const FlexKeyColors(
            useTertiary: true,
            keepPrimary: true,
          ),
          visualDensity: FlexColorScheme.comfortablePlatformDensity,
          useMaterial3: true,
          swapLegacyOnMaterial3: true,
          textTheme: GoogleFonts.latoTextTheme(),
          fontFamily: GoogleFonts.lato().fontFamily,
        ),
        themeMode: ThemeMode.system,
        home: const SignInView(),
      ),
    );
  }
}
