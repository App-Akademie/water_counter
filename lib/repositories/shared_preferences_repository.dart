import 'package:shared_preferences/shared_preferences.dart';
import 'package:water_counter/repositories/database_repository.dart';

const prefsKey = "water_counter";

class SharedPreferencesRepository implements DatabaseRepository {
  final SharedPreferencesAsync prefs = SharedPreferencesAsync();

  @override
  Future<int> getCounter() async {
    // Counter aus den Shared Preferences holen und zurückgeben.
    return await prefs.getInt(prefsKey) ?? 0;
  }

  @override
  Future<void> incrementCounter() async {
    // Aktuellen Wert holen.
    int counter = await prefs.getInt(prefsKey) ?? 0;
    // Updaten
    counter++;
    // Neuen Wert zurückschreiben.
    _saveToPrefs(counter);
  }

  @override
  Future<void> decrementCounter() async {
    // Aktuellen Wert holen.
    int counter = await prefs.getInt(prefsKey) ?? 0;
    // Updaten
    counter--;
    // Neuen Wert zurückschreiben.
    _saveToPrefs(counter);
  }

  @override
  Future<void> resetCounter() async {
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
