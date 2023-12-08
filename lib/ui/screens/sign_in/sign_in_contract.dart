import 'package:flutter/material.dart';
import 'package:jimmys/ui/screens/_base/base_contract.dart';

class SignInVMState extends BaseViewModelState {
  bool isSigningIn = false;
}

abstract class SignInViewContract extends BaseViewContract {
  Future continueOnPressed(String provider, BuildContext context);
}

abstract class SignInVMContract extends BaseViewModelContract<SignInVMState, SignInViewContract> {
  Future signIn(String provider, Function onSignIn);
}