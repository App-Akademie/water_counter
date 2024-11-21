import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:water_counter/water_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final SharedPreferencesAsync prefs = SharedPreferencesAsync();

  int _counter = 0;

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  void _loadCounter() async {
    final rememberedCounter = await prefs.getInt("counter") ?? 0;
    setState(() {
      _counter = rememberedCounter;
    });
  }

  void _incrementCounter() async {
    setState(() {
      _counter++;
    });
    await prefs.setInt("counter", _counter);
  }

  // TODO: This should be implemented.
  // ignore: unused_element
  void _decrementCounter() {}

  void _resetCounter() async {
    setState(() {
      _counter = 0;
    });

    await prefs.setInt("counter", _counter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 8.0,
        title: const Text("WaterCounter"),
      ),
      body: WaterScreen(
        counter: _counter,
        incrementCounter: _incrementCounter,
        resetCounter: _resetCounter,
      ),
    );
  }
}
