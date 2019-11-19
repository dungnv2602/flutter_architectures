import 'package:bloc_firestore_todos/blocs/blocs.dart';
import 'package:bloc_firestore_todos/localization.dart';
import 'package:bloc_firestore_todos/models/models.dart';
import 'package:bloc_firestore_todos/screens/add_edit_screen.dart';
import 'package:bloc_firestore_todos/screens/home_screen.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todos_app_core/todos_app_core.dart';

class MockTodosBloc extends MockBloc<TodosEvent, TodosState>
    implements TodosBloc {}

class MockFilteredTodosBloc
    extends MockBloc<FilteredTodosLoaded, FilteredTodosState>
    implements FilteredTodosBloc {}

class MockTabBloc extends MockBloc<TabEvent, AppTab> implements TabBloc {}

class MockStatsBloc extends MockBloc<StatsEvent, StatsState>
    implements StatsBloc {}

void main() {
  group('HomeScreen', () {
    TodosBloc todosBloc;
    FilteredTodosBloc filteredTodosBloc;
    TabBloc tabBloc;
    StatsBloc statsBloc;

    setUp(() {
      todosBloc = MockTodosBloc();
      filteredTodosBloc = MockFilteredTodosBloc();
      tabBloc = MockTabBloc();
      statsBloc = MockStatsBloc();
    });

    testWidgets('render correctly', (tester) async {
      when(todosBloc.state).thenAnswer((_) => TodosLoaded([]));
      when(tabBloc.state).thenAnswer((_) => AppTab.todos);

      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<TodosBloc>.value(value: todosBloc),
            BlocProvider<FilteredTodosBloc>.value(value: filteredTodosBloc),
            BlocProvider<TabBloc>.value(value: tabBloc),
            BlocProvider<StatsBloc>.value(value: statsBloc),
          ],
          child: MaterialApp(
            home: Scaffold(
              body: HomeScreen(),
            ),
            localizationsDelegates: [
              ArchSampleLocalizationsDelegate(),
              FlutterBlocLocalizationsDelegate(),
            ],
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.byKey(ArchSampleKeys.addTodoFab), findsOneWidget);
      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('Navigates to /addTodo when Floating Action Button is tapped',
        (tester) async {
      when(todosBloc.state).thenAnswer((_) => TodosLoaded([]));
      when(tabBloc.state).thenAnswer((_) => AppTab.todos);

      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<TodosBloc>.value(value: todosBloc),
            BlocProvider<FilteredTodosBloc>.value(value: filteredTodosBloc),
            BlocProvider<TabBloc>.value(value: tabBloc),
            BlocProvider<StatsBloc>.value(value: statsBloc),
          ],
          child: MaterialApp(
            home: Scaffold(
              body: HomeScreen(),
            ),
            localizationsDelegates: [
              ArchSampleLocalizationsDelegate(),
              FlutterBlocLocalizationsDelegate(),
            ],
            routes: {
              ArchSampleRoutes.addTodo: (context) {
                return AddEditScreen(
                  key: ArchSampleKeys.addTodoScreen,
                  onSave: (task, note) {},
                  isEditing: false,
                );
              },
            },
          ),
        ),
      );

      await tester.pumpAndSettle();
      await tester.tap(find.byKey(ArchSampleKeys.addTodoFab));
      await tester.pumpAndSettle();
      expect(find.byType(AddEditScreen), findsOneWidget);
    });
  });
}
