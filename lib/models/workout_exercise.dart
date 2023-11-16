import 'package:jimmys/models/exercise.dart';

class WorkoutExercise {
  WorkoutExercise({
    required this.id,
    required this.workoutId,
    required this.exerciseId,
    required this.isDropSet,
    required this.sequence,
    required this.sets,
    this.exercise,
    this.supersetExerciseId,
    this.supersetExercise,
  });

  String id = '';
  String workoutId = '';
  String exerciseId = '';
  bool isDropSet = false;
  int sequence = 0;
  List<dynamic> sets = <String>[];

  late Exercise? exercise;
  late String? supersetExerciseId;
  late Exercise? supersetExercise;

  WorkoutExercise.fromMap(Map<String, Object?> map) : this(
    id: map['id']! as String,
    workoutId: map['workout_id']! as String,
    exerciseId: map['exercise_id']! as String,
    isDropSet: map['is_drop_set']! as bool,
    sequence: map['sequence']! as int,
    sets: map['sets']! as List<dynamic>,
    supersetExerciseId: map['superset_exercise_id'] as String?,
  );

  Map<String, Object?> toMap() => {
    'id': id,
    'workout_id': workoutId,
    'exercise_id': exerciseId,
    'is_drop_set': isDropSet,
    'sequence': sequence,
    'sets': sets,
    'superset_exercise_id': supersetExerciseId,
  };
}
