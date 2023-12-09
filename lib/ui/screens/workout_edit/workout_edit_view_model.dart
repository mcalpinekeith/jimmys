import 'package:english_words/english_words.dart';
import 'package:jimmys/domain/models/workout.dart';
import 'package:jimmys/domain/models/workout_exercise.dart';
import 'package:jimmys/domain/use_cases/exercise_use_cases.dart';
import 'package:jimmys/domain/use_cases/workout_exercise_use_cases.dart';
import 'package:jimmys/domain/use_cases/workout_use_cases.dart';
import 'package:jimmys/ui/screens/_base/base_view_model.dart';
import 'package:jimmys/ui/screens/workout_edit/workout_edit_contract.dart';
import 'package:uuid/uuid.dart';

class WorkoutEditViewModel extends BaseViewModel<WorkoutEditViewModelState, WorkoutEditVContract> implements WorkoutEditVMContract {
  final WorkoutUseCases _workoutInteractor;
  final WorkoutExerciseUseCases _workoutExerciseInteractor;
  final ExerciseUseCases _exerciseInteractor;

  WorkoutEditViewModel({
    required WorkoutUseCases workoutInteractor,
    required WorkoutExerciseUseCases workoutExerciseInteractor,
    required ExerciseUseCases exerciseInteractor,
  }) :
    _workoutInteractor = workoutInteractor,
    _workoutExerciseInteractor = workoutExerciseInteractor,
    _exerciseInteractor = exerciseInteractor;

  @override
  Future<void> onInitState() async {
    vmState.isLoading = true;

    await _loadWorkoutExercises();
    await _loadCategories();
    await _loadExercises();

    stopLoadingState();
  }

  Future _loadWorkoutExercises() async {
    vmState.hasError = false;

    try {
      vmState.workoutExercises.clear();

      if (!vmState.isAdd) {
        vmState.workoutExercises.addAll(await _workoutExerciseInteractor.get(criteria: ('workout_id', vmState.workout.id)));
        vmState.workoutExercises.sort((a, b) => a.sequence.compareTo(b.sequence));
      }
    }
    catch (ex) {
      vmState.hasError = true;
      viewContract.showError(ex.toString());
    }
  }

  Future _loadCategories() async {
    vmState.hasError = false;

    try {
      vmState.categories.clear();
      vmState.categories.addAll(await _workoutInteractor.getCategories());
    }
    catch (ex) {
      vmState.hasError = true;
      viewContract.showError(ex.toString());
    }
  }

  Future _loadExercises() async {
    vmState.hasError = false;

    try {
      vmState.exercises.clear();
      vmState.exercises.addAll(await _exerciseInteractor.get());
    }
    catch (ex) {
      vmState.hasError = true;
      viewContract.showError(ex.toString());
    }
  }

  @override
  void remove() {
    vmState.hasError = false;

    try {
      if (!vmState.isAdd) {
        _workoutInteractor.remove(vmState.workout);
      }
    }
    catch (ex) {
      vmState.hasError = true;
      viewContract.showError(ex.toString());
    }
  }

  @override
  void save() {
    vmState.hasError = false;

    try {
      _workoutInteractor.save(vmState.workout);
    }
    catch (ex) {
      vmState.hasError = true;
      viewContract.showError(ex.toString());
    }
  }

  @override
  void saveWorkoutExercise(WorkoutExercise workoutExercise) {
    vmState.hasError = false;

    try {
      _workoutExerciseInteractor.save(workoutExercise);
    }
    catch (ex) {
      vmState.hasError = true;
      viewContract.showError(ex.toString());
    }
  }

  @override
  void onDisposeView() {}
}