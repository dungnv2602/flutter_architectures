class MyTimer {
  Stream<int> tick({int ticks}) {
    return Stream.periodic(const Duration(seconds: 1), (count) {
      final remaining = ticks - count;
      return remaining < 0 ? 0 : remaining;
    });
  }
}
