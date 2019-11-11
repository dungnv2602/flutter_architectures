import 'package:flutter/cupertino.dart';

abstract class StoppableService {
  bool _serviceStarted = false;

  bool get serviceStarted => _serviceStarted;

  @mustCallSuper
  void stop() {
    _serviceStarted = false;
  }

  @mustCallSuper
  void start() {
    _serviceStarted = true;
  }
}
