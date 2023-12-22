import 'package:jimmys/core/extensions/map.dart';
import 'package:jimmys/domain/enums/exercise_categories.dart';
import 'package:jimmys/domain/models/base_model.dart';

class SwimMeta extends BaseMetaModel {
  SwimMeta({
    this.time,
    this.length,
  });

  static const lengthDefaultValue = 4;

  String? time; /// hh:mm
  int? length; /// 1-200 where 1 length = 50m

  @override
  SwimMeta fromMap(Map<String, dynamic> map) => SwimMeta(
    time: map.valueOrNull('time'),
    length: map.valueOrNull('length'),
  );

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> result = {};

    if (time != null) result['time'] = time;
    if (length != null) result['length'] = length;

    return result;
  }

  @override
  ExerciseCategories get exerciseCategory => ExerciseCategories.swim;
}

/*
back(15, 'Backstroke'),
breast(20, 'Breaststroke'),
butterfly(25, 'Butterfly stroke'),
corkscrew(30, 'Corkscrew swimming'),
feetFirst(35, 'Feet first swimming'),
freestyle(40, 'Freestyle'),
frontCrawl(45, 'Front crawl'),
gliding(50, 'Gliding'),
side(55, 'Sidestroke'),
snorkeling(60, 'Snorkeling'),
survivalTravel(65, 'Survival travel stroke'),
trudgen(70, 'Trudgen'),
turtle(75, 'Turtle stroke');
*/