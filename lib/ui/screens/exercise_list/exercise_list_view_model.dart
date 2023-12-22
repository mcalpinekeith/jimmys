import 'package:jimmys/domain/models/exercise.dart';
import 'package:jimmys/domain/use_cases/exercise_use_cases.dart';
import 'package:jimmys/ui/screens/_base/base_view_model.dart';
import 'package:jimmys/ui/screens/exercise_list/exercise_list_contract.dart';

class ExerciseListViewModel extends BaseViewModel<ExerciseListViewModelState, ExerciseListVContract> implements ExerciseListVMContract {
  final ExerciseUseCases _exerciseInteractor;

  ExerciseListViewModel({
    required ExerciseUseCases exerciseInteractor,
  }) : _exerciseInteractor = exerciseInteractor;

  @override
  void onInitState() {}

  @override
  Future<void> reload() async {
    vmState.hasError = false;
    startLoadingState();

    try {
      await _loadExercises();
    }
    catch (ex) {
      vmState.hasError = true;
      viewContract.showError(ex.toString());
    }
    finally {
      stopLoadingState();
    }
  }

  Future<void> _loadExercises() async {
    vmState.exerciseList.clear();

    final exercises = await _exerciseInteractor.get();
    for (var exercise in exercises) {
      vmState.exerciseList.add(ExerciseItem(exercise));
    }
  }

  @override
  void saveExercise(Exercise exercise) {
    vmState.hasError = false;

    try {
      _exerciseInteractor.save(exercise);
    }
    catch (ex) {
      vmState.hasError = true;
      viewContract.showError(ex.toString());
    }
  }

  @override
  void onDisposeView() {}
}