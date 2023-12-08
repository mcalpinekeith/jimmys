import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jimmys/core/global.dart';
import 'package:jimmys/data/interactors/exercise_interactor.dart';
import 'package:jimmys/data/interactors/workout_exercise_interactor.dart';
import 'package:jimmys/data/interactors/workout_interactor.dart';
import 'package:jimmys/data/modules/services/store_service.dart';
import 'package:jimmys/data/modules/services/user_service.dart';
import 'package:jimmys/domain/use_cases/exercise_use_cases.dart';
import 'package:jimmys/domain/use_cases/workout_exercise_use_cases.dart';
import 'package:jimmys/domain/use_cases/workout_use_cases.dart';
import 'package:jimmys/ui/screens/sign_in/sign_in_contract.dart';
import 'package:jimmys/ui/screens/sign_in/sign_in_view_model.dart';
import 'package:jimmys/ui/screens/startup/startup_contract.dart';
import 'package:jimmys/ui/screens/startup/startup_view_model.dart';
import 'package:jimmys/utilities/icon_service.dart';
import 'package:jimmys/utilities/test/mock_firestore.dart';

Future initializeApp() async {
  if (Global.isAppInitialized) return;

  /// Initialize modules

  getIt.registerSingleton<UserService>(UserService());
  getIt.registerSingleton<StoreService>(StoreService(store: (Global.isTest ? await MockFirestore.getStore() : FirebaseFirestore.instance)));

  /// Initialise interactors

  getIt.registerFactory<ExerciseUseCases>(() => ExerciseInteractor(store: getIt<StoreService>()));
  getIt.registerFactory<WorkoutExerciseUseCases>(() => WorkoutExerciseInteractor(store: getIt<StoreService>()));
  getIt.registerFactory<WorkoutUseCases>(() => WorkoutInteractor(store: getIt<StoreService>()));

  /// Initialize screens

  getIt.registerSingleton<IconService>(IconService());

  /// SignIn
  getIt.registerFactory<SignInVMContract>(() => SignInViewModel());
  getIt.registerFactory<SignInVMState>(() => SignInVMState());

  /// Startup
  getIt.registerFactory<StartupVMContract>(() => StartupViewModel(workoutInteractor: getIt<WorkoutUseCases>()));
  getIt.registerFactory<StartupVMState>(() => StartupVMState());

  /// WorkoutList
/*  getIt.registerFactory<WorkoutListVMContract>(() => WorkoutListViewModel(workoutInteractor: getIt<WorkoutUseCases>()));
  getIt.registerFactory<WorkoutListVMState>(() => WorkoutListVMState());

  /// WorkoutEdit
  getIt.registerFactory<WorkoutEditVMContract>(() => WorkoutEditViewModel());
  getIt.registerFactory<WorkoutEditVMState>(() => WorkoutEditVMState());*/

  Global.isAppInitialized = true;
}