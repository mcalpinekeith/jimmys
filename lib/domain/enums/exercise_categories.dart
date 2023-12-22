enum ExerciseCategories {
  bike(5, 'Bike'),
  calisthenics(10, 'Calisthenics'),
  cardio(15, 'Cardio'),
  run(20, 'Run'),
  weight(25, 'Weight'),
  swim(30, 'Swim');

  final int i;
  final String title;

  const ExerciseCategories(this.i, this.title);

  factory ExerciseCategories.fromInt(int i) => values.firstWhere((_) => _.i == i, orElse: () => weight);
}