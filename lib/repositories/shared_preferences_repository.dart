import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:water_counter/models/drink.dart';
import 'package:water_counter/repositories/database_repository.dart';

const prefsKey = "water_counter";

class SharedPreferencesRepository implements DatabaseRepository {
  final SharedPreferencesAsync prefs = SharedPreferencesAsync();

  int highestId = 0;

  @override
  Future<int> getNumberOfDrinks() async {
    final List<Drink> drinks = await _loadDrinks();

    return drinks.length;
  }

  @override
  Future<List<Drink>> getDrinks() async {
    // Alle Drinks als JSON-String aus Shared Preferences holen.
    List<Drink> drinks = await _loadDrinks();

    // Zurückgeben \0/
    return drinks;
  }

  @override
  Future<void> addDrink() async {
    // Aktuelle Drinks holen.
    List<Drink> drinks = await _loadDrinks();

    // Updaten (Neuen Drink anlegen und hinzufügen)
    final newDrink = Drink(
      id: highestId++,
      timeOfDrink: DateTime.now(),
    );
    drinks.add(newDrink);

    // Upgedatete Drinks zurückschreiben.
    _saveDrinks(drinks);
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
    await prefs.setString(prefsKey, "");
  }

  void _saveToPrefs(int counter) async {
    await prefs.setInt(prefsKey, counter);
  }

  Future<List<Drink>> _loadDrinks() async {
    // Alle Drinks als JSON-String aus Shared Preferences holen.
    final String? jsonString = await prefs.getString(prefsKey);
    // '[{"id": 7, "timeOfDrink": "2024-11-21T10:35:67Z"}, {"id": 8, "timeOfDrink": "2024-11-21T10:40:67Z"}]';
    if (jsonString == null || jsonString.isEmpty) return [];

    // JSON-String in Liste von Drinks umwandeln.
    final List<dynamic> decodedDrinks = jsonDecode(jsonString);

    List<Drink> drinks = [];

    for (final drinkData in decodedDrinks) {
      final drink = Drink(
        id: drinkData["id"] as int,
        timeOfDrink: DateTime.parse(drinkData["timeOfDrink"]),
      );

      drinks.add(drink);
    }
    return drinks;
  }

  void _saveDrinks(List<Drink> drinks) {
    // Drinks in JSON-String umwandeln.
    // 1. List<Drink> in Liste von Maps umwandeln (für JSON)
    final List<dynamic> jsonList = [];
    for (Drink drink in drinks) {
      final drinkMap = {
        "id": drink.id,
        "timeOfDrink": drink.timeOfDrink.toIso8601String(),
      };
      jsonList.add(drinkMap);
    }

    // 2. Enkodieren
    final jsonString = jsonEncode(jsonList);

    log(jsonString);

    // JSON-String in SharedPreferences speichern.
    prefs.setString(prefsKey, jsonString);
  }
}
