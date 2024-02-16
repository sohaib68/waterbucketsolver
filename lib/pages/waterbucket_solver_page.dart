import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waterbucketsolver/pages/waterbucket_solver_cubit.dart';

class WaterBucketSolverPage extends StatefulWidget {
  const WaterBucketSolverPage({super.key});

  @override
  WaterBucketSolverPageState createState() => WaterBucketSolverPageState();
}

class WaterBucketSolverPageState extends State<WaterBucketSolverPage> {
  final TextEditingController _xController = TextEditingController();
  final TextEditingController _yController = TextEditingController();
  final TextEditingController _zController = TextEditingController();

  void _solveWaterJugProblem() {
    final cubit = context.read<WaterBucketSolverCubit>();
    final int x = int.parse(_xController.text);
    final int y = int.parse(_yController.text);
    final int z = int.parse(_zController.text);
    cubit.solve(x, y, z);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WaterBucketSolverCubit, WaterBucketSolverState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Water Bucket Challenge Solver'),
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
              if (state.solutionSteps.isNotEmpty)
                Expanded(
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
                        rows: state.solutionSteps
                            .asMap()
                            .entries
                            .map(
                              (step) => DataRow(
                                  color: MaterialStateProperty.resolveWith((states) {
                                    if (step.key + 1 == state.solutionSteps.length) {
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
                                    DataCell(Text(((step.value['explanation'] ?? '')))),
                                  ]),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                ),
              if (state.isSolutionFound && state.solutionSteps.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(20),
                  child: Text("Solution not found"),
                ),
              // Optionally, include a message or container for the initial state
            ],
          ),
        );
      },
    );
  }
}
