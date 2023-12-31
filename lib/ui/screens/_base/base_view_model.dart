import 'package:flutter/foundation.dart';
import 'package:jimmys/ui/screens/_base/base_contract.dart';

abstract class BaseViewModel<VMS extends BaseViewModelState, VC extends BaseViewContract> extends ChangeNotifier implements BaseViewModelContract<VMS, VC> {
  @override
  late final VMS vmState;

  @override
  late final VC viewContract;

  /// Avoid uncaught exceptions when a notify Listener() is
  /// fired after the dispose() method is called on the corresponding view.
  @override
  void notifyListeners() {
    try {
      super.notifyListeners();
    } catch (_) {}
  }

  /// Handle to any data layer work or data
  /// processing to be performed when the view is initialized.
  @override
  void onInitState() {}

  /// Same for when the view is disposed.
  @override
  void onDisposeView() {}

  /// Update the state and notify listeners when loading starts.
  void startLoadingState() {
    vmState.isLoading = true;
    notifyListeners();
  }

  /// Update the state and notify listeners when loading finishes.
  void stopLoadingState() {
    vmState.isLoading = false;
    notifyListeners();
  }
}