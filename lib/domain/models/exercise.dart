import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jimmys/core/extensions/map.dart';
import 'package:jimmys/domain/enums/exercise_categories.dart';
import 'package:jimmys/domain/enums/muscle_groups.dart';
import 'package:jimmys/domain/models/base_model.dart';
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
    this.category = categoryDefaultValue,
    List<MuscleGroups>? muscleGroups,
    this.isShared = false,
  }) :
    createdAt = createdAt ?? Timestamp.now(),
    muscleGroups = muscleGroups ?? [];

  static const categoryDefaultValue = ExerciseCategories.weight;

  @override
  String id = '';
  @override
  Timestamp createdAt = Timestamp.now();
  @override
  String get path => 'exercises';

  String name = '';
  ExerciseCategories category = categoryDefaultValue;
  List<MuscleGroups> muscleGroups = [];
  bool isShared = false;

  @override
  Exercise fromMap(Map<String, dynamic> map) => Exercise(
    id: map.value('id'),
    createdAt: map.value('created_at'),
    name: map.value('name'),
    category: ExerciseCategories.fromInt(map.value('category', defaultValue: categoryDefaultValue)),
    muscleGroups: _fromInts(map.value('muscle_groups', defaultValue: <MuscleGroups>[]) as Iterable),
  );

  @override
  Map<String, dynamic> toMap() => {
    'id': id,
    'created_at': createdAt,
    'name': name,
    'category': category.i,
    'muscle_groups': muscleGroups.isEmpty ? null : muscleGroups,
  };

  List<MuscleGroups> _fromInts(Iterable<dynamic> values) => values.map((_) => MuscleGroups.fromInt(_)).toList();
}