import 'package:bloc_firestore_todos/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TodosEvent extends Equatable {
  const TodosEvent();
  @override
  List<Object> get props => [];
}

class LoadTodos extends TodosEvent {}

class ClearCompleted extends TodosEvent {}

class ToggleAll extends TodosEvent {}

class AddTodo extends TodosEvent {
  final Todo todo;

  const AddTodo(this.todo);

  @override
  List<Object> get props => [todo];

  @override
  String toString() => 'AddTodo { todo: $todo }';
}

class UpdateTodo extends TodosEvent {
  final Todo updatedTodo;

  const UpdateTodo(this.updatedTodo);

  @override
  List<Object> get props => [updatedTodo];

  @override
  String toString() => 'UpdateTodo { updatedTodo: $updatedTodo }';
}

class UpdateTodos extends TodosEvent {
  final List<Todo> todos;

  const UpdateTodos(this.todos);

  @override
  List<Object> get props => [todos];

  @override
  String toString() => 'UpdateTodos { todos: $todos }';
}

class DeleteTodo extends TodosEvent {
  final Todo todo;

  const DeleteTodo(this.todo);

  @override
  List<Object> get props => [todo];

  @override
  String toString() => 'DeleteTodo { todo: $todo }';
}
