import 'dart:io';

import 'package:flutter/material.dart';
import 'package:water_counter/models/drink.dart';
import 'package:water_counter/repositories/dart_server_repository.dart';
import 'package:water_counter/repositories/database_repository.dart';
import 'package:water_counter/water_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  final DatabaseRepository repository =
      DartServerRepository(isAndroid: Platform.isAndroid);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _counter = 0;

  List<Drink> drinks = [];

  @override
  void initState() {
    super.initState();
    _loadCounter();
    _getDrinks();
  }

  void _getDrinks() async {
    drinks = await widget.repository.getDrinks();
    setState(() {});
  }

  void _loadCounter() async {
    final rememberedCounter = await widget.repository.getNumberOfDrinks();

    setState(() {
      _counter = rememberedCounter;
    });
  }

  void _incrementCounter() async {
    await widget.repository.addDrink();
    final updatedCounter = await widget.repository.getNumberOfDrinks();

    setState(() {
      _counter = updatedCounter;
    });
  }

  void _resetCounter() async {
    await widget.repository.removeAllDrinks();
    final updatedCounter = await widget.repository.getNumberOfDrinks();
    setState(() {
      _counter = updatedCounter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 8.0,
        title: const Text("WaterCounter"),
      ),
      body: WaterScreen(
        drinks: drinks,
        counter: _counter,
        incrementCounter: _incrementCounter,
        resetCounter: _resetCounter,
      ),
    );
  }
}
