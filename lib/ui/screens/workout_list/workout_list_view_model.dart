import 'package:jimmys/domain/models/workout.dart';
import 'package:jimmys/domain/use_cases/workout_use_cases.dart';
import 'package:jimmys/ui/screens/_base/base_view_model.dart';
import 'package:jimmys/ui/screens/workout_list/workout_list_contract.dart';

class WorkoutListViewModel extends BaseViewModel<WorkoutListViewModelState, WorkoutListVContract> implements WorkoutListVMContract {
  final WorkoutUseCases _workoutInteractor;

  WorkoutListViewModel({
    required WorkoutUseCases workoutInteractor,
  }) : _workoutInteractor = workoutInteractor;

  @override
  void onInitState() {}

  @override
  Future<void> reload() async {
    vmState.hasError = false;
    startLoadingState();

    try {
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

  Future<void> _loadWorkouts() async {
    vmState.workoutList.clear();

    final workouts = await _workoutInteractor.get();
    for (var workout in workouts) {
      vmState.workoutList.add(WorkoutItem(workout));
    }
  }

  @override
  void saveWorkout(Workout workout) {
    vmState.hasError = false;

    try {
      _workoutInteractor.save(workout);
    }
    catch (ex) {
      vmState.hasError = true;
      viewContract.showError(ex.toString());
    }
  }

  @override
  void onDisposeView() {}
}