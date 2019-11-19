import 'package:bloc_firestore_todos/localization.dart';
import 'package:bloc_firestore_todos/models/models.dart';
import 'package:bloc_firestore_todos/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todos_app_core/todos_app_core.dart';

void main() {
  group('TabSelector', () {
    testWidgets('should render properly', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Container(),
          bottomNavigationBar: TabSelector(
            onTabSelected: (_) => null,
            activeTab: AppTab.todos,
          ),
        ),
        localizationsDelegates: [
          ArchSampleLocalizationsDelegate(),
          FlutterBlocLocalizationsDelegate(),
        ],
      ));

      await tester.pumpAndSettle();
      expect(find.byKey(ArchSampleKeys.todoTab), findsOneWidget);
      expect(find.byKey(ArchSampleKeys.statsTab), findsOneWidget);
    });
    testWidgets('should call onTabSelected with correct index when tab tapped',
        (WidgetTester tester) async {
      AppTab selectedTab = AppTab.todos;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Container(),
            bottomNavigationBar: TabSelector(
              onTabSelected: (appTab) {
                selectedTab = appTab;
              },
              activeTab: selectedTab,
            ),
          ),
          localizationsDelegates: [
            ArchSampleLocalizationsDelegate(),
            FlutterBlocLocalizationsDelegate(),
          ],
        ),
      );
      await tester.pumpAndSettle();
      Finder todoTabFinder = find.byKey(ArchSampleKeys.todoTab);
      Finder statsTabFinder = find.byKey(ArchSampleKeys.statsTab);
      expect(todoTabFinder, findsOneWidget);
      expect(statsTabFinder, findsOneWidget);
      await tester.tap(todoTabFinder);
      expect(selectedTab, AppTab.todos);
      await tester.tap(statsTabFinder);
      expect(selectedTab, AppTab.stats);
    });
  });
}
