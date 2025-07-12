DateTime? fakeTime;

DateTime timeNow() {
  if (fakeTime != null) {
    return fakeTime!;
  } else {
    return DateTime.now();
  }
}
