import 'package:bloc_firestore_todos/widgets/widgets.dart';
import 'package:firestore_todos_repository/firestore_todos_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todos_app_core/todos_app_core.dart';

void main() {
  group('DeleteTodoSnackBar', () {
    testWidgets('should render correctly', (WidgetTester tester) async {
      final snackBarKey = Key('snack_bar_key');
      final tapTarget = Key('tag_target_key');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return GestureDetector(
                  onTap: () {
                    Scaffold.of(context).showSnackBar(
                      DeleteTodoSnackBar(
                        key: snackBarKey,
                        onUndo: () {},
                        localizations: ArchSampleLocalizations(Locale('en')),
                        todo: Todo('hello'),
                      ),
                    );
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    key: tapTarget,
                    width: 100,
                    height: 100,
                  ),
                );
              },
            ),
          ),
        ),
      );

      Finder snackBarFinder = find.byKey(snackBarKey);
      Finder tapTargetFinder = find.byKey(tapTarget);

      await tester.tap(tapTargetFinder);
      await tester.pump();

      expect(snackBarFinder, findsOneWidget);
      expect(
          ((snackBarFinder.evaluate().first.widget as SnackBar).content as Text)
              .data,
          'Deleted "hello"');
      expect(find.text('Undo'), findsOneWidget);
    });

    testWidgets('should call onUndo when undo tapped',
        (WidgetTester tester) async {
      int tapCount = 0;
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Builder(builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {
                Scaffold.of(context).showSnackBar(DeleteTodoSnackBar(
                  onUndo: () {
                    ++tapCount;
                  },
                  localizations: ArchSampleLocalizations(Locale('en')),
                  todo: Todo('take out trash'),
                ));
              },
              child: const Text('X'),
            );
          }),
        ),
      ));
      await tester.tap(find.text('X'));
      await tester.pump(); // start animation
      await tester.pump(const Duration(milliseconds: 750));

      expect(tapCount, equals(0));
      await tester.tap(find.text('Undo'));
      expect(tapCount, equals(1));
    });
  });
}
