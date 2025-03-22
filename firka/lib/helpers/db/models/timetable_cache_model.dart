import 'package:isar/isar.dart';
part 'timetable_cache_model.g.dart';

@collection
class TimetableCacheModel {
  Id? cacheKey;

  List<TimetableClass>? classes;

  TimetableCacheModel();
}

@embedded
class TimetableClass {
  
}