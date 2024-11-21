import 'dart:developer';

import 'package:water_counter/models/drink.dart';
import 'package:water_counter/repositories/database_repository.dart';

// TODO: Liste von Drinks benutzen, anstatt einfachen Counter.
class MockDatabase implements DatabaseRepository {
  final List<Drink> _drinks = [];
  int lastId = 0;

  @override
  Future<int> getNumberOfDrinks() {
    log("got number of drinks");
    return Future.value(_drinks.length);
  }

  @override
  Future<void> addDrink() {
    _drinks.add(Drink(id: lastId++, timeOfDrink: DateTime.now()));
    log("added drink>");

    return Future.value();
  }

  @override
  Future<void> removeDrink() {
    // TODO: Implement function

    return Future.value();
  }

  @override
  Future<void> removeAllDrinks() {
    _drinks.clear();

    log("removed all drinks");

    return Future.value();
  }

  @override
  Future<List<Drink>> getDrinks() {
    return Future.value(_drinks);
  }
}
