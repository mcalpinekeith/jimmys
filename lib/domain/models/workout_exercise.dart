/// Keep import of dynamic.dart - dynamic types use extensions at run-time
import 'package:jimmys/core/extensions/dynamic.dart';
import 'package:jimmys/core/extensions/map.dart';
import 'package:jimmys/domain/models/base_model.dart';
import 'package:jimmys/domain/models/exercise.dart';

class WorkoutExercise implements BaseModel {
  WorkoutExercise.empty();

  WorkoutExercise({
    required this.id,
    required this.workoutId,
    required this.exerciseId,
    this.isDropSet = false,
    required this.sequence,
    List<String>? sets,
    this.exercise,
    this.supersetExerciseId = '',
    this.supersetExercise,
    this.isShared = false,
  }) : sets = sets ?? [];

  @override
  String id = '';
  @override
  String get path => 'workout_exercises';
  String workoutId = '';
  String exerciseId = '';
  bool isDropSet = false;
  int sequence = 0;
  List<String> sets = [];

  late Exercise? exercise;
  String? supersetExerciseId;
  late Exercise? supersetExercise;
  bool isShared = false;

  @override
  WorkoutExercise fromMap(Map<String, dynamic> map) => WorkoutExercise(
    id: map.value('id', ''),
    workoutId: map.value('workout_id', ''),
    exerciseId: map.value('exercise_id', ''),
    isDropSet: map.value('is_drop_set', false),
    sequence: map.value('sequence', 1),
    sets: map.value('sets', []).toStringList(),
    supersetExerciseId: map.value('superset_exercise_id', ''),
  );

  @override
  Map<String, dynamic> toMap() => {
    'id': id,
    'workout_id': workoutId,
    'exercise_id': exerciseId,
    'is_drop_set': isDropSet,
    'sequence': sequence,
    'sets': sets,
    'superset_exercise_id': supersetExerciseId,
  };
}
