import 'package:jimmys/core/extensions/map.dart';
import 'package:jimmys/core/extensions/string.dart';
import 'package:jimmys/domain/enums/exercise_categories.dart';
import 'package:jimmys/domain/models/base_model.dart';
import 'package:jimmys/domain/models/exercise.dart';
import 'package:jimmys/domain/models/range.dart';

class WeightsMeta extends BaseMetaModel {
  WeightsMeta({
    required this.sets,
    this.isDropSet = false,
    this.supersetExerciseId,
  });

  static const weightAboveDefaultValue = 5.0;
  static const weightIncrement = 1.0;

  Map<double, Range> sets;  /// reps, weights
  bool isDropSet = false;
  String? supersetExerciseId;

  late Exercise? supersetExercise;

  @override
  WeightsMeta fromMap(Map<String, dynamic> map) => WeightsMeta(
    sets: map.value('sets'),
    isDropSet: map.value('is_drop_set', defaultValue: false),
    supersetExerciseId: map.valueOrNull('superset_exercise_id'),
  );

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> result = {};

    result['sets'] = sets;
    result['is_drop_set'] = isDropSet;

    if (supersetExerciseId.isNotNullNorEmpty) result['superset_exercise_id'] = supersetExerciseId;

    return result;
  }

  @override
  ExerciseCategories get exerciseCategory => ExerciseCategories.weights;
}