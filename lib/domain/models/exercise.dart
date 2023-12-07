// Keep import of dynamic.dart - dynamic types use extensions at run-time
import 'package:jimmys/core/extensions/dynamic.dart';
import 'package:jimmys/core/extensions/map.dart';
import 'package:jimmys/domain/models/base_model.dart';

class Exercise implements BaseModel {
  Exercise.empty();

  Exercise({
    required this.id,
    required this.name,
    this.category = '',
    List<String>? exerciseTypes,
    this.stepIncrease = 1.0,
    this.isShared = false,
  }) : exerciseTypes = exerciseTypes ?? [];

  @override
  String id = '';
  @override
  String get path => 'exercises';
  String name = '';
  String? category;
  List<String> exerciseTypes = [];
  double stepIncrease = 1.0;
  bool isShared = false;

  @override
  Exercise fromMap(Map<String, dynamic> map) => Exercise(
    id: map.value('id', ''),
    name: map.value('name', ''),
    category: map.value('category', ''),
    exerciseTypes: map.value('exercise_types', []).toStringList(),
    stepIncrease: map.value('step_increase', 0.0),
  );

  @override
  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'category': category,
    'exercise_types': exerciseTypes,
    'step_increase': stepIncrease,
  };

  // TODO deprecated
  Exercise.fromMap(Map<String, dynamic> map) : this(
    id: map['id']! as String,
    name: map['name']! as String,
    category: !map.containsKey('category') || map['category'] == null
        ? ''
        : map['category']! as String,
    exerciseTypes: !map.containsKey('exercise_types')
        ? []
        : map['exercise_types']!.toStringList(),
    stepIncrease: map['step_increase']! as double,
  );
}