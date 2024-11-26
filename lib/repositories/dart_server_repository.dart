import 'dart:convert';
import 'dart:developer';

// Das "as" macht es klarer, wann eine Funktion aus "http" verwendet wird.
import 'package:http/http.dart' as http;
import 'package:water_counter/models/drink.dart';
import 'package:water_counter/repositories/database_repository.dart';

const suffix = 'drinks';

class DartServerRepository implements DatabaseRepository {
  // Wir gehen davon aus, dass wir entweder auf Android oder iOS unterwegs sind.
  DartServerRepository({required bool isAndroid})
      : _baseUrl = isAndroid
            ? 'http://10.0.2.2:8080/$suffix' // Android Emulator
            : 'http://localhost:8080/$suffix'; // iOS and others

  final String _baseUrl;

  @override
  Future<int> getNumberOfDrinks() async {
    final List<Drink> drinks = await getDrinks();

    return drinks.length;
  }

  @override
  Future<List<Drink>> getDrinks() async {
    final http.Response response = await http.get(Uri.parse(_baseUrl));
    // Hier müsste man eigentlich einen Fehlercode zurückgeben.
    if (response.statusCode != 200) return [];

    final List<dynamic> drinksJson = jsonDecode(response.body);
    final List<Drink> drinks = [];
    for (final drinkMap in drinksJson) {
      final Drink newDrink = Drink.fromJson(drinkMap);
      drinks.add(newDrink);
    }

    // Zurückgeben \0/
    return drinks;
  }

  @override
  Future<void> addDrink() async {
    final newDrinkTime = DateTime.now();
    final String newDrinkTimeJson = jsonEncode(newDrinkTime.toIso8601String());
    // In einer richtigen App würde man hier noch mit dem Ergebnis arbeiten.
    final http.Response response = await http.post(
      Uri.parse(_baseUrl),
      body: newDrinkTimeJson,
    );

    log("Response code was: ${response.statusCode}");
  }

  @override
  Future<void> removeDrink() async {}

  @override
  Future<void> removeAllDrinks() async {
    final http.Response response = await http.delete(Uri.parse(_baseUrl));

    log("Response code was: ${response.statusCode}");
  }
}
