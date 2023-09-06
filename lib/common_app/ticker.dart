class Ticker {
  const Ticker();
  Stream<int> tickRestTime({required int ticks}) {
    return Stream.periodic(const Duration(seconds: 1), (x) => ticks - x - 1)
        .take(ticks);
  }

  Stream<int> tickSet({required int ticks}) {
    return Stream.periodic(const Duration(seconds: 1), (x) => ticks + x + 1);
  }
}
