import 'package:bloc_firestore_todos/localization.dart';
import 'package:bloc_firestore_todos/models/models.dart';
import 'package:bloc_firestore_todos/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todos_app_core/todos_app_core.dart';

void main() {
  group('AddEditScreen', () {
    testWidgets('should render properly when isEditing: true', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: AddEditScreen(
            isEditing: true,
            onSave: (_, __) {},
            todo: Todo('wash dishes', id: '0'),
          ),
        ),
        localizationsDelegates: [
          ArchSampleLocalizationsDelegate(),
          FlutterBlocLocalizationsDelegate(),
        ],
      ));

      await tester.pumpAndSettle();
      expect(find.text('Edit Todo'), findsOneWidget);
      expect(find.text('wash dishes'), findsOneWidget);
      expect(find.byKey(ArchSampleKeys.saveTodoFab), findsOneWidget);
    });
    testWidgets('should render properly when isEditing: false',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AddEditScreen(
              isEditing: false,
              onSave: (_, __) {},
            ),
          ),
          localizationsDelegates: [
            ArchSampleLocalizationsDelegate(),
            FlutterBlocLocalizationsDelegate(),
          ],
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Add Todo'), findsOneWidget);
      expect(find.byKey(ArchSampleKeys.saveNewTodo), findsOneWidget);
    });
    testWidgets('should call onSave when Floating Action Button is tapped',
        (WidgetTester tester) async {
      var onSavePressed = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AddEditScreen(
              isEditing: true,
              onSave: (_, __) {
                onSavePressed = true;
              },
              todo: Todo('wash dishes'),
            ),
          ),
          localizationsDelegates: [
            ArchSampleLocalizationsDelegate(),
            FlutterBlocLocalizationsDelegate(),
          ],
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(ArchSampleKeys.saveTodoFab));
      expect(onSavePressed, true);
    });
    testWidgets('should call show error if task name is empty',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AddEditScreen(
              isEditing: true,
              onSave: (_, __) {},
              todo: Todo('wash dishes'),
            ),
          ),
          localizationsDelegates: [
            ArchSampleLocalizationsDelegate(),
            FlutterBlocLocalizationsDelegate(),
          ],
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(ArchSampleKeys.taskField));
      await tester.enterText(find.byKey(ArchSampleKeys.taskField), '');
      await tester.tap(find.byKey(ArchSampleKeys.saveTodoFab));
      await tester.pump();
      expect(find.text('Please enter some text'), findsOneWidget);
    });
  });
}
