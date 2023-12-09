import 'package:flutter/foundation.dart';
import 'package:jimmys/domain/models/workout.dart';

class WorkoutListProvider extends ChangeNotifier {
  late final List<Workout> list;

  /// This constructor allow to initialize the provider with a specific list during tests
  WorkoutListProvider({List<Workout>? list}) {
    this.list = list ?? List.empty(growable: true);
  }
}