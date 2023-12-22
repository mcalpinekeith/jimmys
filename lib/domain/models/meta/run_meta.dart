import 'package:jimmys/core/extensions/map.dart';
import 'package:jimmys/domain/enums/exercise_categories.dart';
import 'package:jimmys/domain/models/base_model.dart';
import 'package:jimmys/domain/models/range.dart';

class RunMeta extends BaseMetaModel {
  RunMeta({
    this.time,
    this.distance,
    this.heartRate,
    this.pace,
    this.cadence,
    this.reps,
  });

  static const distanceAboveDefaultValue = 1.0;
  static const distanceIncrement = 0.01;

  static const heartRateAboveDefaultValue = 150.0;
  static const heartRateIncrement = 1.0;

  static const paceAboveDefaultValue = 8.5;
  static const paceBelowDefaultValue = 9.5;
  static const paceIncrement = 1.0;

  static const cadenceAboveDefaultValue = 175.0;
  static const cadenceBelowDefaultValue = 185.0;
  static const cadenceIncrement = 1.0;

  static const repsDefaultValue = 1;

  String? time; /// hh:mm
  Range? distance; /// mi
  Range? heartRate; /// bpm
  Range? pace; /// min/mi
  Range? cadence; /// spm
  int? reps;

  @override
  RunMeta fromMap(Map<String, dynamic> map) {
    final distance = map.valueOrNull('distance');
    final heartRate = map.valueOrNull('heart_rate');
    final pace = map.valueOrNull('pace');
    final cadence = map.valueOrNull('cadence');

    return RunMeta(
      time: map.valueOrNull('time'),
      distance: distance == null ? null : Range.fromMap(distance),
      heartRate: heartRate == null ? null : Range.fromMap(heartRate),
      pace: pace == null ? null : Range.fromMap(pace),
      cadence: cadence == null ? null : Range.fromMap(cadence),
      reps: map.valueOrNull('reps'),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> result = {};

    if (time != null) result['time'] = time;
    if (distance != null) result['distance'] = distance!.toMap();
    if (heartRate != null) result['heart_rate'] = heartRate!.toMap();
    if (pace != null) result['pace'] = pace!.toMap();
    if (cadence != null) result['cadence'] = cadence!.toMap();
    if (reps != null) result['reps'] = reps;

    return result;
  }

  @override
  ExerciseCategories get exerciseCategory => ExerciseCategories.run;
}