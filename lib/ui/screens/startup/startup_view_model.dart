import 'package:jimmys/domain/use_cases/workout_use_cases.dart';
import 'package:jimmys/ui/screens/_base/base_view_model.dart';
import 'package:jimmys/ui/screens/startup/startup_contract.dart';

class StartupViewModel extends BaseViewModel<StartupViewModelState, StartupVContract> implements StartupVMContract {
  final WorkoutUseCases _workoutInteractor;

  StartupViewModel({
    required WorkoutUseCases workoutInteractor,
  }) : _workoutInteractor = workoutInteractor;

  @override
  void onInitState() {
    startLoadingState();

    vmState.todayWorkout = _workoutInteractor.todayWorkout;

    _loadWorkouts();
    stopLoadingState();
  }

  Future _loadWorkouts() async {
    vmState.hasError = false;

    try {
      vmState.workoutList.clear();
      vmState.workoutList.addAll(await _workoutInteractor.get());
    }
    on Exception catch (ex) {
      vmState.hasError = true;
      viewContract.showError(ex.toString());
    }
  }

  @override
  void onDisposeView() {}
}