import 'package:jimmys/domain/models/providers/workout_list.dart';
import 'package:jimmys/domain/models/workout.dart';
import 'package:jimmys/ui/screens/_base/base_contract.dart';

class WorkoutListViewModelState extends BaseViewModelState {
  late final WorkoutListProvider workoutListProvider;
  List<Workout> get workoutList => workoutListProvider.list;
}

abstract class WorkoutListVContract extends BaseViewContract {
}

abstract class WorkoutListVMContract extends BaseViewModelContract<WorkoutListViewModelState, WorkoutListVContract> {
}