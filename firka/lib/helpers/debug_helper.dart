DateTime? fakeTime;
Duration? offset;
var tick = false;

DateTime timeNow() {
  if (fakeTime != null) {
    if (tick && offset != null) {
      return fakeTime!.add(offset!);
    } else {
      return fakeTime!;
    }
  } else {
    return DateTime.now();
  }
}
