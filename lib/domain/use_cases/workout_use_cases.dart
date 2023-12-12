import 'package:jimmys/domain/models/workout.dart';
import 'package:jimmys/domain/use_cases/base_use_cases.dart';

abstract class WorkoutUseCases extends BaseUseCases<Workout> {
  Future<Workout?> getTodayWorkout();

  Future<List<String>> getCategories();
}