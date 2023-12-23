import 'package:jimmys/domain/enums/base_enum.dart';

extension MapExtensions on Map {
  dynamic value(String? key, {dynamic defaultValue = '', BaseEnum? enumerable}) {
    if (!containsKey(key) || this[key] == null) return defaultValue;

    if (enumerable == null) return this[key];

    return enumerable.getTitle(this[key] as int);
  }

  dynamic valueOrNull(String? key, {BaseEnum? enumerable}) {
    if (!containsKey(key) || this[key] == null) return null;

    if (enumerable == null) return this[key];

    return enumerable.getTitle(this[key] as int);
  }
}