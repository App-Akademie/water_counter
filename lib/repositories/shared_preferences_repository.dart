import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:water_counter/models/drink.dart';
import 'package:water_counter/repositories/database_repository.dart';

const prefsKey = "water_counter";

class SharedPreferencesRepository implements DatabaseRepository {
  final SharedPreferencesAsync prefs = SharedPreferencesAsync();

  @override
  Future<int> getNumberOfDrinks() async {
    // Alle Drinks als JSON-String aus Shared Preferences holen.
    // '[{"id": 7, "timeOfDrink": "2024-11-21 10:35.6788Z"}, {"id": 8, "timeOfDrink": "2024-11-21 10:40.6788Z"}]'
    final String? jsonString = await prefs.getString(prefsKey);
    if (jsonString == null) return 0;

    // JSON-String in Liste von Drinks umwandeln.
    final List<dynamic> decodedDrinks = jsonDecode(jsonString);

    // Zurückgeben \0/
    return decodedDrinks.length;
  }

  @override
  Future<List<Drink>> getDrinks() async {
    // Alle Drinks als JSON-String aus Shared Preferences holen.
    // '[{"id": 7, "timeOfDrink": "2024-11-21 10:35.6788Z"}, {"id": 8, "timeOfDrink": "2024-11-21 10:40.6788Z"}]'
    // final String? jsonString = await prefs.getString(prefsKey);
    final String jsonString =
        '[{"id": 7, "timeOfDrink": "2024-11-21T10:35:67Z"}, {"id": 8, "timeOfDrink": "2024-11-21T10:40:67Z"}]';
    //  if (jsonString == null) return [];

    // JSON-String in Liste von Drinks umwandeln.
    final List<dynamic> decodedDrinks = jsonDecode(jsonString);

    List<Drink> drinks = [];

    for (final drinkData in decodedDrinks) {
      final newDrink = Drink(
        id: drinkData["id"] as int,
        timeOfDrink: DateTime.parse(drinkData["timeOfDrink"]),
      );

      drinks.add(newDrink);
    }

    // Zurückgeben \0/
    return drinks;
  }

  @override
  Future<void> addDrink() async {
    // Aktuellen Wert holen.
    int counter = await prefs.getInt(prefsKey) ?? 0;
    // Updaten
    counter++;
    // Neuen Wert zurückschreiben.
    _saveToPrefs(counter);
  }

  @override
  Future<void> removeDrink() async {
    // Aktuellen Wert holen.
    int counter = await prefs.getInt(prefsKey) ?? 0;
    // Updaten
    counter--;
    // Neuen Wert zurückschreiben.
    _saveToPrefs(counter);
  }

  @override
  Future<void> removeAllDrinks() async {
    // Aktuellen Wert holen.
    int counter = await prefs.getInt(prefsKey) ?? 0;
    // Updaten
    counter = 0;
    // Neuen Wert zurückschreiben.
    _saveToPrefs(counter);
  }

  void _saveToPrefs(int counter) async {
    await prefs.setInt(prefsKey, counter);
  }
}
