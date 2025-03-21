import 'package:isar/isar.dart';
part 'cache_model.g.dart';

enum CacheId {
  getStudent
}

@collection
class CacheModel {
  Id? cacheKey;
  String? cacheData;

  CacheModel();
}