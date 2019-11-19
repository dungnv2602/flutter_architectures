import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_firestore_todos/models/models.dart';

import './tab.dart';

class TabBloc extends Bloc<TabEvent, AppTab> {
  @override
  AppTab get initialState => AppTab.todos;

  @override
  Stream<AppTab> mapEventToState(
    TabEvent event,
  ) async* {
    if (event is UpdateTab) {
      yield event.tab;
    }
  }
}
