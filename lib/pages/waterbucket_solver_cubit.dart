import 'dart:collection';
import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waterbucketsolver/models/bucket_state.dart';

part 'waterbucket_solver_state.dart';

class WaterBucketSolverCubit extends Cubit<WaterBucketSolverState> {
  WaterBucketSolverCubit() : super(const WaterBucketSolverState());

  Set<BucketState> visited = <BucketState>{};
  BucketState currentState = BucketState(0, 0);

  bool canSolve(int x, int y, int z) {
    if (z > x && z > y) return false;
    if (z % gcd(x, y) != 0) return false;
    return true;
  }

  int gcd(int a, int b) {
    if (b == 0) return a;
    return gcd(b, a % b);
  }

  List<BucketAction> getNextStates(BucketState currentState, int x, int y, int z) {
    List<BucketAction> result = [];
    // Fill X Bucket
    result.add(BucketAction(BucketState(x, currentState.y), 'Fill bucket X'));
    // Fill Y Bucket
    result.add(BucketAction(BucketState(currentState.x, y), 'Fill bucket Y'));
    // Empty X Bucket
    result.add(BucketAction(BucketState(0, currentState.y), 'Empty bucket X'));
    // Empty Y Bucket
    result.add(BucketAction(BucketState(currentState.x, 0), 'Empty bucket Y'));
    // Transfer X to Y
    int total = currentState.x + currentState.y;
    int newY = min(total, y);
    int newX = total - newY;
    result.add(BucketAction(BucketState(newX, newY), 'Transfer from bucket X to bucket Y'));
    // Transfer Y to X
    total = currentState.x + currentState.y;
    newX = min(total, x);
    newY = total - newX;
    result.add(BucketAction(BucketState(newX, newY), 'Transfer from bucket Y to bucket X'));

    return result.where((action) => !visited.contains(action.state)).toList();
  }

  void solve(int x, int y, int z) {
    if (!canSolve(x, y, z)) {
      emit(state.copyWith(solutionSteps: [], solutionNotFound: true));
      return; // Return immediately if the problem cannot be solved
    }
    visited = <BucketState>{};
    Queue<List<BucketAction>> queue = Queue();
    queue.add([BucketAction(BucketState(0, 0), '')]); // Add initial state without the "Start" label

    while (queue.isNotEmpty) {
      List<BucketAction> path = queue.removeFirst();
      currentState = path.isNotEmpty ? path.last.state : BucketState(0, 0); // Check if path is empty

      if (currentState.x == z || currentState.y == z) {
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
        emit(state.copyWith(solutionSteps: solutionSteps, solutionNotFound: false));
        return; // Return as soon as solution is found
      }

      if (!visited.contains(currentState)) {
        visited.add(currentState);
        var nextStates = getNextStates(currentState, x, y, z);

        for (var action in nextStates) {
          if (path.isEmpty || (action.state.x != 0 || action.state.y != 0)) {
            // Avoid re-adding the initial state
            List<BucketAction> newPath = List.from(path)..add(action);
            queue.add(newPath);
          }
        }
      }
    }

    // If the loop completes without finding a solution, indicate that no solution was found
    emit(state.copyWith(solutionSteps: [], solutionNotFound: true));
  }
}
