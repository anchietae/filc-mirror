import 'package:isar/isar.dart';
part 'generic_cache_model.g.dart';

enum CacheId {
  getStudent
}

@collection
class GenericCacheModel {
  Id? cacheKey;
  String? cacheData;

  GenericCacheModel();
}