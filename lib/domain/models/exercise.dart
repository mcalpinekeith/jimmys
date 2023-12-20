import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jimmys/core/extensions/iterable.dart';
import 'package:jimmys/core/extensions/map.dart';
import 'package:jimmys/domain/enums/exercise_categories.dart';
import 'package:jimmys/domain/models/base_model.dart';
import 'package:jimmys/domain/models/range.dart';
import 'package:uuid/uuid.dart';

class Exercise implements BaseModel {
  Exercise.empty();

  Exercise.create() {
    id = const Uuid().v8();
  }

  Exercise({
    required this.id,
    Timestamp? createdAt,
    required this.name,
    required this.category,
    List<String>? muscleGroups,
    this.weight,
    this.isShared = false,
  }) :
    createdAt = createdAt ?? Timestamp.now(),
    muscleGroups = muscleGroups ?? [];

  static const categoryDefaultValue = ExerciseCategories.strength;
  static const weightIncrement = 1.0;

  @override
  String id = '';
  @override
  Timestamp createdAt = Timestamp.now();
  @override
  String get path => 'exercises';

  String name = '';
  ExerciseCategories category = categoryDefaultValue;
  List<String> muscleGroups = [];
  bool isShared = false;
  Range? weight;

  @override
  Exercise fromMap(Map<String, dynamic> map) {
    final weight = map.valueOrNull('weight');

    return Exercise(
      id: map.value('id'),
      createdAt: map.value('created_at'),
      name: map.value('name'),
      category: ExerciseCategories.fromInt(map.value('category', defaultValue: categoryDefaultValue)),
      muscleGroups: (map.value('muscle_groups', defaultValue: <String>[]) as Iterable).toDistinct(),
      weight: weight == null ? null : Range.fromMap(weight),
    );
  }

  @override
  Map<String, dynamic> toMap() => {
    'id': id,
    'created_at': createdAt,
    'name': name,
    'category': category.i,
    'muscle_groups': muscleGroups.isEmpty ? null : muscleGroups,
    'weight': weight?.toMap(),
  };
}