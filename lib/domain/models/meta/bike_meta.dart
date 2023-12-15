import 'package:jimmys/core/extensions/map.dart';
import 'package:jimmys/domain/models/base_model.dart';
import 'package:jimmys/domain/models/range.dart';

class BikeMeta extends BaseMapModel {
  BikeMeta({
    this.time,
    this.distance,
    this.heartRate,
    this.power,
    this.speed,
    this.cadence,
  });

  static const distanceAboveDefaultValue = 1.0;
  static const distanceIncrement = 0.01;

  static const heartRateAboveDefaultValue = 150.0;
  static const heartRateIncrement = 1.0;

  static const powerBelowAboveDefaultValue = 250.0;
  static const powerIncrement = 1.0;

  static const speedAboveDefaultValue = 14.0;
  static const speedBelowDefaultValue = 16.0;
  static const speedIncrement = 0.1;

  static const cadenceAboveDefaultValue = 80.0;
  static const cadenceBelowDefaultValue = 90.0;
  static const cadenceIncrement = 1.0;

  String? time; /// hh:mm
  Range? distance; /// mi
  Range? heartRate; /// bpm
  Range? power; /// W
  Range? speed; /// mph
  Range? cadence; /// rpm

  @override
  BikeMeta fromMap(Map<String, dynamic> map) {
    final power = map.valueOrNull('power');
    final speed = map.valueOrNull('speed');
    final cadence = map.valueOrNull('cadence');

    return BikeMeta(
      time: map.valueOrNull('time'),
      distance: map.valueOrNull('distance'),
      heartRate: map.valueOrNull('heart_rate'),
      power: power == null ? null : Range.fromMap(power),
      speed: speed == null ? null : Range.fromMap(speed),
      cadence: cadence == null ? null : Range.fromMap(cadence),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> result = {};

    if (time != null) result['time'] = time;
    if (distance != null) result['distance'] = distance;
    if (heartRate != null) result['heartRate'] = heartRate?.toMap();
    if (power != null) result['power'] = power?.toMap();
    if (speed != null) result['speed'] = speed?.toMap();
    if (cadence != null) result['cadence'] = cadence?.toMap();

    return result;
  }
}