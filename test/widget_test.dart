import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:waterbucketsolver/pages/waterbucket_solver_page.dart';
import 'package:waterbucketsolver/pages/waterbucket_solver_cubit.dart';

void main() {
  testWidgets('WaterBucketSolverPage UI Test', (WidgetTester tester) async {
    // Create a mock cubit instance
    final cubit = WaterBucketSolverCubit();

    // Provide the cubit to the widget tree
    await tester.pumpWidget(MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider<WaterBucketSolverCubit>.value(value: cubit),
        ],
        child: const WaterBucketSolverPage(),
      ),
    ));

    // Verify that the title is displayed
    expect(find.text('Water Bucket Challenge Solver'), findsOneWidget);

    // Enter values in text fields
    await tester.enterText(find.byKey(const ValueKey('XTextField')), '5');
    await tester.enterText(find.byKey(const ValueKey('YTextField')), '3');
    await tester.enterText(find.byKey(const ValueKey('ZTextField')), '4');

    // Tap on the solve button
    await tester.tap(find.text('Solve'));
    await tester.pump();

    // Verify that the solution steps are displayed
    expect(find.byType(DataTable), findsOneWidget);
  });
}
