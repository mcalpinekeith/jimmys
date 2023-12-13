import 'package:jimmys/ui/screens/_base/base_contract.dart';

class SignInViewModelState extends BaseViewModelState {
  bool isSignedIn = false;
}

abstract class SignInVContract extends BaseViewContract {
}

abstract class SignInVMContract extends BaseViewModelContract<SignInViewModelState, SignInVContract> {
  Future<void> signIn(String provider, Function onSignIn);
}