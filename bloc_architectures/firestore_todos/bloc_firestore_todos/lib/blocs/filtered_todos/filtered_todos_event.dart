import 'package:bloc_firestore_todos/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class FilteredTodosEvent extends Equatable {
  const FilteredTodosEvent();
}

class UpdateFilter extends FilteredTodosEvent {
  const UpdateFilter(this.filter);

  final VisibilityFilter filter;

  @override
  List<Object> get props => [filter];

  @override
  String toString() => 'UpdateFilter { filter: $filter }';
}

class UpdateFilteredTodos extends FilteredTodosEvent {
  const UpdateFilteredTodos(this.todos);

  final List<Todo> todos;

  @override
  List<Object> get props => [todos];

  @override
  String toString() => 'UpdateTodos { todos: $todos }';
}
