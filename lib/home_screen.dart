import 'package:flutter/material.dart';
import 'package:water_counter/database_repository.dart';
import 'package:water_counter/mock_database.dart';
import 'package:water_counter/water_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  final DatabaseRepository repository = MockDatabase();

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  void _loadCounter() async {
    final rememberedCounter = await widget.repository.getCounter();

    setState(() {
      _counter = rememberedCounter;
    });
  }

  void _incrementCounter() async {
    await widget.repository.incrementCounter();
    final updatedCounter = await widget.repository.getCounter();

    setState(() {
      _counter = updatedCounter;
    });
  }

  void _resetCounter() async {
    await widget.repository.resetCounter();
    final updatedCounter = await widget.repository.getCounter();
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
        counter: _counter,
        incrementCounter: _incrementCounter,
        resetCounter: _resetCounter,
      ),
    );
  }
}
