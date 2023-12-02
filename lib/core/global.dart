import 'package:get_it/get_it.dart';
import 'package:jimmys/core/locator.dart';

final getIt = GetIt.instance;

class Global {
  static bool isTest = false;
  static bool isAppInitialized = false;

  static Future setUpTestMode() async {
    isTest = true;

    await initializeApp();
    await getIt.allReady();
  }
}