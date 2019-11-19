import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todos_app_core/todos_app_core.dart';
import 'package:todos_repository_simple/todos_repository_simple.dart';

import 'blocs/blocs.dart';
import 'blocs/simple_bloc_delegate.dart';
import 'localization.dart';
import 'models/models.dart';
import 'screens/screens.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(
    BlocProvider<TodosBloc>(
      builder: (context) {
        return TodosBloc(
          const TodosRepositoryFlutter(
            fileStorage: const FileStorage(
              '__flutter_bloc_app__',
              getApplicationDocumentsDirectory,
            ),
          ),
        )..add(LoadTodos());
      },
      child: TodosApp(),
    ),
  );
}

class TodosApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: FlutterBlocLocalizations().appTitle,
      theme: ArchSampleTheme.theme,
      localizationsDelegates: [
        ArchSampleLocalizationsDelegate(),
        FlutterBlocLocalizationsDelegate(),
      ],
      routes: {
        ArchSampleRoutes.home: (context) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<TabBloc>(
                builder: (context) => TabBloc(),
              ),
              BlocProvider<FilteredTodosBloc>(
                builder: (context) => FilteredTodosBloc(
                  BlocProvider.of<TodosBloc>(context),
                ),
              ),
              BlocProvider<StatsBloc>(
                builder: (context) => StatsBloc(
                  BlocProvider.of<TodosBloc>(context),
                ),
              ),
            ],
            child: HomeScreen(),
          );
        },
        ArchSampleRoutes.addTodo: (context) {
          return AddEditScreen(
            key: ArchSampleKeys.addTodoScreen,
            onSave: (task, note) {
              BlocProvider.of<TodosBloc>(context).add(
                AddTodo(Todo(task, note: note)),
              );
            },
            isEditing: false,
          );
        },
      },
    );
  }
}
