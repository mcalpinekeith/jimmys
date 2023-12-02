import 'package:jimmys/data/modules/services/store_service.dart';
import 'package:jimmys/domain/models/workout.dart';
import 'package:jimmys/domain/use_cases/workout_use_cases.dart';

class WorkoutInteractor implements WorkoutUseCases {
  final StoreService store;

  @override
  DateTime? lastSave;
  @override
  Workout? todayWorkout;

  WorkoutInteractor({required this.store});

  @override
  Future<List<Workout>> get({(String, String)? criteria}) async {
    //final sharedWorkouts = await store.sharedWhere<Workouts>(Workouts.empty(), criteria: criteria);
    final workouts = await store.where<Workout>(Workout.empty(), criteria: criteria);

    return workouts;
  }

  @override
  void remove(Workout data) async {
    if (data.isShared) return;
    store.delete(data);
  }

  @override
  void save(Workout data) async {
    if (data.isShared) return;
    store.set(data);
    lastSave = DateTime.now();
  }
}