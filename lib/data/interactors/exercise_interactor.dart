import 'package:jimmys/data/modules/services/store_service.dart';
import 'package:jimmys/domain/enums/exercise_categories.dart';
import 'package:jimmys/domain/models/exercise.dart';
import 'package:jimmys/domain/use_cases/exercise_use_cases.dart';

class ExerciseInteractor implements ExerciseUseCases {
  final StoreService store;

  @override
  DateTime? lastSave;

  ExerciseInteractor({required this.store});

  @override
  Future<List<Exercise>> get({(String, String)? criteria}) async {
    /// TODO: fix shared exercise schema: final sharedExercises = await store.sharedWhere<Exercise>(Exercise.empty(), criteria: criteria);
    final exercises = await store.where<Exercise>(Exercise.empty(), criteria: criteria);

    /// sharedExercises.addAll(exercises);

    return exercises;
  }

  @override
  void remove(Exercise data) {
    if (data.isShared) return;
    store.delete(data);
  }

  @override
  void save(Exercise data) {
    if (data.isShared) return;
    store.set(data);
    lastSave = DateTime.now();
  }
}