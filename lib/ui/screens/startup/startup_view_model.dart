import 'package:jimmys/domain/use_cases/workout_use_cases.dart';
import 'package:jimmys/ui/screens/_base/base_view_model.dart';
import 'package:jimmys/ui/screens/startup/startup_contract.dart';

class StartupViewModel extends BaseViewModel<StartupViewModelState, StartupVContract> implements StartupVMContract {
  final WorkoutUseCases _workoutInteractor;

  StartupViewModel({
    required WorkoutUseCases workoutInteractor,
  }) : _workoutInteractor = workoutInteractor;

  @override
  void onInitState() {}

  @override
  Future<void> reload() async {
    vmState.hasError = false;
    startLoadingState();

    try {
      await _loadTodayWorkout();
      await _loadWorkouts();
    }
    catch (ex) {
      vmState.hasError = true;
      viewContract.showError(ex.toString());
    }
    finally {
      stopLoadingState();
    }
  }

  Future<void> _loadTodayWorkout() async {
    vmState.todayWorkout = await _workoutInteractor.getTodayWorkout();
  }

  Future<void> _loadWorkouts() async {
    vmState.workoutList.clear();
    vmState.workoutList.addAll(await _workoutInteractor.get());
  }

  @override
  void onDisposeView() {}
}