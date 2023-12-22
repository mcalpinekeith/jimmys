import 'package:jimmys/core/global.dart';
import 'package:jimmys/data/modules/services/store_service.dart';
import 'package:jimmys/domain/enums/exercise_categories.dart';
import 'package:jimmys/domain/models/meta/strength_meta.dart';
import 'package:jimmys/domain/models/workout_exercise.dart';
import 'package:jimmys/domain/use_cases/exercise_use_cases.dart';
import 'package:jimmys/domain/use_cases/workout_exercise_use_cases.dart';
import 'package:jimmys/domain/use_cases/workout_use_cases.dart';

class WorkoutExerciseInteractor implements WorkoutExerciseUseCases {
  final StoreService store;

  @override
  DateTime? lastSave;

  WorkoutExerciseInteractor({required this.store});

  @override
  Future<List<WorkoutExercise>> get({(String, String)? criteria}) async {
    /// TODO: fix shared exercise schema: final sharedWorkoutExercises = await store.sharedWhere<WorkoutExercise>(WorkoutExercise.empty(), criteria: criteria);
    final workoutExercises = await store.where<WorkoutExercise>(WorkoutExercise.empty(), criteria: criteria);
    final workoutInteractor = getIt<WorkoutUseCases>();
    final exerciseInteractor = getIt<ExerciseUseCases>();

    for (final workoutExercise in workoutExercises) {

      final workouts = await workoutInteractor.get(criteria: ('id', workoutExercise.workoutId));
      if (workouts.isNotEmpty) {
        workoutExercise.workout = workouts.first;
      }

      final exercises = await exerciseInteractor.get(criteria: ('id', workoutExercise.exerciseId));
      if (exercises.isNotEmpty) {
        workoutExercise.exercise = exercises.first;

        if (workoutExercise.exercise!.category == ExerciseCategories.strength) {
          final strength = workoutExercise.meta as StrengthMeta;
          if (strength.supersetExerciseId != null) {
            final supersetExercises = await exerciseInteractor.get(criteria: ('id', strength.supersetExerciseId!));
            if (supersetExercises.isNotEmpty) {
              strength.supersetExercise = supersetExercises.first;
            }
          }
        }
      }
    }

    return workoutExercises;
  }

  @override
  void remove(WorkoutExercise data) {
    if (data.isShared) return;
    store.delete(data);
  }

  @override
  void save(WorkoutExercise data) {
    if (data.isShared) return;
    store.set(data);
    lastSave = DateTime.now();
  }
}