import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';
import 'package:jimmys/core/global.dart';
import 'package:jimmys/data/modules/services/store_service.dart';
import 'package:jimmys/data/modules/services/user_service.dart';
import 'package:jimmys/domain/models/base_model.dart';

class MockFirestore {
  static Future<FakeFirebaseFirestore> getStore() async {
    final googleUser = await MockGoogleSignIn().signIn();
    final googleAuth = await googleUser?.authentication;

    final oauthCredential = GoogleAuthProvider.credential(
      accessToken: googleAuth!.accessToken,
      idToken: googleAuth.idToken,
    );

    final user = MockUser(
      isAnonymous: false,
      uid: 'QH2VKFaHO8SKC0NH8nyIxbaP5O22',
      email: 'a@a.com',
      displayName: 'A-Team',
    );

    final auth = MockFirebaseAuth(mockUser: user);
    final store = FakeFirebaseFirestore(authObject: auth.authForFakeFirestore);
    final userCredential = await auth.signInWithCredential(oauthCredential);

    getIt<UserService>().user = userCredential.user;

    store.collection('users').doc(user.uid).set({
      'uid': 'QH2VKFaHO8SKC0NH8nyIxbaP5O22',
      'email': 'a@a.com',
      'displayName': 'A-Team',
    });

    return store;
  }

  static Future clear(BaseModel data) async {
    final snapshots = await getIt<StoreService>()
      .store
      .collection('users')
      .doc('QH2VKFaHO8SKC0NH8nyIxbaP5O22')
      .collection(data.path)
      .get()
      .then((_) => _.docs);

    for (final snapshot in snapshots) {
      await snapshot.reference.delete();
    }
  }
}