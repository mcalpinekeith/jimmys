import 'package:jimmys/core/global.dart';
import 'package:jimmys/data/interactors/exercise_interactor.dart';
import 'package:jimmys/data/interactors/workout_exercise_interactor.dart';
import 'package:jimmys/data/interactors/workout_interactor.dart';
import 'package:jimmys/data/modules/services/store_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jimmys/domain/use_cases/exercise_use_cases.dart';
import 'package:jimmys/domain/use_cases/workout_exercise_use_cases.dart';
import 'package:jimmys/domain/use_cases/workout_use_cases.dart';

void main() async {
  await Global.setUpTestMode();

  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  // data/modules

  test('StoreService get initialized', () {
    expect(getIt<StoreService>(), isA<StoreService>());
  });

  // domain/use_cases

  test('ExerciseUseCases get initialized with ExerciseInteractor', () {
    expect(getIt<ExerciseUseCases>(), isA<ExerciseInteractor>());
  });

  test('WorkoutExerciseUseCases get initialized with WorkoutExerciseInteractor', () {
    expect(getIt<WorkoutExerciseUseCases>(), isA<WorkoutExerciseInteractor>());
  });

  test('WorkoutUseCases get initialized with WorkoutInteractor', () {
    expect(getIt<WorkoutUseCases>(), isA<WorkoutInteractor>());
  });
}