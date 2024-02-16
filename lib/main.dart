import 'package:flutter/material.dart';
import 'dart:collection';
import 'dart:math';

void main() => runApp(const WaterJugApp());

class WaterJugApp extends StatelessWidget {
  const WaterJugApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: WaterJugSolverPage(),
    );
  }
}

class WaterJugSolverPage extends StatefulWidget {
  const WaterJugSolverPage({super.key});

  @override
  WaterJugSolverPageState createState() => WaterJugSolverPageState();
}

class WaterJugSolverPageState extends State<WaterJugSolverPage> {
  final TextEditingController _xController = TextEditingController();
  final TextEditingController _yController = TextEditingController();
  final TextEditingController _zController = TextEditingController();
  List<Map<String, String>> _solutionSteps = [];
  bool _isSolutionFound = true; // Add a flag to track if a solution was found

  void _solveWaterJugProblem() {
    final int x = int.parse(_xController.text);
    final int y = int.parse(_yController.text);
    final int z = int.parse(_zController.text);
    final solver = WaterJugSolver(x, y, z);
    final solutionSteps = solver.solve();
    setState(() {
      if (solutionSteps != null) {
        _solutionSteps = solutionSteps;
        _isSolutionFound = true; // Solution found
      } else {
        _solutionSteps.clear(); // Clear previous steps
        _isSolutionFound = false; // No solution found
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Water Jug Challenge Solver'),
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _xController,
                    decoration: const InputDecoration(labelText: 'X Jug Capacity'),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _yController,
                    decoration: const InputDecoration(labelText: 'Y Jug Capacity'),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _zController,
                    decoration: const InputDecoration(labelText: 'Target Z Amount'),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ),
            ],
          ),

          ElevatedButton(
            onPressed: _solveWaterJugProblem,
            child: const Text('Solve'),
          ),
          _isSolutionFound
              ? (_solutionSteps.isNotEmpty
                  ? Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: DataTable(
                            columnSpacing: 30,
                            columns: const [
                              DataColumn(label: Text('')),
                              DataColumn(label: Text('X')),
                              DataColumn(label: Text('Y')),
                              DataColumn(label: Text('Explanation')),
                            ],
                            rows: _solutionSteps
                                .asMap()
                                .entries
                                .map(
                                  (step) => DataRow(
                                      color: MaterialStateProperty.resolveWith((states) {
                                        if (step.key + 1 == _solutionSteps.length) {
                                          return Colors.lightGreen.shade200;
                                        } else {
                                          return Colors.white;
                                        }
                                      }),
                                      cells: [
                                        DataCell(ConstrainedBox(
                                          constraints: const BoxConstraints(maxWidth: 50),
                                          child: Text(
                                            '${(step.key + 1).toString()}.',
                                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                          ),
                                        )),
                                        DataCell(ConstrainedBox(
                                          constraints: const BoxConstraints(maxWidth: 50),
                                          child: Text(step.value['x'] ?? '',
                                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                        )),
                                        DataCell(ConstrainedBox(
                                          constraints: const BoxConstraints(maxWidth: 50),
                                          child: Text(step.value['y'] ?? '',
                                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                        )),
                                        DataCell(Text((step.value['explanation'] ?? ''))),
                                      ]),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                    )
                  : Container())
              : const Padding(
                  padding: EdgeInsets.all(20),
                  child: Text("Solution not found"),
                ),
          // Optionally, include a message or container for the initial state
        ],
      ),
    );
  }
}

class JugState {
  int x, y;

  JugState(this.x, this.y);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is JugState && runtimeType == other.runtimeType && x == other.x && y == other.y;

  @override
  int get hashCode => x.hashCode ^ y.hashCode;
}

class JugAction {
  final JugState state;
  final String explanation;

  JugAction(this.state, this.explanation);
}

class WaterJugSolver {
  final int X, Y, Z;
  late Set<JugState> visited;

  WaterJugSolver(this.X, this.Y, this.Z);

  bool canSolve() {
    if (Z > X && Z > Y) return false;
    if (Z % gcd(X, Y) != 0) return false;
    return true;
  }

  int gcd(int a, int b) {
    if (b == 0) return a;
    return gcd(b, a % b);
  }

  List<Map<String, String>>? solve() {
    if (!canSolve()) return null;
    visited = <JugState>{};

    Queue<List<JugAction>> queue = Queue();
    queue.add([JugAction(JugState(0, 0), '')]); // Add initial state without the "Start" label

    while (queue.isNotEmpty) {
      print('Queue: ${queue.length.toString()}');
      List<JugAction> path = queue.removeFirst();
      JugState currentState = path.isNotEmpty ? path.last.state : JugState(0, 0); // Check if path is empty

      if (currentState.x == Z || currentState.y == Z) {
        // Skip the first empty action if present
        List<Map<String, String>> solutionSteps = path
            .where((action) => action.explanation.isNotEmpty)
            .map((e) => {'x': e.state.x.toString(), 'y': e.state.y.toString(), 'explanation': e.explanation})
            .toList();
        if (solutionSteps.isEmpty) {
          // Handle edge case where first action solves the problem
          solutionSteps.add({
            'x': currentState.x.toString(),
            'y': currentState.y.toString(),
            'explanation': 'Achieve target directly'
          });
        }
        return solutionSteps;
      }

      if (!visited.contains(currentState)) {
        visited.add(currentState);
        var nextStates = getNextStates(currentState);

        for (var action in nextStates) {
          if (path.isEmpty || (action.state.x != 0 || action.state.y != 0)) {
            // Avoid re-adding the initial state
            List<JugAction> newPath = List.from(path)..add(action);
            queue.add(newPath);
          }
        }
      }
    }

    return null;
  }

  List<JugAction> getNextStates(JugState currentState) {
    List<JugAction> result = [];
    // Fill X Jug
    result.add(JugAction(JugState(X, currentState.y), 'Fill bucket X'));
    // Fill Y Jug
    result.add(JugAction(JugState(currentState.x, Y), 'Fill bucket Y'));
    // Empty X Jug
    result.add(JugAction(JugState(0, currentState.y), 'Empty bucket X'));
    // Empty Y Jug
    result.add(JugAction(JugState(currentState.x, 0), 'Empty bucket Y'));
    // Transfer X to Y
    int total = currentState.x + currentState.y;
    int newY = min(total, Y);
    int newX = total - newY;
    result.add(JugAction(JugState(newX, newY), 'Transfer from bucket X to bucket Y'));
    // Transfer Y to X
    total = currentState.x + currentState.y;
    newX = min(total, X);
    newY = total - newX;
    result.add(JugAction(JugState(newX, newY), 'Transfer from bucket Y to bucket X'));

    return result.where((action) => !visited.contains(action.state)).toList();
  }
}
