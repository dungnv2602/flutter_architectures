import 'package:flutter/widgets.dart';

class BaseNotifier extends ChangeNotifier {
  bool _isBusy = false;

  bool get isBusy => _isBusy;

  busy(bool value) {
    _isBusy = value;
    notifyListeners();
  }
}
