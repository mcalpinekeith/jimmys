import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:english_words/english_words.dart';
import 'package:jimmys/core/extensions/map.dart';
import 'package:jimmys/domain/models/base_model.dart';
import 'package:uuid/uuid.dart';

class Workout implements BaseModel {
  Workout.empty();

  Workout.create() {
    id = const Uuid().v8();
    name = '${generateWordPairs().first.join()} workout';
  }

  Workout({
    required this.id,
    Timestamp? createdAt,
    required this.name,
    this.category = '',
    this.icon = '',
    this.description = '',
    this.isShared = false,
  }) :
    createdAt = createdAt ?? Timestamp.now();

  @override
  String id = '';
  @override
  Timestamp createdAt = Timestamp.now();
  @override
  String get path => 'workouts';

  String name = '';
  String? category;
  String? icon;
  String? description;
  bool isShared = false;

  @override
  Workout fromMap(Map<String, dynamic> map) {
    return Workout(
      id: map.value('id'),
      createdAt: map.value('created_at'),
      name: map.value('name'),
      category: map.value('category'),
      icon: map.value('icon'),
      description: map.value('description'),
    );
  }

  @override
  Map<String, dynamic> toMap() => {
    'id': id,
    'created_at': createdAt,
    'name': name,
    'category': category,
    'icon': icon,
    'description': description,
  };
}
