import 'package:flutter/material.dart';
import 'package:jimmys/core/extensions/string.dart';

class ListController extends ChangeNotifier {
  ListController(this.title, this.values);

  String title;
  List<String> values = [];
  List<String> selected = [];

  bool get isEmpty => selected.isEmpty;
  bool get isNotEmpty => selected.isNotEmpty;

  String get selectedSummary =>
    selected.length == 1 ? selected.last :
    selected.length == 2 ? '${selected.first} or ${selected.last}' :
    selected.length > 2 ? '${selected.take(selected.length - 1).join(', ')}, or ${selected.last}' : '';

  bool contains(String value) => selected.contains(value);

  void change(String value, bool isSelected) {
    selected.removeWhere((_) => _ == value);

    if (isSelected) {
      if (value.isNullOrEmpty) return;

      selected.add(value);
    }

    notifyListeners();
  }
}