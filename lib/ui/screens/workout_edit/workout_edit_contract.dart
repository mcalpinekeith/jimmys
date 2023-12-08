import 'package:jimmys/core/extensions/string.dart';
import 'package:jimmys/domain/models/exercise.dart';
import 'package:jimmys/domain/models/workout.dart';
import 'package:jimmys/domain/models/workout_exercise.dart';
import 'package:jimmys/ui/screens/_base/base_contract.dart';

class WorkoutEditViewModelState extends BaseViewModelState {
  late Workout workout;

  DateTime? lastSave;
  String? workoutId;
  bool get isAdd => workoutId.isNullOrEmpty;
  final List<String> categories = [];
  final List<WorkoutExercise> workoutExercises = [];
  final List<Exercise> exercises = [];

  Exercise? currentExercise;
}

abstract class WorkoutEditVContract extends BaseViewContract {

}

abstract class WorkoutEditVMContract extends BaseViewModelContract<WorkoutEditViewModelState, WorkoutEditVContract> {
  void remove();
  void save();
  void saveWorkoutExercise(WorkoutExercise workoutExercise);
}