import 'package:jimmys/ui/screens/_base/base_contract.dart';

class SignInViewModelState extends BaseViewModelState {
  bool isSigningIn = false;
}

abstract class SignInVContract extends BaseViewContract {
  Future continueOnPressed(String provider);
}

abstract class SignInVMContract extends BaseViewModelContract<SignInViewModelState, SignInVContract> {
  Future signIn(String provider, Function onSignIn);
}