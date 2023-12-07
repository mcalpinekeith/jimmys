extension NullableStringExtensions on String? {
  /// Returns `true` if this string is `null` or empty.
  bool get isNullOrEmpty => this?.isEmpty ?? true;

  /// Returns `true` if this string is not `null` and not empty.
  bool get isNotNullNorEmpty => this?.isNotEmpty ?? false;
}