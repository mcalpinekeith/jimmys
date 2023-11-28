import 'package:jimmys/models/exercise.dart';
import 'package:jimmys/models/workout.dart';

class DataService {
  static final DataService _instance = DataService._internal();

  // Workout
  final workouts = <Workout>[];
  late DateTime workoutsLastSync;
  //late Workout? todayWorkout;

  // Exercise
  final exercises = <Exercise>[];
  late DateTime exercisesLastSync;

  // The factory is promises to return an object of this type; it doesn't promise to make a new one.
  factory DataService() {
    return _instance;
  }

  // The "real" constructor called exactly once, by the static property assignment above it's also private, so it can only be called in this class.
  DataService._internal();
}
