import 'package:flutter/material.dart';
import 'stoppable_service.dart';

class BackgroundService extends StoppableService {
  @override
  void start() {
    super.start();
    debugPrint('BackgroundService started $serviceStarted');
  }

  @override
  void stop() {
    super.stop();
    debugPrint('BackgroundService started $serviceStarted');
  }
}
