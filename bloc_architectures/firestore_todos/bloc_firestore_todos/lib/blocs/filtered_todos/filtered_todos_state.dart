import 'package:bloc_firestore_todos/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class FilteredTodosState extends Equatable {
  const FilteredTodosState();
  @override
  List<Object> get props => [];
}

class FilteredTodosLoading extends FilteredTodosState {}

class FilteredTodosLoaded extends FilteredTodosState {
  final List<Todo> filteredTodos;
  final VisibilityFilter filter;

  const FilteredTodosLoaded(this.filteredTodos, this.filter);

  @override
  List<Object> get props => [filteredTodos, filter];

  @override
  String toString() {
    return 'FilteredTodosLoaded { filteredTodos: $filteredTodos, filter: $filter }';
  }
}
