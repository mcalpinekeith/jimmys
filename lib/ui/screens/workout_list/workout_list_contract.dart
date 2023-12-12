import 'package:jimmys/domain/models/workout.dart';
import 'package:jimmys/ui/screens/_base/base_contract.dart';

class WorkoutListViewModelState extends BaseViewModelState {
  final List<Workout> workoutList = [];
}

abstract class WorkoutListVContract extends BaseViewContract {
}

abstract class WorkoutListVMContract extends BaseViewModelContract<WorkoutListViewModelState, WorkoutListVContract> {
}