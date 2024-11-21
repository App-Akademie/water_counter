abstract class DatabaseRepository {
  Future<int> getCounter();

  Future<void> incrementCounter();

  Future<void> decrementCounter();

  Future<void> resetCounter();
}
