import 'package:flutter/widgets.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Future<dynamic> pushNamed({@required String route, dynamic arguments}) =>
    navigatorKey.currentState.pushNamed(route, arguments: arguments);

Future<dynamic> pushReplacementNamed({@required String route, dynamic arguments}) =>
    navigatorKey.currentState.pushReplacementNamed(route, arguments: arguments);

Future<dynamic> pushNamedAndRemoveUntil({@required String route, @required String untilRoute, dynamic arguments}) {
  return navigatorKey.currentState
      .pushNamedAndRemoveUntil(route, ModalRoute.withName(untilRoute), arguments: arguments);
}

bool pop() => navigatorKey.currentState.pop();

void popUntil(String route) => navigatorKey.currentState.popUntil(ModalRoute.withName(route));
