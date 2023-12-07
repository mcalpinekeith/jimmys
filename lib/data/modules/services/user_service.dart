import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:jimmys/core/global.dart';
import 'package:jimmys/utilities/test/mock_firestore.dart';

class UserService extends ChangeNotifier {
  // No User instance for test cases.
  User? get user => (Global.isTest ? null : FirebaseAuth.instance.currentUser);
  String? get userId => (Global.isTest ? MockFirestore.mockUser.uid : FirebaseAuth.instance.currentUser?.uid);

  UserService() {
    FirebaseAuth.instance.userChanges().listen((_) => notifyListeners);
  }
}