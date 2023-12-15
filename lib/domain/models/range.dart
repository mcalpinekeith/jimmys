import 'package:jimmys/core/extensions/map.dart';
import 'package:jimmys/domain/models/base_model.dart';

class Range extends BaseMapModel {
  Range.empty();

  Range.fromMap(Map<String, dynamic>? map) {
    if (map == null) return;

    above = map.valueOrNull('above');
    below = map.valueOrNull('below');
    increment = map.valueOrNull('increment');
  }

  Range({
    this.above,
    this.below,
    this.increment,
  });

  double? above;
  double? below;
  double? increment;

  @override
  Range fromMap(Map<String, dynamic> map) => Range(
    above: map.valueOrNull('above'),
    below: map.valueOrNull('below'),
    increment: map.valueOrNull('increment'),
  );

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> result = {};

    if (above != null) result['above'] = above;
    if (below != null) result['below'] = below;
    if (increment != null) result['increment'] = increment;

    return result;
  }
}