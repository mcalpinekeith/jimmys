import 'package:jimmys/core/extensions/map.dart';
import 'package:jimmys/domain/enums/exercise_categories.dart';
import 'package:jimmys/domain/models/base_model.dart';
import 'package:jimmys/domain/models/range.dart';

class CalisthenicsMeta extends BaseMetaModel {
  CalisthenicsMeta({
    this.time,
    this.weight,
  });

  static const weightAboveDefaultValue = 5.0;
  static const weightIncrement = 1.0;

  String? time; /// hh:mm
  Range? weight;

  @override
  CalisthenicsMeta fromMap(Map<String, dynamic> map) {
    final weight = map.valueOrNull('weight');

    return CalisthenicsMeta(
      time: map.valueOrNull('time'),
      weight: weight == null ? null : Range.fromMap(weight),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> result = {};

    if (time != null) result['time'] = time;
    if (weight != null) result['weight'] = weight!.toMap();

    return result;
  }

  @override
  ExerciseCategories get exerciseCategory => ExerciseCategories.calisthenics;
}