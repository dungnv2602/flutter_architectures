import 'package:bloc_firestore_todos/blocs/blocs.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:firestore_todos_repository/firestore_todos_repository.dart';
import 'package:flutter_test/flutter_test.dart';

class MockTodosBloc extends MockBloc<TodosEvent, TodosState>
    implements TodosBloc {}

void main() {
  group('StatsBloc', () {
    final todo1 = Todo('Hello');
    final todo2 = Todo('Hello', complete: true);
    final todos = [todo1, todo2];
    final todosLoaded = TodosLoaded(todos);

    TodosBloc todosBloc;
    StatsBloc statsBloc;

    setUp(() {
      todosBloc = MockTodosBloc();
      statsBloc = StatsBloc(todosBloc);
    });

    blocTest(
      'should update the stats properly when TodosBloc emit TodosLoaded',
      build: () {
        todosBloc = MockTodosBloc();
        whenListen(todosBloc, Stream<TodosState>.fromIterable([todosLoaded]));
        return StatsBloc(todosBloc);
      },
      expect: [
        StatsLoading(),
        StatsLoaded(1, 1),
      ],
    );
    blocTest<StatsBloc, StatsEvent, StatsState>(
      'should update the stats properly when Todos are empty',
      build: () => statsBloc,
      act: (StatsBloc bloc) async => bloc.add(UpdateStats([])),
      expect: <StatsState>[
        StatsLoading(),
        StatsLoaded(0, 0),
      ],
    );
    blocTest<StatsBloc, StatsEvent, StatsState>(
      'should update the stats properly when Todos contains one active todo',
      build: () => statsBloc,
      act: (StatsBloc bloc) async => bloc.add(UpdateStats([todo1])),
      expect: <StatsState>[
        StatsLoading(),
        StatsLoaded(1, 0),
      ],
    );

    blocTest<StatsBloc, StatsEvent, StatsState>(
      'should update the stats properly when Todos contains one active todo and one completed todo',
      build: () => statsBloc,
      act: (StatsBloc bloc) async => bloc.add(UpdateStats(todos)),
      expect: <StatsState>[
        StatsLoading(),
        StatsLoaded(1, 1),
      ],
    );
  });
}
