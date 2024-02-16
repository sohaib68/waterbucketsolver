class BucketState {
  int x, y;

  BucketState(this.x, this.y);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BucketState && runtimeType == other.runtimeType && x == other.x && y == other.y;

  @override
  int get hashCode => x.hashCode ^ y.hashCode;
}

class BucketAction {
  final BucketState state;
  final String explanation;

  BucketAction(this.state, this.explanation);
}
