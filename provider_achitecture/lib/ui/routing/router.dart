import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:provider_arc/core/models/post.dart';
import 'package:provider_arc/ui/managers/dialog_manager.dart';
import 'package:provider_arc/ui/views/mock_posts_view.dart';
import 'package:provider_arc/ui/views/home_view.dart';
import 'package:provider_arc/ui/views/login_view.dart';
import 'package:provider_arc/ui/views/post_view.dart';

class RoutePaths {
  static const String login = '/login';
  static const String home = '/';
  static const String post = '/posts';
  static const String fakePosts = '/fake_posts';
}

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, _, __) {
        switch (settings.name) {
          case RoutePaths.home:
            return HomeView();
          case RoutePaths.login:
            return LoginView();
          case RoutePaths.fakePosts:
            return MockPostsView();
          case RoutePaths.post:
            var post = settings.arguments as Post;
            return PostView(post: post);
          default:
            return Scaffold(
              body: Center(
                child: Text(
                  'No route defined for ${settings.name}',
                  style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, fontSize: 18.0),
                ),
              ),
            );
        }
      },
      transitionDuration: const Duration(milliseconds: 300),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return effectMap[PageTransitionType.slideParallaxLeft](
          Curves.easeInOut,
          animation,
          secondaryAnimation,
          DialogManager(child: child),
        );
      },
    );
  }
}

final RouteTransitionsBuilder _scaleTransitionsBuilder =
    (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
  return ScaleTransition(
    scale: new Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: animation,
        curve: Interval(
          0.00,
          0.50,
          curve: Curves.linear,
        ),
      ),
    ),
    child: ScaleTransition(
      scale: Tween<double>(
        begin: 1.5,
        end: 1.0,
      ).animate(
        CurvedAnimation(
          parent: animation,
          curve: Interval(
            0.50,
            1.00,
            curve: Curves.linear,
          ),
        ),
      ),
      child: child,
    ),
  );
};
