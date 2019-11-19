import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_login/authen/authen.dart';
import 'package:flutter_firebase_login/repos/repos.dart';

import '../login.dart';
import 'create_account_button.dart';
import 'google_login_button.dart';
import 'login_button.dart';

class LoginForm extends StatefulWidget {
  final UserRepository userRepo;
  const LoginForm({Key key, @required this.userRepo})
      : assert(userRepo != null),
        super(key: key);
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final emailController = TextEditingController();
  final pwdController = TextEditingController();
  LoginBloc loginBloc;
  @override
  void dispose() {
    emailController.dispose();
    pwdController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    loginBloc = BlocProvider.of<LoginBloc>(context);
    emailController.addListener(onEmailChanged);
    pwdController.addListener(onPwdChanged);
  }

  void onEmailChanged() {
    loginBloc.add(
      EmailChanged(email: emailController.text),
    );
  }

  void onPwdChanged() {
    loginBloc.add(
      PasswordChanged(password: pwdController.text),
    );
  }

  void onFormSubmitted() {
    loginBloc.add(Submitted(
      email: emailController.text,
      password: pwdController.text,
    ));
  }

  UserRepository get userRepo => widget.userRepo;

  bool get isPopulated =>
      emailController.text.isNotEmpty && pwdController.text.isNotEmpty;

  bool isLoginButtonEnabled(LoginState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.isSubmitting) {
          showSnackBar('Logging In...', CircularProgressIndicator());
        }
        if (state.isFailure) {
          showSnackBar('Login Failure: ${state.errorMsg}', Icon(Icons.error));
        }
        if (state.isSuccess) {
          BlocProvider.of<AuthenBloc>(context).add(LoggedIn());
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Padding(
            child: Form(
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: FlutterLogo(),
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                        icon: Icon(Icons.email), labelText: 'Email'),
                    autovalidate: true,
                    autocorrect: false,
                    validator: (_) {
                      return !state.isEmailValid ? 'Invalid Email' : null;
                    },
                  ),
                  TextFormField(
                    controller: pwdController,
                    decoration: InputDecoration(
                        icon: Icon(Icons.lock), labelText: 'Password'),
                    autovalidate: true,
                    autocorrect: false,
                    obscureText: true,
                    validator: (_) {
                      return !state.isPwdValid ? 'Invalid Password' : null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        LoginButton(
                          onPressed: isLoginButtonEnabled(state)
                              ? onFormSubmitted
                              : null,
                        ),
                        GoogleLoginButton(),
                        CreateAccountButton(userRepository: userRepo),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            padding: const EdgeInsets.all(20),
          );
        },
      ),
    );
  }

  void showSnackBar(String text, Widget widget) {
    Scaffold.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            children: <Widget>[
              Text(text),
              widget,
            ],
          ),
        ),
      );
  }
}
