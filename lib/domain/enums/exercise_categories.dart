enum ExerciseCategories {
  bike(10, 'Bike'),
  calisthenics(20, 'Calisthenics'),
  cardio(30, 'Cardio'),
  hiit(40, 'HIIT'),
  run(50, 'Run'),
  strength(60, 'Strength'),
  swim(70, 'Swim');

  final int i;
  final String title;

  const ExerciseCategories(this.i, this.title);

  factory ExerciseCategories.fromInt(int i) => values.firstWhere((_) => _.i == i, orElse: () => strength);
}