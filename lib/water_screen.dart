import 'package:flutter/material.dart';
import 'package:water_counter/models/drink.dart';
import 'package:water_counter/w_c_button.dart';

class WaterScreen extends StatelessWidget {
  const WaterScreen({
    super.key,
    required this.drinks,
    required this.counter,
    required this.incrementCounter,
    required this.resetCounter,
  });

  final List<Drink> drinks;
  final int counter;
  // Das gleiche wie "void Function()"
  final VoidCallback incrementCounter;
  // Das gleiche wie "VoidCallback"
  final void Function() resetCounter;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 64),
          const Text(
            "Getränke und Zeitpunkt",
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(height: 16),
          for (final drink in drinks) Text("${drink.id} ${drink.timeOfDrink}"),
          SizedBox(height: 64),
          const Text(
            "Anzahl der Getränke",
            style: TextStyle(fontSize: 24),
          ),
          Text(
            "$counter",
            style: Theme.of(context).textTheme.displayLarge,
          ),
          const SizedBox(height: 64),
          Padding(
            padding: EdgeInsets.only(left: 32.0, right: 32.0),
            child: WCButton(
              onPressed: incrementCounter,
              text: "Trinken",
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.only(left: 32.0, right: 32.0),
            child: WCButton(
              // TODO: Missing function to remove a drink (_decrementCounter).
              onPressed: null,
              text: "Getränk entfernen",
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.only(left: 32.0, right: 32.0),
            child: WCButton(
              onPressed: resetCounter,
              text: "Zähler zurücksetzen",
            ),
          ),
        ],
      ),
    );
  }
}
