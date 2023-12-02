import 'package:flutter_test/flutter_test.dart';
import 'package:jimmys/core/global.dart';
import 'package:jimmys/domain/models/exercise.dart';
import 'package:jimmys/domain/use_cases/exercise_use_cases.dart';
import 'package:jimmys/utilities/test/mock_firestore.dart';

void main() async {
  await Global.setUpTestMode();

  final exerciseInteractor = getIt<ExerciseUseCases>();

  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();

    await MockFirestore.clear(Exercise.empty());

    exerciseInteractor.lastSave = null;
  });

  test('Save (isShared: true)', () async {
    expect(exerciseInteractor.lastSave, isNull);

    exerciseInteractor.save(Exercise(
      id: 'id',
      name: 'Pushups',
      category: 'Weights',
      exerciseTypes: ['pecs'],
      stepIncrease: 5.0,
      isShared: true,
    ));

    expect(exerciseInteractor.lastSave, isNull);

    final result = await exerciseInteractor.get();

    expect(result.length, 0);
  });

  test('Save (isShared: false)', () async {
    expect(exerciseInteractor.lastSave, isNull);

    exerciseInteractor.save(Exercise(
      id: 'id',
      name: 'Pushups',
      category: 'Weights',
      exerciseTypes: ['pecs'],
      stepIncrease: 5.0,
      isShared: false,
    ));

    expect(exerciseInteractor.lastSave, isNotNull);

    final result = await exerciseInteractor.get();

    expect(result.length, 1);
  });

  test('Get where name=Pushups (isShared: false)', () async {
    expect(exerciseInteractor.lastSave, isNull);

    exerciseInteractor.save(Exercise(
      id: 'id',
      name: 'Pushups',
      category: 'Weights',
      exerciseTypes: ['pecs'],
      stepIncrease: 5.0,
      isShared: false,
    ));

    expect(exerciseInteractor.lastSave, isNotNull);

    final result = await exerciseInteractor.get(criteria: ('name', 'Pushups'));

    expect(result.length, 1);
  });

  test('Get where name=Fail (isShared: false)', () async {
    expect(exerciseInteractor.lastSave, isNull);

    exerciseInteractor.save(Exercise(
      id: 'id',
      name: 'Pushups',
      category: 'Weights',
      exerciseTypes: ['pecs'],
      stepIncrease: 5.0,
      isShared: false,
    ));

    expect(exerciseInteractor.lastSave, isNotNull);

    final result = await exerciseInteractor.get(criteria: ('name', 'Fail'));

    expect(result.length, 0);
  });

  test('Remove (isShared: true)', () async {
    expect(exerciseInteractor.lastSave, isNull);

    final data = Exercise(
      id: 'id',
      name: 'Pushups',
      category: 'Weights',
      exerciseTypes: ['pecs'],
      stepIncrease: 5.0,
      isShared: true,
    );

    exerciseInteractor.save(data);

    expect(exerciseInteractor.lastSave, isNull);

    final resultAfterSave = await exerciseInteractor.get();

    expect(resultAfterSave.length, 0);

    exerciseInteractor.remove(data);

    final resultAfterRemove = await exerciseInteractor.get();

    expect(resultAfterRemove.length, 0);
  });

  test('Remove (isShared: false)', () async {
    expect(exerciseInteractor.lastSave, isNull);

    final data = Exercise(
      id: 'id',
      name: 'Pushups',
      category: 'Weights',
      exerciseTypes: ['pecs'],
      stepIncrease: 5.0,
      isShared: false,
    );

    exerciseInteractor.save(data);

    expect(exerciseInteractor.lastSave, isNotNull);

    final resultAfterSave = await exerciseInteractor.get();

    expect(resultAfterSave.length, 1);

    exerciseInteractor.remove(data);

    final resultAfterRemove = await exerciseInteractor.get();

    expect(resultAfterRemove.length, 0);
  });
}