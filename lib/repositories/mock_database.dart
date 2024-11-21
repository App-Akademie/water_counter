import 'dart:developer';

import 'package:water_counter/repositories/database_repository.dart';

class MockDatabase implements DatabaseRepository {
  int _counter = 0;

  @override
  Future<int> getCounter() {
    log("got counter");
    return Future.value(_counter);
  }

  @override
  Future<void> incrementCounter() {
    _counter++;
    log("incremented counter");

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

    log("reset counter");

    return Future.value();
  }
}
