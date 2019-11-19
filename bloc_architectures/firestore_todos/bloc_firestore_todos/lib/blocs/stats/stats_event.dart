import 'package:bloc_firestore_todos/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class StatsEvent extends Equatable {
  const StatsEvent();
}

class UpdateStats extends StatsEvent {
  final List<Todo> todos;

  const UpdateStats(this.todos);

  @override
  List<Object> get props => [todos];

  @override
  String toString() => 'UpdateStats { todos: $todos }';
}
