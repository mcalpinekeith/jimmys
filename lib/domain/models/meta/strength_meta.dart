import 'package:jimmys/core/extensions/map.dart';
import 'package:jimmys/domain/models/base_model.dart';
import 'package:jimmys/domain/models/exercise.dart';
import 'package:jimmys/domain/models/range.dart';

class StrengthMeta extends BaseMapModel {
  StrengthMeta({
    required this.sets,
    this.isDropSet = false,
    this.supersetExerciseId = '',
  });

  static const weightAboveDefaultValue = 8.5;
  static const paceBelowDefaultValue = 9.5;
  static const paceIncrement = 1.0;

  Map<double, Range> sets;  /// reps, weights
  bool isDropSet = false;
  String? supersetExerciseId;

  late Exercise? supersetExercise;

  @override
  StrengthMeta fromMap(Map<String, dynamic> map) => StrengthMeta(
    sets: map.value('sets'),
    isDropSet: map.value('is_drop_set', defaultValue: false),
    supersetExerciseId: map.valueOrNull('superset_exercise_id'),
  );

  @override
  Map<String, dynamic> toMap() => {
    'sets': sets,
    'is_drop_set': isDropSet,
    'superset_exercise_id': supersetExerciseId,
  };
}