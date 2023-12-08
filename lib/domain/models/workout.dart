import 'package:jimmys/core/extensions/map.dart';
import 'package:jimmys/domain/models/base_model.dart';

class Workout implements BaseModel {
  Workout.empty();

  Workout({
    required this.id,
    required this.name,
    this.category = '',
    this.icon = '',
    this.description = '',
    this.isShared = false,
  });

  @override
  String id = '';
  @override
  String get path => 'workouts';
  String name = '';
  String? category;
  String? icon;
  String? description;
  bool isShared = false;

  @override
  Workout fromMap(Map<String, dynamic> map) => Workout(
    id: map.value('id', ''),
    name: map.value('name', ''),
    category: map.value('category', ''),
    icon: map.value('icon', ''),
    description: map.value('description', ''),
  );

  @override
  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'category': category,
    'icon': icon,
    'description': description,
  };
}