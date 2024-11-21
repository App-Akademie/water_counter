import 'package:water_counter/models/drink.dart';

abstract class DatabaseRepository {
  Future<int> getNumberOfDrinks();

  Future<List<Drink>> getDrinks();

  Future<void> addDrink();

  // TODO: Welcher Drink soll weg???
  Future<void> removeDrink();

  Future<void> removeAllDrinks();
}
