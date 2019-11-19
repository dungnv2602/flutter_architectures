import 'package:bloc_firestore_todos/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TodosState extends Equatable {
  const TodosState();
  @override
  List<Object> get props => [];
}

class TodosLoading extends TodosState {}

class TodosLoadedError extends TodosState {
  final String msg;
  const TodosLoadedError(this.msg);
  @override
  List<Object> get props => [msg];
  @override
  String toString() => 'TodosLoadedError { msg: $msg }';
}

class TodosLoaded extends TodosState {
  final List<Todo> todos;
  const TodosLoaded(this.todos);

  @override
  List<Object> get props => [todos];
  @override
  String toString() => 'TodosLoaded { todos: $todos }';
}
