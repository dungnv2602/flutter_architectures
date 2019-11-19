import 'package:bloc_firestore_todos/blocs/blocs.dart';
import 'package:bloc_firestore_todos/models/models.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:firestore_todos_repository/firestore_todos_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todos_repository_simple/todos_repository_simple.dart';

class MockTodosBloc extends MockBloc<TodosEvent, TodosState>
    implements TodosBloc {}

class MockTodosRepository extends Mock implements TodosRepositoryFlutter {}

void main() {
  group('FilteredTodosBloc', () {
    final todos = [Todo('Wash Dishes', id: '0')];
    final todosLoaded = TodosLoaded(todos);
    blocTest<FilteredTodosBloc, FilteredTodosEvent, FilteredTodosState>(
      'adds TodosUpdated when TodosBloc.state emits TodosLoaded',
      build: () {
        final todosBloc = MockTodosBloc();
        when(todosBloc.state).thenReturn(todosLoaded);
        whenListen(
          todosBloc,
          Stream<TodosState>.fromIterable([todosLoaded]),
        );
        return FilteredTodosBloc(todosBloc);
      },
      expect: [
        FilteredTodosLoading(),
        FilteredTodosLoaded(todos, VisibilityFilter.all),
      ],
    );
    blocTest<FilteredTodosBloc, FilteredTodosEvent, FilteredTodosState>(
      'should update visibility filter when filter is inCompleted',
      build: () {
        final todosBloc = MockTodosBloc();
        when(todosBloc.state).thenReturn(todosLoaded);
        return FilteredTodosBloc(todosBloc);
      },
      act: (bloc) async => bloc.add(UpdateFilter(VisibilityFilter.inCompleted)),
      expect: [
        FilteredTodosLoaded(todos, VisibilityFilter.all),
        FilteredTodosLoading(),
        FilteredTodosLoaded(todos, VisibilityFilter.inCompleted),
      ],
    );
    blocTest<FilteredTodosBloc, FilteredTodosEvent, FilteredTodosState>(
      'should update visibility filter when filter is completed',
      build: () {
        final todosBloc = MockTodosBloc();
        when(todosBloc.state).thenReturn(todosLoaded);
        return FilteredTodosBloc(todosBloc);
      },
      act: (bloc) async => bloc.add(UpdateFilter(VisibilityFilter.completed)),
      expect: [
        FilteredTodosLoaded(todos, VisibilityFilter.all),
        FilteredTodosLoading(),
        FilteredTodosLoaded([], VisibilityFilter.completed),
      ],
    );
  });
}
