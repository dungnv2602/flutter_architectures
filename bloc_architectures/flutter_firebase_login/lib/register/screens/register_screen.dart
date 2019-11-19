import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_login/register/bloc/bloc.dart';
import 'package:flutter_firebase_login/repos/repos.dart';
import '../widgets/widgets.dart';
class RegisterScreen extends StatelessWidget {
  final UserRepository _userRepository;

  RegisterScreen({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Center(
        child: BlocProvider<RegisterBloc>(
          builder: (context) => RegisterBloc(userRepository: _userRepository),
          child: RegisterForm(),
        ),
      ),
    );
  }
}
