part of 'waterbucket_solver_cubit.dart';

class WaterBucketSolverState extends Equatable {
  const WaterBucketSolverState({
    this.solutionSteps = const [],
    this.solutionNotFound = false,
    age,
  });

  final List<Map<String, String>> solutionSteps;
  final bool solutionNotFound;

  @override
  List<Object?> get props => [solutionSteps, solutionNotFound];

  WaterBucketSolverState copyWith({
    List<Map<String, String>>? solutionSteps,
    bool? solutionNotFound,
    String? errorMessage,
    String? filter,
  }) {
    return WaterBucketSolverState(
      solutionSteps: solutionSteps ?? this.solutionSteps,
      solutionNotFound: solutionNotFound ?? this.solutionNotFound,
    );
  }
}
