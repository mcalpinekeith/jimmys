abstract class BaseModel {
  String get path;
  late String id;

  dynamic fromMap(Map<String, dynamic> map);
  Map<String, dynamic> toMap();
}