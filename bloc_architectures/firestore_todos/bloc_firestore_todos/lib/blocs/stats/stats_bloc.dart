import 'dart:async';

import 'package:bloc/bloc.dart';

import './stats.dart';
import '../todos/todos.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  final TodosBloc todosBloc;
  StreamSubscription todosSubscription;

  StatsBloc(this.todosBloc) {
    todosSubscription = todosBloc.listen((state) {
      if (state is TodosLoaded) {
        add(UpdateStats(state.todos));
      }
    });
  }

  @override
  StatsState get initialState => StatsLoading();

  @override
  Stream<StatsState> mapEventToState(
    StatsEvent event,
  ) async* {
    if (event is UpdateStats) {
      yield StatsLoading();
      final numInCompleted =
          event.todos.where((todo) => !todo.complete).toList().length;
      final numCompleted =
          event.todos.where((todo) => todo.complete).toList().length;
      yield StatsLoaded(numInCompleted, numCompleted);
    }
  }

  @override
  Future<void> close() {
    todosSubscription?.cancel();
    return super.close();
  }
}
