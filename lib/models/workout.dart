class Workout {
  Workout({
    required this.id,
    required this.name,
    this.category,
    this.icon,
    this.description,
  });

  String id = '';
  String name = '';
  String? category = '';
  String? icon = '';
  String? description = '';

  Workout.fromMap(Map<String, Object?> map) : this(
    id: map['id']! as String,
    name: map['name']! as String,
    category: !map.containsKey('category') || map['category'] == null
      ? null
      : map['category']! as String,
    icon: !map.containsKey('icon') || map['icon'] == null
      ? null
      : map['icon']! as String,
    description: !map.containsKey('description') || map['description'] == null
      ? null
      : map['description']! as String,
  );

  Map<String, Object?> toMap() {
    final Map<String, Object?> result = {
      'id': id,
      'name': name,
    };

    result['category'] = category;
    result['icon'] = icon;
    result['description'] = description;

    return result;
  }
}
