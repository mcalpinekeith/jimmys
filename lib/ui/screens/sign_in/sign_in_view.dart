import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jimmys/ui/screens/_base/base_view_widget_state.dart';
import 'package:jimmys/ui/screens/sign_in/sign_in_contract.dart';
import 'package:jimmys/ui/screens/startup/startup_view.dart';
import 'package:jimmys/ui/theme/constants.dart';
import 'package:jimmys/ui/widgets/generic/my_button.dart';
import 'package:jimmys/ui/widgets/generic/widgets_mixin.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewWidgetState();
}

class _SignInViewWidgetState extends BaseViewWidgetState<SignInView, SignInVMContract, SignInViewModelState> with WidgetsMixin implements SignInVContract {
  @override
  void onInitState() {}

  @override
  Widget contentBuilder(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, 'Welcome'),
      body: SafeArea(
        child: Column(
          children: [
            logo(),
            Visibility(
              visible: !vmState.isSigningIn,
              replacement: loader(context),
              child: Expanded(
                child: ListView(
                  children: [
                    MyButton(
                      size: Sizes.large,
                      label: const Text('Continue with Google'),
                      icon: const FaIcon(FontAwesomeIcons.google),
                      onPressed: () async => await continueOnPressed('Google')
                    ),
                    MyButton(
                      size: Sizes.large,
                      label: const Text('Continue with Facebook'),
                      icon: const FaIcon(FontAwesomeIcons.facebook),
                      onPressed: () async => await continueOnPressed('Facebook')
                    ),
                    MyButton(
                      size: Sizes.large,
                      label: const Text('Continue with Yahoo!'),
                      icon: const FaIcon(FontAwesomeIcons.yahoo),
                      onPressed: () async => await continueOnPressed('Yahoo')
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Future continueOnPressed(String provider) async {
    setState(() {
      vmState.isSigningIn = true;
    });

    await vmContract.signIn(provider,() => navigate(context, const StartupView()));
  }

  @override
  void showError(String message) {
    showSnackBar(context, message);
  }
}