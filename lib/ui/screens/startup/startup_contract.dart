import 'package:jimmys/domain/models/workout.dart';
import 'package:jimmys/ui/screens/_base/base_contract.dart';

class StartupViewModelState extends BaseViewModelState {
  final List<Workout> workoutList = [];
  Workout? todayWorkout;
}

abstract class StartupVContract extends BaseViewContract {
}

abstract class StartupVMContract extends BaseViewModelContract<StartupViewModelState, StartupVContract> {
}