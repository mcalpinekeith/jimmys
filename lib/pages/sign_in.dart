import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jimmys/constants.dart';
import 'package:jimmys/functions.dart';
import 'package:jimmys/pages/startup.dart';
import 'package:jimmys/services/exercise_service.dart';
import 'package:jimmys/services/workout_service.dart';
import 'package:jimmys/types.dart';
import 'package:jimmys/widgets/my_button.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  Future _signIn(String provider, StringToVoidFunc onFail, VoidCallback onSuccess) async {
    try {
      switch (provider) {
        case 'Google':
          await _signInWithGoogle();
          break;
        case 'Facebook':
          await _signInWithFacebook();
          break;
        case 'Yahoo':
          await _signInWithYahoo();
          break;
      }
    }
    on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        onFail(e.message == null
          ? 'An unknown error has occurred.'
          : e.message as String);
      }

      return;
    }

    await WorkoutService().refresh();
    await ExerciseService().refresh(doRefreshShared: true);
    onSuccess();
  }

  Future<UserCredential?> _signInWithGoogle() async {
    // Trigger the authentication flow
    final googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) return null;

    // Obtain the auth details from the request
    final googleAuth = await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserCredential?> _signInWithFacebook() async {
    // Trigger the sign-in flow
    final loginResult = await FacebookAuth.instance.login();

    if (loginResult.accessToken == null) return null;

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);

    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

  Future<UserCredential> _signInWithYahoo() async {
    YahooAuthProvider yahooAuthProvider = YahooAuthProvider();

    // Call the login method to initiate the Yahoo login process
    return await FirebaseAuth.instance.signInWithProvider(yahooAuthProvider);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: createAppBar(theme, 'Welcome'),
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(spacingMedium),
              width: 300,
              height: 300,
              child: Image.asset('assets/images/logo-color-no-background-high-res.png'),
            ),
            MyButton(
              size: Sizes.large,
              label: const Text('Continue with Google'),
              icon: const FaIcon(FontAwesomeIcons.google),
              onTap: () async => await _onPressed('Google', context)
            ),
            MyButton(
              size: Sizes.large,
              label: const Text('Continue with Facebook'),
              icon: const FaIcon(FontAwesomeIcons.facebook),
              onTap: () async => await _onPressed('Facebook', context)
            ),
            MyButton(
              size: Sizes.large,
              label: const Text('Continue with Yahoo!'),
              icon: const FaIcon(FontAwesomeIcons.yahoo),
              onTap: () async => await _onPressed('Yahoo', context)
            ),
          ],
        ),
      ),
    );
  }

  Future _onPressed(String provider, BuildContext context) async {
    await _signIn(provider, 
      (fail) => _showFailMessage(context, fail),
      () => _navigateOnSuccess(context)
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> _showFailMessage(BuildContext context, String fail) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(fail),
    ));
  }

  Future<dynamic> _navigateOnSuccess(BuildContext context) {
    return Navigator.push(context, MaterialPageRoute(
      builder: (context) => const StartupPage()
    ));
  }
}