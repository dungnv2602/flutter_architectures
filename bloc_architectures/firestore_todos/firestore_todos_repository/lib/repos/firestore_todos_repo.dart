import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todos_repository_core/todos_repository_core.dart';

import '../models/models.dart';

class FirestoreTodosRepository {
  final todoCollection = Firestore.instance.collection('todos');

  Future<void> addNewTodo(Todo todo) {
    return todoCollection.add(todo.toEntity().toJson());
  }

  Future<void> deleteTodo(Todo todo) async {
    return todoCollection.document(todo.id).delete();
  }

  Stream<List<Todo>> todos() {
    return todoCollection.snapshots().map((snapshot) {
      return snapshot.documents
          .map((doc) => Todo.fromEntity(TodoEntity.fromJson(doc.data)))
          .toList();
    });
  }

  Future<void> updateTodo(Todo update) {
    return todoCollection
        .document(update.id)
        .updateData(update.toEntity().toJson());
  }
}
