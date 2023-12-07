import 'package:jimmys/domain/models/workout.dart';
import 'package:jimmys/ui/screens/_base/base_contract.dart';

class StartupVMState extends BaseViewModelState {
  final List<Workout> workoutList = [];
  Workout? todayWorkout;
}

abstract class StartupViewContract extends BaseViewContract {
}

abstract class StartupVMContract extends BaseViewModelContract<StartupVMState, StartupViewContract> {
}