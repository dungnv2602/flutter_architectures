import 'package:flutter/material.dart';
import 'package:provider_arc/locator.dart';
import 'package:provider_arc/provider/setup.dart';
import 'package:provider_arc/ui/managers/life_cycle_manager.dart';
import 'package:provider_arc/ui/routing/router.dart';

import 'package:provider/provider.dart';

import 'ui/routing/global_navigator.dart';

void main() {
  // setup service locator
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: LifeCycleManager(
        child: MaterialApp(
          title: 'Flutter Demo',
          navigatorKey: navigatorKey,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: RoutePaths.login,
          onGenerateRoute: Router.generateRoute,
        ),
      ),
    );
  }
}
