import 'package:jimmys/domain/enums/exercise_categories.dart';
import 'package:jimmys/domain/models/workout.dart';
import 'package:jimmys/ui/screens/_base/base_contract.dart';

class WorkoutListViewModelState extends BaseViewModelState {
  final List<WorkoutItem> workoutList = [];
  final List<ExerciseCategoryItem> exerciseCategoryList = [];
}

abstract class WorkoutListVContract extends BaseViewContract {
}

abstract class WorkoutListVMContract extends BaseViewModelContract<WorkoutListViewModelState, WorkoutListVContract> {
  void saveWorkout(Workout workout);
}

class WorkoutItem {
  WorkoutItem(this.data);

  Workout data;
  bool isVisible = true;
}

class ExerciseCategoryItem {
  ExerciseCategoryItem(this.data);

  ExerciseCategories data;
  bool isSelected = false;
}