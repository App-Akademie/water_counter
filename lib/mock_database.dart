import 'package:water_counter/database_repository.dart';

class MockDatabase implements DatabaseRepository {
  int _counter = 0;

  @override
  Future<int> getCounter() {
    return Future.value(_counter);
  }

  @override
  Future<void> incrementCounter() {
    _counter++;

    return Future.value();
  }

  @override
  Future<void> decrementCounter() {
    _counter--;

    return Future.value();
  }

  @override
  Future<void> resetCounter() {
    _counter = 0;

    return Future.value();
  }
}
