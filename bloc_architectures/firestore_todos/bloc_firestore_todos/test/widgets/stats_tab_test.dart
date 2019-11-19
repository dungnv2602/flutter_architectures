import 'package:bloc_firestore_todos/bloc_library_keys.dart';
import 'package:bloc_firestore_todos/blocs/blocs.dart';
import 'package:bloc_firestore_todos/localization.dart';
import 'package:bloc_firestore_todos/widgets/widgets.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todos_app_core/todos_app_core.dart';

class MockStatsBloc extends MockBloc<StatsEvent, StatsState>
    implements StatsBloc {}

void main() {
  group('Stats', () {
    StatsBloc statsBloc;
    setUp(() {
      statsBloc = MockStatsBloc();
    });

    testWidgets('should render LoadingIndicator when state is StatsLoading',
        (tester) async {
      when(statsBloc.state).thenAnswer((_) => StatsLoading());
      await tester.pumpWidget(BlocProvider.value(
        value: statsBloc,
        child: MaterialApp(
          home: Scaffold(
            body: Stats(),
          ),
          localizationsDelegates: [
            ArchSampleLocalizationsDelegate(),
            FlutterBlocLocalizationsDelegate(),
          ],
        ),
      ));
      await tester.pump(const Duration(seconds: 1));

      expect(find.byKey(BlocLibraryKeys.statsLoadingIndicator), findsOneWidget);
    });
    
    testWidgets('should render empty stats container when state is null',
        (WidgetTester tester) async {
      when(statsBloc.state).thenAnswer((_) => null);
      await tester.pumpWidget(
        BlocProvider.value(
          value: statsBloc,
          child: MaterialApp(
            home: Scaffold(
              body: Stats(),
            ),
            localizationsDelegates: [
              ArchSampleLocalizationsDelegate(),
              FlutterBlocLocalizationsDelegate(),
            ],
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byKey(BlocLibraryKeys.emptyStatsContainer), findsOneWidget);
    });

    testWidgets('should render correct stats when state is StatsLoaded(0,0)',
        (tester) async {
      when(statsBloc.state).thenAnswer((_) => StatsLoaded(0, 0));
      await tester.pumpWidget(
        BlocProvider.value(
          value: statsBloc,
          child: MaterialApp(
            home: Scaffold(
              body: Stats(),
            ),
            localizationsDelegates: [
              ArchSampleLocalizationsDelegate(),
              FlutterBlocLocalizationsDelegate(),
            ],
          ),
        ),
      );

      await tester.pumpAndSettle();
      final numInCompletedFinder = find.byKey(ArchSampleKeys.statsNumActive);
      final numCompletedFinder = find.byKey(ArchSampleKeys.statsNumCompleted);

      expect(numInCompletedFinder, findsOneWidget);
      expect((numInCompletedFinder.evaluate().first.widget as Text).data, '0');
      expect(numCompletedFinder, findsOneWidget);
      expect((numCompletedFinder.evaluate().first.widget as Text).data, '0');
    });

    testWidgets('should render correct stats when state is StatsLoaded(2, 1)',
        (WidgetTester tester) async {
      when(statsBloc.state).thenAnswer((_) => StatsLoaded(2, 1));
      await tester.pumpWidget(
        BlocProvider.value(
          value: statsBloc,
          child: MaterialApp(
            home: Scaffold(
              body: Stats(),
            ),
            localizationsDelegates: [
              ArchSampleLocalizationsDelegate(),
              FlutterBlocLocalizationsDelegate(),
            ],
          ),
        ),
      );
      await tester.pumpAndSettle();
      final numActiveFinder = find.byKey(ArchSampleKeys.statsNumActive);
      final numCompletedFinder = find.byKey(ArchSampleKeys.statsNumCompleted);

      expect(numActiveFinder, findsOneWidget);
      expect((numActiveFinder.evaluate().first.widget as Text).data, '2');
      expect(numCompletedFinder, findsOneWidget);
      expect((numCompletedFinder.evaluate().first.widget as Text).data, '1');
    });
  });
}
