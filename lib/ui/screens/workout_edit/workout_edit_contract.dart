import 'package:jimmys/domain/models/exercise.dart';
import 'package:jimmys/domain/models/workout.dart';
import 'package:jimmys/domain/models/workout_exercise.dart';
import 'package:jimmys/ui/screens/_base/base_contract.dart';

class WorkoutEditViewModelState extends BaseViewModelState {
  late final Workout workout;
  late final bool isAdd;

  DateTime? lastSave;
  final List<String> categories = [];
  final List<WorkoutExercise> workoutExercises = [];
  final List<Exercise> exercises = [];

  Exercise? currentExercise;
}

abstract class WorkoutEditVContract extends BaseViewContract {
}

abstract class WorkoutEditVMContract extends BaseViewModelContract<WorkoutEditViewModelState, WorkoutEditVContract> {
  void remove();
  void removeWorkoutExercise(WorkoutExercise workoutExercise);
  void save();
  void saveWorkoutExercise(WorkoutExercise workoutExercise);
}