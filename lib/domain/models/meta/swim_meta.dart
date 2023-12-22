import 'package:jimmys/core/extensions/map.dart';
import 'package:jimmys/domain/enums/exercise_categories.dart';
import 'package:jimmys/domain/models/base_model.dart';

class SwimMeta extends BaseMetaModel {
  SwimMeta({
    this.time,
    this.length,
  });

  static const lengthDefaultValue = 4;

  String? time; /// hh:mm
  int? length; /// 1-200 where 1 length = 50m

  @override
  SwimMeta fromMap(Map<String, dynamic> map) => SwimMeta(
    time: map.valueOrNull('time'),
    length: map.valueOrNull('length'),
  );

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> result = {};

    if (time != null) result['time'] = time;
    if (length != null) result['length'] = length;

    return result;
  }

  @override
  ExerciseCategories get exerciseCategory => ExerciseCategories.swim;
}