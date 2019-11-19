import './blocs/filtered_todos/filtered_todos_bloc_test.dart'
    as filteredTodosBloc;
import './blocs/filtered_todos/filtered_todos_event_test.dart'
    as filteredTodosEvent;
import './blocs/simple_bloc_delegate_test.dart' as simpleBlocDelegate;
import './blocs/tab/tab_bloc_test.dart' as tabBloc;
import './blocs/tab/tab_event_test.dart' as tabEvent;
import './blocs/todos/todos_bloc_test.dart' as todosBloc;
import './blocs/todos/todos_event_test.dart' as todosEvent;
import './blocs/todos/todos_state_test.dart' as todosState;
import './localization_test.dart' as localization;
import './models/todo_test.dart' as todo;
import './screens//add_edit_screen_test.dart' as addEditScreen;
import './screens/details_screen_test.dart' as detailsScreen;
import './screens/home_screen_test.dart' as homeScreen;
import './widgets/delete_todo_snack_bar_test.dart' as deleteTodoSnackbar;
import './widgets/extra_actions_test.dart' as extraActions;
import './widgets/filter_button_test.dart' as filterButton;
import './widgets/filtered_todos_test.dart' as filteredTodos;
import './widgets/loading_indicator_test.dart' as loadingIndicator;
import './widgets/stats_tab_test.dart' as statsTab;
import './widgets/tab_selector_test.dart' as tabSelector;
import './widgets/todo_item_test.dart' as todoItem;

void main() {
  // Blocs
  filteredTodosBloc.main();
  filteredTodosEvent.main();
  simpleBlocDelegate.main();
  tabBloc.main();
  tabEvent.main();
  todosBloc.main();
  todosEvent.main();
  todosState.main();

  // Models
  todo.main();

  // Screens
  addEditScreen.main();
  detailsScreen.main();
  homeScreen.main();

  // Widgets
  deleteTodoSnackbar.main();
  extraActions.main();
  filterButton.main();
  filteredTodos.main();
  loadingIndicator.main();
  statsTab.main();
  tabSelector.main();
  todoItem.main();

  // Localization
  localization.main();
}
