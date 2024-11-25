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
  int counter = 0;

  List<Drink> drinks = [];

  @override
  void initState() {
    super.initState();
    _getDrinks();
    setState(() {});
  }

  void _getDrinks() async {
    drinks = await widget.repository.getDrinks();
    counter = drinks.length;
  }

  void _incrementCounter() async {
    await widget.repository.addDrink();
    drinks = await widget.repository.getDrinks();

    setState(() {
      counter = drinks.length;
    });
  }

  void _resetCounter() async {
    await widget.repository.removeAllDrinks();

    drinks = await widget.repository.getDrinks();

    setState(() {
      counter = drinks.length;
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
        counter: counter,
        incrementCounter: _incrementCounter,
        resetCounter: _resetCounter,
      ),
    );
  }
}
