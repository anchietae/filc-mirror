import 'api/model/subject.dart';

extension IterableExtension on Iterable<MapEntry<String, dynamic>> {
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    for (var item in this) {
      map[item.key] = item.value;
    }

    return map;
  }
}

extension DurationExtension on Duration {
  String formatDuration() {
    String hours = inHours.toString().padLeft(2, '0');
    String minutes = inMinutes.remainder(60).toString().padLeft(2, '0');
    String seconds = inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$hours:$minutes:$seconds";
  }
}