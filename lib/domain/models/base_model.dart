import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jimmys/domain/enums/exercise_categories.dart';

abstract class BaseModel extends BaseMapModel {
  late String id;
  late Timestamp createdAt;
  String get path;
}

abstract class BaseMetaModel extends BaseMapModel {
  ExerciseCategories get exerciseCategory;
}

abstract class BaseMapModel {
  dynamic fromMap(Map<String, dynamic> map);
  Map<String, dynamic> toMap();
}