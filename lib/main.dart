import 'package:flutter/material.dart';
import 'dart:collection';

enum JugStateType {
  empty,
  partiallyFull,
  full,
}

class JugState {
  final int x;
  final int y;
  final JugStateType jugXState;
  final JugStateType jugYState;
  final List<String> steps;

  JugState(this.x, this.y, this.jugXState, this.jugYState, this.steps);
}

class WaterJugApp extends StatelessWidget {
  const WaterJugApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Water Jug Challenge',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const WaterJugScreen(),
    );
  }
}

class WaterJugScreen extends StatefulWidget {
  const WaterJugScreen({super.key});

  @override
  WaterJugScreenState createState() => WaterJugScreenState();
}

class WaterJugScreenState extends State<WaterJugScreen> {
  int jugX = 0;
  int jugY = 0;
  int goalZ = 0;
  String solution = '';

  void solveWaterJugChallenge(int x, int y, int z) {
    setState(() {
      jugX = x;
      jugY = y;
      goalZ = z;
      solution = _getSolution();
    });
  }

  String _getSolution() {
    if (goalZ > jugX && goalZ > jugY) {
      return 'No Solution';
    }

    if (goalZ % _gcd(jugX, jugY) != 0) {
      return 'No Solution';
    }

    return _explorePaths(jugX, jugY, goalZ);
  }

  int _gcd(int a, int b) {
    if (b == 0) {
      return a;
    }
    return _gcd(b, a % b);
  }

  String _explorePaths(int x, int y, int z) {
    Queue<JugState> queue = Queue();
    Set<List<int>> visited = {};

    queue.add(JugState(0, 0, JugStateType.empty, JugStateType.empty, []));
    visited.add([0, 0]);

    while (queue.isNotEmpty) {
      print('Queue: ${queue.length.toString()}');
      JugState currentState = queue.removeFirst();

      if (currentState.x == z || currentState.y == z) {
        return currentState.steps.join('\n');
      }

      for (var nextState in _getNextStates(currentState, x, y)) {
        if (!visited.contains([nextState.x, nextState.y])) {
          queue.add(nextState);
          visited.add([nextState.x, nextState.y]);
        }
      }
    }
    return 'No Solution';
  }

  List<JugState> _getNextStates(JugState currentState, int x, int y) {
    List<JugState> nextStates = [];

    // Fill Jug X
    nextStates.add(JugState(x, currentState.y, JugStateType.full, currentState.jugYState,
        List.from(currentState.steps)..add('Fill Jug X ($x, ${currentState.y})')));

    // Fill Jug Y
    nextStates.add(JugState(currentState.x, y, currentState.jugXState, JugStateType.full,
        List.from(currentState.steps)..add('Fill Jug Y (${currentState.x}, $y)')));

    // Empty Jug X
    nextStates.add(JugState(0, currentState.y, JugStateType.empty, currentState.jugYState,
        List.from(currentState.steps)..add('Empty Jug X (0, ${currentState.y})')));

    // Empty Jug Y
    nextStates.add(JugState(currentState.x, 0, currentState.jugXState, JugStateType.empty,
        List.from(currentState.steps)..add('Empty Jug Y (${currentState.x}, 0)')));

    // Pour from Jug X to Jug Y
    int amountToPour = currentState.x < y - currentState.y ? currentState.x : y - currentState.y;
    nextStates.add(JugState(
        currentState.x - amountToPour,
        currentState.y + amountToPour,
        _getJugState(currentState.x - amountToPour, x),
        _getJugState(currentState.y + amountToPour, y),
        List.from(currentState.steps)
          ..add('Pour from Jug X to Jug Y (${currentState.x - amountToPour}, ${currentState.y + amountToPour})')));

    // Pour from Jug Y to Jug X
    amountToPour = currentState.y < x - currentState.x ? currentState.y : x - currentState.x;
    nextStates.add(JugState(
        currentState.x + amountToPour,
        currentState.y - amountToPour,
        _getJugState(currentState.x + amountToPour, x),
        _getJugState(currentState.y - amountToPour, y),
        List.from(currentState.steps)
          ..add('Pour from Jug Y to Jug X (${currentState.x + amountToPour}, ${currentState.y - amountToPour})')));

    return nextStates;
  }

  JugStateType _getJugState(int currentAmount, int capacity) {
    if (currentAmount == 0) {
      return JugStateType.empty;
    } else if (currentAmount == capacity) {
      return JugStateType.full;
    } else {
      return JugStateType.partiallyFull;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Water Jug Challenge'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Jug X capacity'),
              onChanged: (value) {
                setState(() {
                  jugX = int.tryParse(value) ?? 0;
                });
              },
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Jug Y capacity'),
              onChanged: (value) {
                setState(() {
                  jugY = int.tryParse(value) ?? 0;
                });
              },
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Goal Z'),
              onChanged: (value) {
                setState(() {
                  goalZ = int.tryParse(value) ?? 0;
                });
              },
            ),
            ElevatedButton(
              onPressed: () => solveWaterJugChallenge(jugX, jugY, goalZ),
              child: const Text('Solve'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Solution:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  solution,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const WaterJugApp());
}
