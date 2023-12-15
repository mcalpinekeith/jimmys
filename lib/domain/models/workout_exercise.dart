import 'package:jimmys/core/extensions/map.dart';
import 'package:jimmys/domain/models/base_model.dart';
import 'package:jimmys/domain/models/exercise.dart';
import 'package:jimmys/domain/models/workout.dart';
import 'package:uuid/uuid.dart';

class WorkoutExercise<T extends BaseMetaModel> implements BaseModel {
  WorkoutExercise.empty();

  WorkoutExercise.create() {
    id = const Uuid().v8();
  }

  WorkoutExercise({
    required this.id,
    DateTime? createdAt,
    required this.workoutId,
    required this.exerciseId,
    required this.sequence,
    required this.meta,
    this.workout,
    this.exercise,
    this.isShared = false,
  }) :
    createdAt = createdAt ?? DateTime.now();

  static const sequenceDefaultValue = 1;

  @override
  String id = '';
  @override
  DateTime createdAt = DateTime.now();
  @override
  String get path => 'workout_exercises';

  String workoutId = '';
  String exerciseId = '';
  int sequence = sequenceDefaultValue;
  late T? meta;

  late Workout? workout;
  late Exercise? exercise;
  bool isShared = false;

  @override
  WorkoutExercise fromMap(Map<String, dynamic> map) => WorkoutExercise(
    id: map.value('id'),
    createdAt: map.value('created_at'),
    workoutId: map.value('workout_id'),
    exerciseId: map.value('exercise_id'),
    sequence: map.value('sequence', defaultValue: sequenceDefaultValue),
    meta: (T as BaseMetaModel).fromMap(map.value('meta')),
  );

  @override
  Map<String, dynamic> toMap() => {
    'id': id,
    'created_at': createdAt,
    'workout_id': workoutId,
    'exercise_id': exerciseId,
    'sequence': sequence,
    'meta': (T as BaseMetaModel).toMap(),
  };
}
