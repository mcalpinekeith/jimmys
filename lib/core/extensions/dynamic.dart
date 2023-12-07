extension DynamicExtensions on dynamic {
  List<String> toStringList() {
    final result = <String>[];

    for (var item in List.from(this)) {
      result.add(item.toString());
    }

    return result;
  }
}