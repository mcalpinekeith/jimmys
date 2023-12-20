extension IterableExtensions on Iterable {
  List<String> toDistinct() => List.from(this).toSet().map((_) => _.toString()).toList();
}