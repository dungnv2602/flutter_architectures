import 'package:bloc_firestore_todos/blocs/blocs.dart';
import 'package:firestore_todos_repository/firestore_todos_repository.dart';
import 'package:test/test.dart';

void main() {
  group('TodosState', () {
    group('TodosLoading', () {
      test('toString returns correct value', () {
        expect(TodosLoading().toString(), 'TodosLoading');
      });
    });
    group('TodosLoaded', () {
      test('toString returns correct value', () {
        expect(
          TodosLoaded([Todo('washing', id: '1')]).toString(),
          'TodosLoaded { todos: [${Todo("washing", id: "1")}] }',
        );
      });
    });
    group('TodosLoadedError', () {
      test('toString returns correct value', () {
        expect(
          TodosLoadedError('load error').toString(),
          'TodosLoadedError { msg: load error }',
        );
      });
    });
  });
}
