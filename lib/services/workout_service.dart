import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jimmys/models/workout.dart';
import 'package:jimmys/models/workout_exercise.dart';
import 'package:jimmys/services/data_service.dart';
import 'package:collection/collection.dart';

class WorkoutService extends ChangeNotifier {
  final db = DataService();
  late CollectionReference<Workout> _workoutsRef;

  WorkoutService() {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return;

    _workoutsRef = FirebaseFirestore.instance
      .collection('users')
      .doc(currentUser.uid)
      .collection('workouts')
      .withConverter<Workout>(
        fromFirestore: (snapshot, _) => Workout.fromMap(snapshot.data()!),
        toFirestore: (workout, _) => workout.toMap(),
      );
  }

  Future refresh() async {
    db.workouts.clear();
    db.todayWorkout = null;

    final snapshots = await _workoutsRef.get().then((snapshot) => snapshot.docs);

    for (final snapshot in snapshots) {
      db.workouts.add(snapshot.data());
    }

    db.workoutsLastSync = DateTime.now();
    db.todayWorkout = DataService().workouts.firstOrNull;

    notifyListeners();
  }

  Future remove(Workout data) async {
    await _workoutsRef.doc(data.id).delete();
    await refresh();
  }

  Future save(Workout data) async {
    await _workoutsRef.doc(data.id).set(data);
    await refresh();
  }

  Future<List<WorkoutExercise>> fetchExercises(String? workoutId) async {
    final results = <WorkoutExercise>[];

    final snapshots = await _workoutsRef
      .doc(workoutId)
      .collection('workout_exercise')
      .withConverter<WorkoutExercise>(
        fromFirestore: (snapshot, _) => WorkoutExercise.fromMap(snapshot.data()!),
        toFirestore: (workoutExercise, _) => workoutExercise.toMap(),
      )
      .get()
      .then((snapshot) => snapshot.docs);

    for (final snapshot in snapshots) {
      final d = snapshot.data();

      final exercise = db.exercises.singleWhereOrNull((_) => _.id == d.exerciseId);
      if (exercise == null) continue;

      final supersetExercise = db.exercises.singleWhereOrNull((_) => _.id == d.supersetExerciseId);

      d.exercise = exercise;
      d.supersetExercise = supersetExercise;

      results.add(d);
    }

    return results;
  }

  Future saveWorkoutExercise(WorkoutExercise data) async {
    await _workoutsRef
      .doc(data.workoutId)
      .collection('workout_exercise')
      .withConverter<WorkoutExercise>(
        fromFirestore: (snapshot, _) => WorkoutExercise.fromMap(snapshot.data()!),
        toFirestore: (workoutExercise, _) => workoutExercise.toMap(),
      )
      .doc(data.id)
      .set(data);
  }
}
