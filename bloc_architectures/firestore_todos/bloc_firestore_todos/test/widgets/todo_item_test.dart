import 'package:bloc_firestore_todos/localization.dart';
import 'package:bloc_firestore_todos/widgets/widgets.dart';
import 'package:firestore_todos_repository/firestore_todos_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todos_app_core/todos_app_core.dart';

void main() {
  group('TodoItem', () {
    testWidgets('should render properly with no note',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: TodoItem(
            onCheckboxChanged: (_) => null,
            onDismissed: (_) => null,
            onTap: () => null,
            todo: Todo('hello', id: '0'),
          ),
        ),
        localizationsDelegates: [
          ArchSampleLocalizationsDelegate(),
          FlutterBlocLocalizationsDelegate(),
        ],
      ));

      await tester.pumpAndSettle();
      expect(find.byKey(ArchSampleKeys.todoItem('0')), findsOneWidget);
      expect(find.text('hello'), findsOneWidget);
      expect(find.byKey(ArchSampleKeys.todoItemNote('0')), findsNothing);
    });
    testWidgets('should render properly with note',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TodoItem(
              onCheckboxChanged: (_) => null,
              onDismissed: (_) => null,
              onTap: () => null,
              todo: Todo('wash car', note: 'some note', id: '0'),
            ),
          ),
          localizationsDelegates: [
            ArchSampleLocalizationsDelegate(),
            FlutterBlocLocalizationsDelegate(),
          ],
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byKey(ArchSampleKeys.todoItem('0')), findsOneWidget);
      expect(find.text('wash car'), findsOneWidget);
      expect(find.byKey(ArchSampleKeys.todoItemNote('0')), findsOneWidget);
      expect(find.text('some note'), findsOneWidget);
    });
    testWidgets(
        'sould render properly with no note', (WidgetTester tester) async {});
  });
}
