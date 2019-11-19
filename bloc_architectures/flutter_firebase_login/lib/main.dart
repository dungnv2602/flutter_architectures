import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_login/login/login.dart';

import 'authen/authen.dart';
import 'repos/repos.dart';
import 'simple_bloc_delegate.dart';
import 'views/home_screen.dart';
import 'views/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final userRepo = UserRepositoryImpl();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<AuthenBloc>(
        builder: (context) => AuthenBloc(userRepo)..add(AppStarted()),
      ),
    ],
    child: MyApp(userRepo: userRepo),
  ));
}

class MyApp extends StatelessWidget {
  final UserRepository userRepo;

  const MyApp({Key key, @required this.userRepo})
      : assert(userRepo != null),
        super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocBuilder<AuthenBloc, AuthenState>(
        builder: (context, state) {
          if (state is Uninitialized) {
            return SplashScreen();
          }
          if (state is Unauthenticated) {
            return LoginScreen(userRepository: userRepo);
          }
          if (state is Authenticated) {
            return HomeScreen(name: state.user.displayName);
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
