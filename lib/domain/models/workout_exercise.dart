import 'package:jimmys/domain/models/base_model.dart';
import 'package:jimmys/domain/models/exercise.dart';
import 'package:jimmys/utilities/functions.dart';

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
    id: map['id']! as String,
    workoutId: map['workout_id']! as String,
    exerciseId: map['exercise_id']! as String,
    isDropSet: !map.containsKey('is_drop_set') || map['is_drop_set'] == null
      ? false
      : map['is_drop_set']! as bool,
    sequence: map['sequence']! as int,
    sets: !map.containsKey('sets')
      ? []
      : getList(map['sets']!),
    supersetExerciseId: !map.containsKey('superset_exercise_id') || map['superset_exercise_id'] == null
      ? ''
      : map['superset_exercise_id']! as String,
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

  // TODO deprecated
  WorkoutExercise.fromMap(Map<String, Object?> map) : this(
    id: map['id']! as String,
    workoutId: map['workout_id']! as String,
    exerciseId: map['exercise_id']! as String,
    isDropSet: !map.containsKey('is_drop_set') || map['is_drop_set'] == null
      ? false
      : map['is_drop_set']! as bool,
    sequence: map['sequence']! as int,
    sets: !map.containsKey('sets') || map['sets'] == null
      ? []
      : getList(map['sets']!),
    supersetExerciseId: !map.containsKey('superset_exercise_id') || map['superset_exercise_id'] == null
        ? ''
        : map['superset_exercise_id']! as String,
  );
}
