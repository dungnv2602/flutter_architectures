import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';
import 'todo.dart';

part 'todo_list.g.dart';

@JsonSerializable()
class TodoList = _TodoList with _$TodoList;

enum VisibilityFilter { ALL, PENDING, COMPLETED }

abstract class _TodoList with Store {
  @observable
  @_ObservableListJsonConverter()
  ObservableList<Todo> todos = ObservableList();

  @observable
  VisibilityFilter filter = VisibilityFilter.ALL;

  @observable
  String description = '';

  @computed
  ObservableList<Todo> get pendingTodos => ObservableList.of(todos.where((todo) => todo.done = false));

  @computed
  ObservableList<Todo> get completedTodos => ObservableList.of(todos.where((todo) => todo.done = true));

  @computed
  bool get hasCompletedTodos => completedTodos.isNotEmpty;

  @computed
  bool get hasPendingTodos => pendingTodos.isNotEmpty;

  @computed
  String get itemsDescription {
    if (todos.isEmpty) {
      return 'There are no Todos here. Why don\'t you add one?.';
    }
    final suffix = pendingTodos.length == 1 ? 'todo' : 'todos';
    return '${pendingTodos.length} pending $suffix, ${completedTodos.length} completed';
  }

  @computed
  ObservableList<Todo> get visibleTodos {
    switch (filter) {
      case VisibilityFilter.PENDING:
        return pendingTodos;
      case VisibilityFilter.COMPLETED:
        return completedTodos;
      default:
        return todos;
    }
  }

  @computed
  bool get canRemoveAllCompleted => hasCompletedTodos && filter != VisibilityFilter.PENDING;

  @computed
  bool get canMarkAllCompleted => hasPendingTodos && filter != VisibilityFilter.COMPLETED;

  @action
  void addTodo(String desc) {
    todos.add(Todo(desc));
    description = '';

    // Just a quick test of the JSON encode/decode
    final list = _$TodoListToJson(this);
    print(list);
    print(_$TodoListFromJson(list));
  }

  @action
  void removeTodo(Todo todo) => todos.removeWhere((x) => x == todo);

  @action
  void removeTodoAtIndex(int index) => todos.removeAt(index);

  @action
  void removeCompleted() => todos.removeWhere((todo) => todo.done);

  @action
  void markAllAsCompleted() {
    for (final todo in todos) {
      todo.done = true;
    }
  }
}

class _ObservableListJsonConverter implements JsonConverter<ObservableList<Todo>, List<Map<String, dynamic>>> {
  const _ObservableListJsonConverter();

  @override
  ObservableList<Todo> fromJson(List<Map<String, dynamic>> json) =>
      ObservableList.of(json.map((todo) => Todo.fromJson(todo)));

  @override
  List<Map<String, dynamic>> toJson(ObservableList<Todo> object) => object.map((todo) => todo.toJson());
}
