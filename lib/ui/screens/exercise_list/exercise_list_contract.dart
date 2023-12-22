import 'package:jimmys/domain/models/exercise.dart';
import 'package:jimmys/ui/screens/_base/base_contract.dart';

class ExerciseListViewModelState extends BaseViewModelState {
  final List<ExerciseItem> exerciseList = [];
}

abstract class ExerciseListVContract extends BaseViewContract {
}

abstract class ExerciseListVMContract extends BaseViewModelContract<ExerciseListViewModelState, ExerciseListVContract> {
  void saveExercise(Exercise exercise);
}

class ExerciseItem {
  ExerciseItem(this.data);

  Exercise data;
  List<bool> isVisible = List<bool>.filled(3, true);
}