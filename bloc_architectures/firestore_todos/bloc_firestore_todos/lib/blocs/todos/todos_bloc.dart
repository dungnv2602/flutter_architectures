import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_firestore_todos/models/models.dart';
import 'package:todos_repository_simple/todos_repository_simple.dart';

import 'todos.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  TodosBloc(this.todosRepo);

  final TodosRepositoryFlutter todosRepo;

  @override
  Stream<TodosState> mapEventToState(
    TodosEvent event,
  ) async* {
    if (event is LoadTodos) {
      yield* _mapLoadTodosToState();
    }
    if (event is AddTodo) {
      yield* _mapAddTodoToState(event);
    }
    if (event is UpdateTodo) {
      yield* _mapUpdateTodoToState(event);
    }
    if (event is DeleteTodo) {
      yield* _mapDeleteTodoToState(event);
    }
    if (event is ToggleAll) {
      yield* _mapToggleAllToState();
    }
    if (event is ClearCompleted) {
      yield* _mapClearCompletedToState();
    }
  }

  @override
  TodosState get initialState => TodosLoading();

  Stream<TodosState> _mapLoadTodosToState() async* {
    try {
      final todos = await todosRepo.loadTodos();
      yield TodosLoaded(todos.map<Todo>(Todo.fromEntity).toList());
    } catch (error) {
      yield TodosLoadedError(error.toString());
    }
  }

  Stream<TodosState> _mapAddTodoToState(AddTodo event) async* {
    if (state is TodosLoaded) {
      final updatedTodos = (state as TodosLoaded).todos..add(event.todo);
      yield TodosLoaded(updatedTodos);
      _saveTodos(updatedTodos);
    }
  }

  Stream<TodosState> _mapUpdateTodoToState(UpdateTodo event) async* {
    if (state is TodosLoaded) {
      final updatedTodos = (state as TodosLoaded).todos.map((todo) {
        return todo.id == event.updatedTodo.id ? event.updatedTodo : todo;
      }).toList();
      yield TodosLoaded(updatedTodos);
      _saveTodos(updatedTodos);
    }
  }

  Stream<TodosState> _mapDeleteTodoToState(DeleteTodo event) async* {
    if (state is TodosLoaded) {
      final updatedTodos = (state as TodosLoaded)
          .todos
          .where((todo) => todo.id != event.todo.id)
          .toList();
      yield TodosLoaded(updatedTodos);
      _saveTodos(updatedTodos);
    }
  }

  Stream<TodosState> _mapToggleAllToState() async* {
    if (state is TodosLoaded) {
      final bool allComplete =
          (state as TodosLoaded).todos.every((todo) => todo.complete);
      final updatedTodos = (state as TodosLoaded)
          .todos
          .map((todo) => todo.copyWith(complete: !allComplete));
      yield TodosLoaded(updatedTodos);
      _saveTodos(updatedTodos);
    }
  }

  Stream<TodosState> _mapClearCompletedToState() async* {
    if (state is TodosLoaded) {
      final updatedTodos =
          (state as TodosLoaded).todos.where((todo) => !todo.complete);
      yield TodosLoaded(updatedTodos);
      _saveTodos(updatedTodos);
    }
  }

  Future _saveTodos(List<Todo> todos) {
    return todosRepo.saveTodos(todos.map((todo) => todo.toEntity()).toList());
  }
}
