extension IterableExtension on Iterable<MapEntry<String, dynamic>> {
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    for (var item in this) {
      map[item.key] = item.value;
    }

    return map;
  }
}