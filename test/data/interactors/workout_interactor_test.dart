import 'package:flutter_test/flutter_test.dart';
import 'package:jimmys/core/global.dart';
import 'package:jimmys/domain/models/exercise.dart';
import 'package:jimmys/domain/models/workout.dart';
import 'package:jimmys/domain/use_cases/exercise_use_cases.dart';
import 'package:jimmys/domain/use_cases/workout_use_cases.dart';
import 'package:jimmys/utilities/test/mock_firestore.dart';

void main() async {
  await Global.setUpTestMode();

  final workoutInteractor = getIt<WorkoutUseCases>();

  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();

    await MockFirestore.clear(Workout.empty());

    workoutInteractor.lastSave = null;
  });

  test('Save (isShared: true)', () async {
    expect(workoutInteractor.lastSave, isNull);

    workoutInteractor.save(Workout(
      id: 'id',
      name: 'Super',
      category: 'Strength',
      icon: 'f005',
      description: 'This workout is going to make me super strong.',
      isShared: true,
    ));

    expect(workoutInteractor.lastSave, isNull);

    final result = await workoutInteractor.get();

    expect(result.length, 0);
  });

  test('Save (isShared: false)', () async {
    expect(workoutInteractor.lastSave, isNull);

    workoutInteractor.save(Workout(
      id: 'id',
      name: 'Super',
      category: 'Strength',
      icon: 'f005',
      description: 'This workout is going to make me super strong.',
      isShared: false,
    ));

    expect(workoutInteractor.lastSave, isNotNull);

    final result = await workoutInteractor.get();

    expect(result.length, 1);
  });

  test('Get where name=Super (isShared: false)', () async {
    expect(workoutInteractor.lastSave, isNull);

    workoutInteractor.save(Workout(
      id: 'id',
      name: 'Super',
      category: 'Strength',
      icon: 'f005',
      description: 'This workout is going to make me super strong.',
      isShared: false,
    ));

    expect(workoutInteractor.lastSave, isNotNull);

    final result = await workoutInteractor.get(criteria: ('name', 'Super'));

    expect(result.length, 1);
  });

  test('Get where name=Fail (isShared: false)', () async {
    expect(workoutInteractor.lastSave, isNull);

    workoutInteractor.save(Workout(
      id: 'id',
      name: 'Super',
      category: 'Strength',
      icon: 'f005',
      description: 'This workout is going to make me super strong.',
      isShared: false,
    ));

    expect(workoutInteractor.lastSave, isNotNull);

    final result = await workoutInteractor.get(criteria: ('name', 'Fail'));

    expect(result.length, 0);
  });

  test('Remove (isShared: true)', () async {
    expect(workoutInteractor.lastSave, isNull);

    final data = Workout(
      id: 'id',
      name: 'Super',
      category: 'Strength',
      icon: 'f005',
      description: 'This workout is going to make me super strong.',
      isShared: true,
    );

    workoutInteractor.save(data);

    expect(workoutInteractor.lastSave, isNull);

    final resultAfterSave = await workoutInteractor.get();

    expect(resultAfterSave.length, 0);

    workoutInteractor.remove(data);

    final resultAfterRemove = await workoutInteractor.get();

    expect(resultAfterRemove.length, 0);
  });

  test('Remove (isShared: false)', () async {
    expect(workoutInteractor.lastSave, isNull);

    final data = Workout(
      id: 'id',
      name: 'Super',
      category: 'Strength',
      icon: 'f005',
      description: 'This workout is going to make me super strong.',
      isShared: false,
    );

    workoutInteractor.save(data);

    expect(workoutInteractor.lastSave, isNotNull);

    final resultAfterSave = await workoutInteractor.get();

    expect(resultAfterSave.length, 1);

    workoutInteractor.remove(data);

    final resultAfterRemove = await workoutInteractor.get();

    expect(resultAfterRemove.length, 0);
  });
}