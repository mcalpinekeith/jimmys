import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jimmys/ui/screens/_base/base_view_model.dart';
import 'package:jimmys/ui/screens/sign_in/sign_in_contract.dart';
import 'package:jimmys/core/extensions/string.dart';

class SignInViewModel extends BaseViewModel<SignInVMState, SignInViewContract> implements SignInVMContract {
  @override
  void onInitState() {
    vmState.isLoading = true;
    vmState.isSigningIn = false;
  }

  @override
  Future signIn(String provider, Function onSignIn) async {
    vmState.hasError = false;

    try {
      switch (provider) {
        case 'Google':
          await signInWithGoogle();
          break;
        case 'Facebook':
          await signInWithFacebook();
          break;
        case 'Yahoo':
          await signInWithYahoo();
          break;
      }
    }
    on FirebaseAuthException catch (error) {
      if (error.code == 'account-exists-with-different-credential') {
        vmState.hasError = true;

        final message = error.message.isNullOrEmpty
          ? 'An unknown error has occurred.'
          : error.message as String;

        viewContract.showError(message);
        return;
      }
    }

    onSignIn();
  }

  Future<UserCredential?> signInWithGoogle() async {
    /// Trigger the authentication flow
    final googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) return null;

    /// Obtain the auth details from the request
    final googleAuth = await googleUser.authentication;

    /// Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserCredential?> signInWithFacebook() async {
    // Trigger the sign-in flow
    final loginResult = await FacebookAuth.instance.login();

    if (loginResult.accessToken == null) return null;

    /// Create a credential from the access token
    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);

    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

  Future<UserCredential> signInWithYahoo() async {
    YahooAuthProvider yahooAuthProvider = YahooAuthProvider();

    /// Call the login method to initiate the Yahoo login process
    return await FirebaseAuth.instance.signInWithProvider(yahooAuthProvider);
  }

  @override
  void onDisposeView() {}
}