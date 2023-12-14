abstract class BaseModel extends BaseMapModel {
  late String id;
  late DateTime createdAt;
  String get path;
}

abstract class BaseMapModel {
  dynamic fromMap(Map<String, dynamic> map);
  Map<String, dynamic> toMap();
}