import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waterbucketsolver/pages/waterbucket_solver_cubit.dart';
import 'package:waterbucketsolver/widgets/custrom_int_textfield.dart';

class WaterBucketSolverPage extends StatefulWidget {
  const WaterBucketSolverPage({super.key});

  @override
  WaterBucketSolverPageState createState() => WaterBucketSolverPageState();
}

class WaterBucketSolverPageState extends State<WaterBucketSolverPage> {
  final TextEditingController _xController = TextEditingController();
  final TextEditingController _yController = TextEditingController();
  final TextEditingController _zController = TextEditingController();
  final FocusNode _xFocus = FocusNode();
  final FocusNode _yFocus = FocusNode();
  final FocusNode _zFocus = FocusNode();
  final snackBar = const SnackBar(
    showCloseIcon: true,
    content: Text('Please enter a value for all fields.'),
  );

  @override
  void dispose() {
    _xController.dispose();
    _yController.dispose();
    _zController.dispose();
    _xFocus.dispose();
    _yFocus.dispose();
    _zFocus.dispose();
    super.dispose();
  }

  void _solveWaterBucketProblem() {
    final cubit = context.read<WaterBucketSolverCubit>();
    final int? x = int.tryParse(_xController.text);
    final int? y = int.tryParse(_yController.text);
    final int? z = int.tryParse(_zController.text);
    if (x == null || y == null || z == null) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      cubit.solve(x, y, z);
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return BlocBuilder<WaterBucketSolverCubit, WaterBucketSolverState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Water Bucket Challenge Solver'),
          ),
          body: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: theme.colorScheme.background,
                  border: Border.all(width: 1.0, color: Colors.transparent),
                  borderRadius: const BorderRadius.all(Radius.circular(10.0) //                 <--- border radius here
                      ),
                ),
                child: Column(
                  children: [
                    const Text('Please enter integer only values'),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CustomIntTextField(
                                key: const ValueKey('XTextField'),
                                autoFocus: true,
                                focusNode: _xFocus,
                                nextFocus: _yFocus,
                                controller: _xController,
                              )),
                        ),
                        Expanded(
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CustomIntTextField(
                                key: const ValueKey('YTextField'),
                                focusNode: _yFocus,
                                nextFocus: _zFocus,
                                controller: _yController,
                              )),
                        ),
                        Expanded(
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CustomIntTextField(
                                key: const ValueKey('ZTextField'),
                                focusNode: _zFocus,
                                nextFocus: _xFocus,
                                controller: _zController,
                              )),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: _solveWaterBucketProblem,
                      child: const Text('Solve'),
                    ),
                  ],
                ),
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
                                      return theme.primaryColor;
                                    } else {
                                      return theme.cardColor;
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
              if (state.solutionNotFound && state.solutionSteps.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Icon(Icons.do_disturb_on, size: 100, color: Colors.red),
                      ),
                      Text("Solution not found"),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
