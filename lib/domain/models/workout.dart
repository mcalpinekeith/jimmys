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
    id: map['id']! as String,
    name: map['name']! as String,
    category: !map.containsKey('category') || map['category'] == null
      ? ''
      : map['category']! as String,
    icon: !map.containsKey('icon') || map['icon'] == null
      ? ''
      : map['icon']! as String,
    description: !map.containsKey('description') || map['description'] == null
      ? ''
      : map['description']! as String,
  );

  @override
  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'category': category,
    'icon': icon,
    'description': description,
  };

  // TODO deprecated
  Workout.fromMap(Map<String, Object?> map) : this(
    id: map['id']! as String,
    name: map['name']! as String,
    category: !map.containsKey('category') || map['category'] == null
        ? ''
        : map['category']! as String,
    icon: !map.containsKey('icon') || map['icon'] == null
        ? ''
        : map['icon']! as String,
    description: !map.containsKey('description') || map['description'] == null
        ? ''
        : map['description']! as String,
  );
}
