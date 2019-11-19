import 'package:bloc_firestore_todos/blocs/blocs.dart';
import 'package:bloc_firestore_todos/models/models.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:test/test.dart';

void main() {
  group('TabBloc', () {
    blocTest<TabBloc, TabEvent, AppTab>(
      'should update the AppTab',
      build: () => TabBloc(),
      act: (TabBloc bloc) async => bloc.add(UpdateTab(AppTab.stats)),
      expect: <AppTab>[
        AppTab.todos,
        AppTab.stats,
      ],
    );
  });
}
