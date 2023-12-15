import 'package:jimmys/core/extensions/map.dart';
import 'package:jimmys/domain/enums/exercise_categories.dart';
import 'package:jimmys/domain/models/base_model.dart';
import 'package:jimmys/domain/models/range.dart';

class HiitMeta extends BaseMetaModel {
  HiitMeta({
    this.time,
    this.heartRate,
    this.cadence,
    this.reps,
  });

  static const heartRateAboveDefaultValue = 150.0;
  static const heartRateIncrement = 1.0;

  static const cadenceAboveDefaultValue = 175.0;
  static const cadenceBelowDefaultValue = 185.0;
  static const cadenceIncrement = 1.0;

  static const repsDefaultValue = 10;

  String? time; /// hh:mm
  Range? heartRate; /// bpm
  Range? cadence; /// spm
  int? reps;

  @override
  HiitMeta fromMap(Map<String, dynamic> map) {
    final heartRate = map.valueOrNull('heart_rate');
    final cadence = map.valueOrNull('cadence');

    return HiitMeta(
      time: map.valueOrNull('time'),
      heartRate: heartRate == null ? null : Range.fromMap(heartRate),
      cadence: cadence == null ? null : Range.fromMap(cadence),
      reps: map.valueOrNull('reps'),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> result = {};

    if (time != null) result['time'] = time;
    if (heartRate != null) result['heart_rate'] = heartRate?.toMap();
    if (cadence != null) result['cadence'] = cadence?.toMap();
    if (reps != null) result['reps'] = reps;

    return result;
  }

  @override
  ExerciseCategories get exerciseCategory => ExerciseCategories.hiit;
}