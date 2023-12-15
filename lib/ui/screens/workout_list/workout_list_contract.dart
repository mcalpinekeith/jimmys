import 'package:jimmys/domain/models/workout.dart';
import 'package:jimmys/ui/screens/_base/base_contract.dart';

class WorkoutListViewModelState extends BaseViewModelState {
  final List<WorkoutItem> workoutList = [];
}

abstract class WorkoutListVContract extends BaseViewContract {
}

abstract class WorkoutListVMContract extends BaseViewModelContract<WorkoutListViewModelState, WorkoutListVContract> {
}

class WorkoutItem {
  WorkoutItem(this.data);

  Workout data;
  bool isFiltered = false;
}