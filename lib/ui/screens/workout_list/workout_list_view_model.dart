import 'package:jimmys/domain/use_cases/workout_use_cases.dart';
import 'package:jimmys/ui/screens/_base/base_view_model.dart';
import 'package:jimmys/ui/screens/workout_list/workout_list_contract.dart';

class WorkoutListViewModel extends BaseViewModel<WorkoutListVMState, WorkoutListViewContract> implements WorkoutListVMContract {
  final WorkoutUseCases _workoutInteractor;

  WorkoutListViewModel({
    required WorkoutUseCases workoutInteractor,
  }) : _workoutInteractor = workoutInteractor;

  @override
  void onInitState() {
    vmState.isLoading = true;

    _loadWorkouts();
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

    stopLoadingState();
  }

  @override
  void onDisposeView() {}
}