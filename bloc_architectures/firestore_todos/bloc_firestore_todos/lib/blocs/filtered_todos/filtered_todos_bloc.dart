import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_firestore_todos/blocs/todos/todos.dart';
import 'package:bloc_firestore_todos/models/models.dart';

import 'filtered_todos.dart';

class FilteredTodosBloc extends Bloc<FilteredTodosEvent, FilteredTodosState> {
  final TodosBloc todosBloc;
  StreamSubscription todosSubscription;

  FilteredTodosBloc(this.todosBloc) {
    todosSubscription = todosBloc.listen((state) {
      if (state is TodosLoaded) {
        add(UpdateFilteredTodos((todosBloc.state as TodosLoaded).todos));
      }
    });
  }
  @override
  FilteredTodosState get initialState {
    return todosBloc.state is TodosLoaded
        ? FilteredTodosLoaded(
            (todosBloc.state as TodosLoaded).todos,
            VisibilityFilter.all,
          )
        : FilteredTodosLoading();
  }

  @override
  Stream<FilteredTodosState> mapEventToState(
    FilteredTodosEvent event,
  ) async* {
    if (event is UpdateFilter) {
      yield* _mapUpdateFilterToState(event);
    }
    if (event is UpdateFilteredTodos) {
      yield* _mapUpdateFilteredTodosToState(event);
    }
  }

  Stream<FilteredTodosState> _mapUpdateFilterToState(
      UpdateFilter event) async* {
    if (todosBloc.state is TodosLoaded) {
      yield FilteredTodosLoading();
      yield FilteredTodosLoaded(
        _mapTodosToFilteredTodos(
            (todosBloc.state as TodosLoaded).todos, event.filter),
        event.filter,
      );
    }
  }

  Stream<FilteredTodosState> _mapUpdateFilteredTodosToState(
      UpdateFilteredTodos event) async* {
    final filter = state is FilteredTodosLoaded
        ? (state as FilteredTodosLoaded).filter
        : VisibilityFilter.all;
    yield FilteredTodosLoading();
    yield FilteredTodosLoaded(
      _mapTodosToFilteredTodos((todosBloc.state as TodosLoaded).todos, filter),
      filter,
    );
  }

  List<Todo> _mapTodosToFilteredTodos(
      List<Todo> todos, VisibilityFilter filter) {
    return todos.where((todo) {
      if (filter == VisibilityFilter.all) {
        return true;
      }
      if (filter == VisibilityFilter.inCompleted) {
        return !todo.complete;
      }
      return todo.complete;
    }).toList();
  }

  @override
  Future<void> close() {
    todosSubscription?.cancel();
    return super.close();
  }
}
