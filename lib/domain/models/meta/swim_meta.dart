import 'package:jimmys/core/extensions/map.dart';
import 'package:jimmys/domain/enums/exercise_swim_strokes.dart';
import 'package:jimmys/domain/models/base_model.dart';

class SwimMeta extends BaseMapModel {
  SwimMeta({
    this.time,
    this.length,
    this.stroke,
  });

  static const lengthDefaultValue = 4;
  static const strokeDefaultValue = ExerciseSwimStrokes.any;

  String? time; /// hh:mm
  int? length; /// 1-200 where 1 length = 50m
  ExerciseSwimStrokes? stroke;

  @override
  SwimMeta fromMap(Map<String, dynamic> map) => SwimMeta(
    time: map.valueOrNull('time'),
    length: map.valueOrNull('length'),
    stroke: map.valueOrNull('stroke'),
  );

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> result = {};

    if (time != null) result['time'] = time;
    if (length != null) result['length'] = length;
    if (stroke != null) result['stroke'] = stroke?.i;

    return result;
  }
}