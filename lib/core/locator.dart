import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jimmys/core/global.dart';
import 'package:jimmys/data/modules/api/api_service.dart';
import 'package:jimmys/data/interactors/exercise_interactor.dart';
import 'package:jimmys/data/interactors/workout_exercise_interactor.dart';
import 'package:jimmys/data/interactors/workout_interactor.dart';
import 'package:jimmys/data/modules/services/store_service.dart';
import 'package:jimmys/data/modules/services/user_service.dart';
import 'package:jimmys/domain/use_cases/exercise_use_cases.dart';
import 'package:jimmys/domain/use_cases/workout_exercise_use_cases.dart';
import 'package:jimmys/domain/use_cases/workout_use_cases.dart';
import 'package:jimmys/utilities/test/mock_firestore.dart';

Future initializeApp() async {
  if (Global.isAppInitialized) return;

  // Initialize modules

  getIt.registerSingleton<UserService>(UserService(),); // Keep UserService first
  getIt.registerSingleton<ApiService>(ApiService(),);
  getIt.registerSingleton<StoreService>(StoreService(store: (Global.isTest ? await MockFirestore.getStore() : FirebaseFirestore.instance),),);

  // Initialise interactors

  getIt.registerFactory<ExerciseUseCases>(() => ExerciseInteractor(store: getIt<StoreService>()),);
  getIt.registerFactory<WorkoutExerciseUseCases>(() => WorkoutExerciseInteractor(store: getIt<StoreService>()),);
  getIt.registerFactory<WorkoutUseCases>(() => WorkoutInteractor(store: getIt<StoreService>()),);

  Global.isAppInitialized = true;
}