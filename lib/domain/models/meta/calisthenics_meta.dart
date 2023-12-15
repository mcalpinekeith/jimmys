import 'package:jimmys/core/extensions/map.dart';
import 'package:jimmys/domain/enums/exercise_categories.dart';
import 'package:jimmys/domain/models/base_model.dart';

class CalisthenicsMeta extends BaseMetaModel {
  CalisthenicsMeta({
    this.time,
  });

  String? time; /// hh:mm

  @override
  CalisthenicsMeta fromMap(Map<String, dynamic> map) => CalisthenicsMeta(
    time: map.valueOrNull('time'),
  );

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> result = {};

    if (time != null) result['time'] = time;

    return result;
  }

  @override
  ExerciseCategories get exerciseCategory => ExerciseCategories.calisthenics;
}