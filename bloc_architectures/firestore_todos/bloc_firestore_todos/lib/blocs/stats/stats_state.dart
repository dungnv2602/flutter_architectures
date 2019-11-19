import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class StatsState extends Equatable {
  const StatsState();

  @override
  List<Object> get props => [];
}

class StatsLoading extends StatsState {}

class StatsLoaded extends StatsState {
  final int numInCompleted;
  final int numCompleted;

  const StatsLoaded(this.numInCompleted, this.numCompleted);

  @override
  List<Object> get props => [numInCompleted, numCompleted];

  @override
  String toString() {
    return 'StatsLoaded { numInCompleted: $numInCompleted, numCompleted: $numCompleted }';
  }
}
