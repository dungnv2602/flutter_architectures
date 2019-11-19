import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_firestore_todos/models/models.dart';
import 'package:firestore_todos_repository/firestore_todos_repository.dart';
import 'package:meta/meta.dart';

import '../todos/todos.dart';

class FirestoreTodosBloc extends Bloc<TodosEvent, TodosState> {
  final FirestoreTodosRepository _todosRepository;
  StreamSubscription _todosSubscription;

  FirestoreTodosBloc({@required FirestoreTodosRepository todosRepository})
      : assert(todosRepository != null),
        _todosRepository = todosRepository;

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
    if (event is UpdateTodos) {
      yield* _mapTodosUpdateToState(event);
    }
  }

  @override
  TodosState get initialState => TodosLoading();
  Stream<TodosState> _mapLoadTodosToState() async* {
    _todosSubscription?.cancel();
    _todosSubscription = _todosRepository.todos().listen(
          (todos) => add(UpdateTodos(todos)),
        );
  }

  Stream<TodosState> _mapAddTodoToState(AddTodo event) async* {
    _todosRepository.addNewTodo(event.todo);
  }

  Stream<TodosState> _mapUpdateTodoToState(UpdateTodo event) async* {
    _todosRepository.updateTodo(event.updatedTodo);
  }

  Stream<TodosState> _mapDeleteTodoToState(DeleteTodo event) async* {
    _todosRepository.deleteTodo(event.todo);
  }

  Stream<TodosState> _mapToggleAllToState() async* {
    final currentState = state;
    if (currentState is TodosLoaded) {
      final allComplete = currentState.todos.every((todo) => todo.complete);
      final List<Todo> updatedTodos = currentState.todos
          .map((todo) => todo.copyWith(complete: !allComplete))
          .toList();
      updatedTodos.forEach((updatedTodo) {
        _todosRepository.updateTodo(updatedTodo);
      });
    }
  }

  Stream<TodosState> _mapClearCompletedToState() async* {
    final currentState = state;
    if (currentState is TodosLoaded) {
      final List<Todo> completedTodos =
          currentState.todos.where((todo) => todo.complete).toList();
      completedTodos.forEach((completedTodo) {
        _todosRepository.deleteTodo(completedTodo);
      });
    }
  }

  Stream<TodosState> _mapTodosUpdateToState(UpdateTodos event) async* {
    yield TodosLoaded(event.todos);
  }

  @override
  Future<void> close() {
    _todosSubscription?.cancel();
    return super.close();
  }
}
