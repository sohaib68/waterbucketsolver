part of 'waterbucket_solver_cubit.dart';

class WaterBucketSolverState extends Equatable {
  const WaterBucketSolverState({
    this.solutionSteps = const [],
    this.isSolutionFound = false,
    this.status = FormzStatus.pure,
    this.errorMessage,
    this.filter,
  });

  final List<Map<String, String>> solutionSteps;
  final bool isSolutionFound;
  final FormzStatus status;
  final String? errorMessage;
  final String? filter;

  @override
  List<Object?> get props => [solutionSteps, isSolutionFound, status, errorMessage, filter];

  WaterBucketSolverState copyWith({
    List<Map<String, String>>? solutionSteps,
    bool? isSolutionFound,
    FormzStatus? status,
    String? errorMessage,
    String? filter,
  }) {
    return WaterBucketSolverState(
      solutionSteps: solutionSteps ?? this.solutionSteps,
      isSolutionFound: isSolutionFound ?? this.isSolutionFound,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      filter: filter ?? this.filter,
    );
  }
}
