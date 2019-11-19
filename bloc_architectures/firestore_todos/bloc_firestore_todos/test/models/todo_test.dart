import 'package:firestore_todos_repository/firestore_todos_repository.dart';
import 'package:test/test.dart';
import 'package:todos_repository_core/todos_repository_core.dart';

void main() {
  group('Todo', () {
    test('is correctly generated from TodoEntity', () {
      expect(
        Todo.fromEntity(TodoEntity('task', 'id', 'note', true)),
        Todo('task', id: 'id', note: 'note', complete: true),
      );
    });
  });
}
