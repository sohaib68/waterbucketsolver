import 'package:flutter_test/flutter_test.dart';
import 'package:waterbucketsolver/models/bucket_state.dart';
import 'package:waterbucketsolver/pages/waterbucket_solver_cubit.dart';

void main() {
  group('WaterBucketSolverCubit Tests', () {
    test('Initial state is correct', () {
      expect(WaterBucketSolverCubit().state, equals(const WaterBucketSolverState()));
    });

    test('canSolve method returns correct result', () {
      final cubit = WaterBucketSolverCubit();
      expect(cubit.canSolve(3, 5, 4), isTrue); // Valid scenario
      expect(cubit.canSolve(3, 5, 7), isFalse); // Invalid scenario
    });

    test('gcd method returns correct result', () {
      final cubit = WaterBucketSolverCubit();
      expect(cubit.gcd(24, 36), equals(12));
      expect(cubit.gcd(17, 23), equals(1));
    });

    test('getNextStates returns correct list of actions', () {
      final cubit = WaterBucketSolverCubit();
      final nextStates = cubit.getNextStates(BucketState(3, 5), 8, 10, 6);
      expect(nextStates.length, equals(6));
    });

    test('solve method finds correct solution', () {
      final cubit = WaterBucketSolverCubit();
      cubit.solve(3, 5, 4);
      expect(cubit.state.solutionNotFound, isFalse);
    });

    test('solve method handles edge cases correctly', () {
      final cubit = WaterBucketSolverCubit();
      cubit.solve(0, 5, 4);
      expect(cubit.state.solutionNotFound, isTrue); // Edge case where one bucket capacity is 0
      cubit.solve(3, 5, 0);
      expect(cubit.state.solutionNotFound, isFalse);
    });

    test('solve method performance test', () {
      final cubit = WaterBucketSolverCubit();
      // Measure time taken for solving with large inputs
      final stopwatch = Stopwatch()..start();
      cubit.solve(100, 100, 50);
      print('solve method took ${stopwatch.elapsed}');
    });
  });
}
