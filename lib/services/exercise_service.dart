import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jimmys/domain/models/exercise.dart';
import 'package:jimmys/services/data_service.dart';

class ExerciseService extends ChangeNotifier {
  final db = DataService();
  late CollectionReference<Exercise> _sharedExercisesRef;
  late CollectionReference<Exercise> _userExercisesRef;

  ExerciseService() {
    _sharedExercisesRef = FirebaseFirestore.instance
      .collection('shared_exercises')
      .withConverter<Exercise>(
        fromFirestore: (snapshot, _) => Exercise.fromMap(snapshot.data()!),
        toFirestore: (exercise, _) => exercise.toMap(),
      );

    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return;

    _userExercisesRef = FirebaseFirestore.instance
      .collection('users')
      .doc(currentUser.uid)
      .collection('exercises')
      .withConverter<Exercise>(
        fromFirestore: (snapshot, _) => Exercise.fromMap(snapshot.data()!),
        toFirestore: (exercise, _) => exercise.toMap(),
      );
  }

  Future refresh({bool doRefreshShared = false}) async {
    if (doRefreshShared) {
      db.exercises.clear();

      final snapshots = await _sharedExercisesRef.get().then((snapshot) => snapshot.docs);

      for (final snapshot in snapshots) {
        db.exercises.add(snapshot.data());
      }
    }
    else {
      db.exercises.removeWhere((_) => !_.isShared);
    }

    final snapshots = await _userExercisesRef.get().then((snapshot) => snapshot.docs);

    for (final snapshot in snapshots) {
      db.exercises.add(snapshot.data());
    }

    db.exercisesLastSync = DateTime.now();

    notifyListeners();
  }

  Future remove(Exercise data) async {
    if (data.isShared) return;
    await _userExercisesRef.doc(data.id).delete();
    await refresh();
  }

  Future save(Exercise data) async {
    if (data.isShared) return;
    await _userExercisesRef.doc(data.id).set(data);
    await refresh();
  }
}
