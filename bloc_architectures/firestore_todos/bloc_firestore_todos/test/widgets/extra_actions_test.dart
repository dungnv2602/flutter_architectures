import 'package:bloc_firestore_todos/bloc_library_keys.dart';
import 'package:bloc_firestore_todos/blocs/blocs.dart';
import 'package:bloc_firestore_todos/localization.dart';
import 'package:bloc_firestore_todos/widgets/widgets.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:firestore_todos_repository/firestore_todos_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todos_app_core/todos_app_core.dart';

class MockTodosBloc extends MockBloc<TodosEvent, TodosState>
    implements TodosBloc {}

void main() {
  group('ExtraActions', () {
    TodosBloc todosBloc;

    setUp(() {
      todosBloc = MockTodosBloc();
    });

    testWidgets('renders an empty Container if state is not TodosLoaded',
        (tester) async {
      when(todosBloc.state).thenReturn(TodosLoading());

      await tester.pumpWidget(
        BlocProvider.value(
          value: todosBloc,
          child: MaterialApp(
            home: Scaffold(
              appBar: AppBar(
                actions: <Widget>[ExtraActions()],
              ),
              body: Container(),
            ),
          ),
        ),
      );

      expect(find.byKey((BlocLibraryKeys.extraActionsEmptyContainer)),
          findsOneWidget);
    });

    testWidgets(
        'renders PopupMenuButton with mark all done if state is TodosLoaded with incomplete todos',
        (tester) async {
      when(todosBloc.state).thenReturn(TodosLoaded([Todo('walk dog')]));

      await tester.pumpWidget(
        BlocProvider.value(
          value: todosBloc,
          child: MaterialApp(
            home: Scaffold(
              appBar: AppBar(
                actions: <Widget>[ExtraActions()],
              ),
              body: Container(),
            ),
            localizationsDelegates: [
              ArchSampleLocalizationsDelegate(),
              FlutterBlocLocalizationsDelegate(),
            ],
          ),
        ),
      );

      await tester.pumpAndSettle();
      await tester.tap(find.byKey(BlocLibraryKeys.extraActionsPopupMenuButton));
      await tester.pump();

      expect(find.byKey(ArchSampleKeys.toggleAll), findsOneWidget);
      expect(find.text('Clear completed'), findsOneWidget);
      expect(find.text('Mark all complete'), findsOneWidget);
    });

    testWidgets(
        'renders PopupMenuButton with mark all incomplete if state is TodosLoaded with complete todos',
        (WidgetTester tester) async {
      when(todosBloc.state)
          .thenReturn(TodosLoaded([Todo('walk dog', complete: true)]));
      await tester.pumpWidget(
        BlocProvider.value(
          value: todosBloc,
          child: MaterialApp(
            home: Scaffold(
              appBar: AppBar(
                actions: [ExtraActions()],
              ),
              body: Container(),
            ),
            localizationsDelegates: [
              ArchSampleLocalizationsDelegate(),
              FlutterBlocLocalizationsDelegate(),
            ],
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(BlocLibraryKeys.extraActionsPopupMenuButton));
      await tester.pump();
      expect(find.byKey(ArchSampleKeys.toggleAll), findsOneWidget);
      expect(find.text('Clear completed'), findsOneWidget);
      expect(find.text('Mark all incomplete'), findsOneWidget);
    });

    testWidgets('tapping clear completed add ClearCompleted event',
        (tester) async {
      when(todosBloc.state).thenReturn(TodosLoaded([
        Todo('walk dog'),
        Todo('take ou trash', complete: true),
      ]));

      when(todosBloc.add(ClearCompleted())).thenReturn(null);

      await tester.pumpWidget(
        BlocProvider.value(
          value: todosBloc,
          child: MaterialApp(
            home: Scaffold(
              appBar: AppBar(
                actions: <Widget>[ExtraActions()],
              ),
              body: Container(),
            ),
            localizationsDelegates: [
              ArchSampleLocalizationsDelegate(),
              FlutterBlocLocalizationsDelegate(),
            ],
          ),
        ),
      );

      await tester.pumpAndSettle();
      await tester.tap(find.byKey(BlocLibraryKeys.extraActionsPopupMenuButton));
      await tester.pump();
      expect(find.byKey(ArchSampleKeys.clearCompleted), findsOneWidget);
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(ArchSampleKeys.clearCompleted));
      verify(todosBloc.add(ClearCompleted())).called(1);
    });

    testWidgets('tapping toggle all adds ToggleAll',
        (WidgetTester tester) async {
      when(todosBloc.state).thenReturn(TodosLoaded([
        Todo('walk dog'),
        Todo('take out trash'),
      ]));
      when(todosBloc.add(ToggleAll())).thenReturn(null);
      await tester.pumpWidget(
        BlocProvider.value(
          value: todosBloc,
          child: MaterialApp(
            home: Scaffold(
              appBar: AppBar(
                actions: [ExtraActions()],
              ),
              body: Container(),
            ),
            localizationsDelegates: [
              ArchSampleLocalizationsDelegate(),
              FlutterBlocLocalizationsDelegate(),
            ],
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(BlocLibraryKeys.extraActionsPopupMenuButton));
      await tester.pump();
      expect(find.byKey(ArchSampleKeys.toggleAll), findsOneWidget);
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(ArchSampleKeys.toggleAll));
      verify(todosBloc.add(ToggleAll())).called(1);
    });
  });
}
