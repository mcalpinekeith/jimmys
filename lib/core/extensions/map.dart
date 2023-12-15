extension MapExtensions on Map {
  dynamic value(String? key, {dynamic defaultValue = ''}) =>
    containsKey(key) && this[key] != null
      ? this[key]
      : defaultValue;

  dynamic valueOrNull(String? key) =>
    containsKey(key) && this[key] != null
      ? this[key]
      : null;
}