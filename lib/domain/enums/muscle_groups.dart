import 'package:jimmys/domain/enums/base_enum.dart';

enum MuscleGroups implements BaseEnum {
  traps(5, 'traps'),
  delts(10, 'delts'),
  backDelts(15, 'back delts'),
  frontDelts(20, 'front delts'),
  pecs(25, 'pecs'),
  lowerPecs(30, 'lower pecs'),
  biceps(35, 'biceps'),
  triceps(40, 'triceps'),
  forearms(45, 'forearms'),
  back(50, 'back'),
  lats(55, 'lats'),
  abs(60, 'abs'),
  lowerAbs(65, 'lower abs'),
  glutes(70, 'glutes'),
  quads(75, 'quads'),
  hamstrings(80, 'hamstrings'),
  calves(85, 'calves');

  final int i;
  final String title;

  @override
  String getTitle(int i) => MuscleGroups.fromInt(i).title;

  const MuscleGroups(this.i, this.title);

  factory MuscleGroups.fromInt(int i) => values.firstWhere((_) => _.i == i, orElse: () => pecs);
}