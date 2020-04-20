import 'package:flutter/material.dart';

import 'stoppable_service.dart';

class LocationService extends StoppableService {
  @override
  void start() {
    super.start();
    debugPrint('LocationService started $serviceStarted');
  }

  @override
  void stop() {
    super.stop();
    debugPrint('LocationService started $serviceStarted');
  }
}
