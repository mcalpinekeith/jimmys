class Exercise {
  Exercise({
    required this.id,
    required this.name,
    required this.category,
    required this.exerciseTypes,
  });

  String id = '';
  String name = '';
  String category = '';
  List<dynamic> exerciseTypes = <String>[];
  bool isShared = false;

  Exercise.fromMap(Map<String, Object?> map) : this(
    id: map['id']! as String,
    name: map['name']! as String,
    category: map['category'] == null ? 'Weights' : map['category']! as String,
    exerciseTypes: map['exercise_types']! as List<dynamic>,
  );

  Map<String, Object?> toMap() => {
    'id': id,
    'name': name,
    'category': category,
    'exercise_types': exerciseTypes,
  };
}
