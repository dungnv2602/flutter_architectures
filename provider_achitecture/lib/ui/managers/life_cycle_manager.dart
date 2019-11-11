import 'package:flutter/material.dart';
import 'package:provider_arc/core/services/background_service.dart';
import 'package:provider_arc/core/services/location_service.dart';
import 'package:provider_arc/core/services/stoppable_service.dart';
import 'package:provider_arc/locator.dart';

class LifeCycleManager extends StatefulWidget {
  final Widget child;

  const LifeCycleManager({Key key, this.child}) : super(key: key);

  @override
  _LifeCycleManagerState createState() => _LifeCycleManagerState();
}

class _LifeCycleManagerState extends State<LifeCycleManager> with WidgetsBindingObserver {
  List<StoppableService> services = [
    locator<LocationService>(),
    locator<BackgroundService>(),
  ];

  @override
  void initState() {
    super.initState();
    // start service on init
    services.forEach((service) => service.start());
    // add observer
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    debugPrint('didChangeAppLifecycleState: $state');
    services.forEach((service) {
      // restart on resume app, else stop service
      state == AppLifecycleState.resumed ? service.start() : service.stop();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
