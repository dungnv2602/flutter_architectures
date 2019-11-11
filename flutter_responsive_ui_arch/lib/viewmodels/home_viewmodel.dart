import 'package:flutter/widgets.dart';

enum HomeViewModelState { uninitialized, initializing, initialized }

class HomeViewModel extends ChangeNotifier {
  HomeViewModelState _state = HomeViewModelState.uninitialized;
  int _counter = 0;

  HomeViewModelState get state => _state;

  void initialise() {
    _state = HomeViewModelState.initialized;
    notifyListeners();
  }

  void increment() {
    _counter++;
    notifyListeners();
  }

  int get counter => _counter;
}
