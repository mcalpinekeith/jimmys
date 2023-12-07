import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';
import 'package:jimmys/core/global.dart';
import 'package:jimmys/data/modules/services/store_service.dart';
import 'package:jimmys/domain/models/base_model.dart';

class MockFirestore {
  static MockUser mockUser = MockUser(
    isAnonymous: false,
    uid: 'mock_user_id',
    email: 'a@a.com',
    displayName: 'A-Team',
  );

  static Future<FakeFirebaseFirestore> getStore() async {
    final googleUser = await MockGoogleSignIn().signIn();
    final googleAuth = await googleUser?.authentication;

    final oauthCredential = GoogleAuthProvider.credential(
      accessToken: googleAuth!.accessToken,
      idToken: googleAuth.idToken,
    );

    final auth = MockFirebaseAuth(mockUser: mockUser);
    final store = FakeFirebaseFirestore(authObject: auth.authForFakeFirestore);
    final userCredential = await auth.signInWithCredential(oauthCredential);

    store.collection('users').doc(mockUser.uid).set({
      'uid': mockUser.uid,
      'email': mockUser.email,
      'displayName': mockUser.displayName,
    });

    return store;
  }

  static Future clear(BaseModel data) async {
    final snapshots = await getIt<StoreService>()
      .store
      .collection('users')
      .doc(mockUser.uid)
      .collection(data.path)
      .get()
      .then((_) => _.docs);

    for (final snapshot in snapshots) {
      await snapshot.reference.delete();
    }
  }
}