extension MapExtensions on Map {
  dynamic value(String key, dynamic defaultValue) => containsKey(key) && this[key] != null ? this[key] : defaultValue;
}