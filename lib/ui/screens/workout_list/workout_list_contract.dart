import 'package:jimmys/domain/models/workout.dart';
import 'package:jimmys/ui/screens/_base/base_contract.dart';

class WorkoutListVMState extends BaseViewModelState {
  final List<Workout> workoutList = [];
}

abstract class WorkoutListViewContract extends BaseViewContract {
}

abstract class WorkoutListVMContract extends BaseViewModelContract<WorkoutListVMState, WorkoutListViewContract> {
}