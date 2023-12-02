import 'package:flutter_test/flutter_test.dart';
import 'package:jimmys/core/global.dart';
import 'package:jimmys/domain/models/exercise.dart';
import 'package:jimmys/domain/models/workout_exercise.dart';
import 'package:jimmys/domain/use_cases/exercise_use_cases.dart';
import 'package:jimmys/domain/use_cases/workout_exercise_use_cases.dart';
import 'package:jimmys/utilities/test/mock_firestore.dart';

void main() async {
  await Global.setUpTestMode();

  final exerciseInteractor = getIt<ExerciseUseCases>();
  final workoutExerciseInteractor = getIt<WorkoutExerciseUseCases>();

  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();

    await MockFirestore.clear(WorkoutExercise.empty());

    workoutExerciseInteractor.lastSave = null;
  });

  test('Save (isShared: true)', () async {
    expect(workoutExerciseInteractor.lastSave, isNull);

    workoutExerciseInteractor.save(WorkoutExercise(
      id: 'id',
      workoutId: 'workout_id',
      exerciseId: 'exercise_id',
      isDropSet: false,
      sequence: 1,
      sets: ['5', '8', '12'],
      supersetExerciseId: null,
      isShared: true,
    ));

    expect(workoutExerciseInteractor.lastSave, isNull);

    final result = await workoutExerciseInteractor.get();

    expect(result.length, 0);
  });

  test('Save (isShared: false)', () async {
    exerciseInteractor.save(Exercise(
      id: 'exercise_id1',
      name: 'Pushups1',
      category: 'Weights',
      exerciseTypes: ['pecs'],
      stepIncrease: 5.0,
      isShared: false,
    ));

    exerciseInteractor.save(Exercise(
      id: 'exercise_id2',
      name: 'Pushups2',
      category: 'Weights',
      exerciseTypes: ['pecs'],
      stepIncrease: 5.0,
      isShared: false,
    ));

    expect(workoutExerciseInteractor.lastSave, isNull);

    workoutExerciseInteractor.save(WorkoutExercise(
      id: 'id',
      workoutId: 'workout_id',
      exerciseId: 'exercise_id1',
      isDropSet: false,
      sequence: 1,
      sets: ['5', '8', '12'],
      supersetExerciseId: 'exercise_id2',
      isShared: false,
    ));

    expect(workoutExerciseInteractor.lastSave, isNotNull);

    final result = await workoutExerciseInteractor.get();

    expect(result.length, 1);
    expect(result.first.exercise, isNotNull);
    expect(result.first.exercise!.name, 'Pushups1');

    expect(result.first.supersetExercise, isNotNull);
    expect(result.first.supersetExercise!.name, 'Pushups2');
  });

  test('Get where workoutId=workout_id (isShared: false)', () async {
    expect(workoutExerciseInteractor.lastSave, isNull);

    workoutExerciseInteractor.save(WorkoutExercise(
      id: 'id',
      workoutId: 'workout_id',
      exerciseId: 'exercise_id',
      isDropSet: false,
      sequence: 1,
      sets: ['5', '8', '12'],
      supersetExerciseId: null,
      isShared: false,
    ));

    expect(workoutExerciseInteractor.lastSave, isNotNull);

    final result = await workoutExerciseInteractor.get(criteria: ('workout_id', 'workout_id'));

    expect(result.length, 1);
  });

  test('Get where workoutId=Fail (isShared: false)', () async {
    expect(workoutExerciseInteractor.lastSave, isNull);

    workoutExerciseInteractor.save(WorkoutExercise(
      id: 'id',
      workoutId: 'workout_id',
      exerciseId: 'exercise_id',
      isDropSet: false,
      sequence: 1,
      sets: ['5', '8', '12'],
      supersetExerciseId: null,
      isShared: false,
    ));

    expect(workoutExerciseInteractor.lastSave, isNotNull);

    final result = await workoutExerciseInteractor.get(criteria: ('workout_id', 'Fail'));

    expect(result.length, 0);
  });

  test('Remove (isShared: true)', () async {
    expect(workoutExerciseInteractor.lastSave, isNull);

    final data = WorkoutExercise(
      id: 'id',
      workoutId: 'workout_id',
      exerciseId: 'exercise_id',
      isDropSet: false,
      sequence: 1,
      sets: ['5', '8', '12'],
      supersetExerciseId: null,
      isShared: true,
    );

    workoutExerciseInteractor.save(data);

    expect(workoutExerciseInteractor.lastSave, isNull);

    final resultAfterSave = await workoutExerciseInteractor.get();

    expect(resultAfterSave.length, 0);

    workoutExerciseInteractor.remove(data);

    final resultAfterRemove = await workoutExerciseInteractor.get();

    expect(resultAfterRemove.length, 0);
  });

  test('Remove (isShared: false)', () async {
    expect(workoutExerciseInteractor.lastSave, isNull);

    final data = WorkoutExercise(
      id: 'id',
      workoutId: 'workout_id',
      exerciseId: 'exercise_id',
      isDropSet: false,
      sequence: 1,
      sets: ['5', '8', '12'],
      supersetExerciseId: null,
      isShared: false,
    );

    workoutExerciseInteractor.save(data);

    expect(workoutExerciseInteractor.lastSave, isNotNull);

    final resultAfterSave = await workoutExerciseInteractor.get();

    expect(resultAfterSave.length, 1);

    workoutExerciseInteractor.remove(data);

    final resultAfterRemove = await workoutExerciseInteractor.get();

    expect(resultAfterRemove.length, 0);
  });
}