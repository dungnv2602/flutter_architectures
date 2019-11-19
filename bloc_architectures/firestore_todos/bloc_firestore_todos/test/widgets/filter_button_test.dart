import 'package:bloc_firestore_todos/blocs/blocs.dart';
import 'package:bloc_firestore_todos/localization.dart';
import 'package:bloc_firestore_todos/models/models.dart';
import 'package:bloc_firestore_todos/widgets/widgets.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todos_app_core/todos_app_core.dart';

class MockFilteredTodosBloc
    extends MockBloc<FilteredTodosEvent, FilteredTodosState>
    implements FilteredTodosBloc {}

void main() {
  group('FilterButton', () {
    FilteredTodosBloc filteredTodosBloc;

    setUp(() {
      filteredTodosBloc = MockFilteredTodosBloc();
    });

    testWidgets('should render properly with Visibility.all', (tester) async {
      when(filteredTodosBloc.state)
          .thenAnswer((_) => FilteredTodosLoaded([], VisibilityFilter.all));
      await tester.pumpWidget(
        BlocProvider.value(
          value: filteredTodosBloc,
          child: MaterialApp(
            home: Scaffold(
              body: Container(),
              appBar: AppBar(
                actions: <Widget>[
                  FilterButton(
                    visible: true,
                  )
                ],
              ),
            ),
            localizationsDelegates: [
              ArchSampleLocalizationsDelegate(),
              FlutterBlocLocalizationsDelegate(),
            ],
          ),
        ),
      );
      await tester.pumpAndSettle();
      Finder filterButtonFinder = find.byKey(ArchSampleKeys.filterButton);
      expect(filterButtonFinder, findsOneWidget);
      await tester.tap(filterButtonFinder);
      await tester.pumpAndSettle();
      expect(find.byKey(ArchSampleKeys.allFilter), findsOneWidget);
      expect(find.byKey(ArchSampleKeys.activeFilter), findsOneWidget);
    });

    testWidgets('should render properly VisibilityFilter.inCompleted',
        (WidgetTester tester) async {
      when(filteredTodosBloc.state).thenAnswer(
        (_) => FilteredTodosLoaded([], VisibilityFilter.inCompleted),
      );
      await tester.pumpWidget(
        BlocProvider.value(
          value: filteredTodosBloc,
          child: MaterialApp(
            home: Scaffold(
              appBar: AppBar(
                actions: [FilterButton(visible: true)],
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
      Finder filterButtonFinder = find.byKey(ArchSampleKeys.filterButton);
      expect(filterButtonFinder, findsOneWidget);
      await tester.tap(filterButtonFinder);
      await tester.pumpAndSettle();
      expect(find.byKey(ArchSampleKeys.allFilter), findsOneWidget);
      expect(find.byKey(ArchSampleKeys.activeFilter), findsOneWidget);
    });

    testWidgets('should render properly VisibilityFilter.completed',
        (WidgetTester tester) async {
      when(filteredTodosBloc.state).thenAnswer(
        (_) => FilteredTodosLoaded([], VisibilityFilter.completed),
      );
      await tester.pumpWidget(
        BlocProvider.value(
          value: filteredTodosBloc,
          child: MaterialApp(
            home: Scaffold(
              appBar: AppBar(
                actions: [FilterButton(visible: true)],
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
      Finder filterButtonFinder = find.byKey(ArchSampleKeys.filterButton);
      expect(filterButtonFinder, findsOneWidget);
      await tester.tap(filterButtonFinder);
      await tester.pumpAndSettle();
      expect(find.byKey(ArchSampleKeys.allFilter), findsOneWidget);
      expect(find.byKey(ArchSampleKeys.activeFilter), findsOneWidget);
    });

    testWidgets('should add UpdateFilter when filter selected', (tester) async {
      when(filteredTodosBloc.state)
          .thenAnswer((_) => FilteredTodosLoaded([], VisibilityFilter.all));

      when(filteredTodosBloc.add(UpdateFilter(VisibilityFilter.all)))
          .thenReturn(null);

      await tester.pumpWidget(BlocProvider.value(
        value: filteredTodosBloc,
        child: MaterialApp(
          home: Scaffold(
            appBar: AppBar(
              actions: <Widget>[FilterButton(visible: true)],
            ),
            body: Container(),
          ),
          localizationsDelegates: [
            ArchSampleLocalizationsDelegate(),
            FlutterBlocLocalizationsDelegate(),
          ],
        ),
      ));
      await tester.pumpAndSettle();

      Finder filterButtonFinder = find.byKey(ArchSampleKeys.filterButton);
      Finder activeFilterFinder = find.byKey(ArchSampleKeys.activeFilter);
      Finder allFilterFinder = find.byKey(ArchSampleKeys.allFilter);

      expect(filterButtonFinder, findsOneWidget);
      await tester.tap(filterButtonFinder);
      await tester.pumpAndSettle();
      expect(activeFilterFinder, findsOneWidget);
      expect(allFilterFinder, findsOneWidget);
      await tester.tap(allFilterFinder);
      verify(filteredTodosBloc.add(UpdateFilter(VisibilityFilter.all)))
          .called(1);
    });
  });
}
