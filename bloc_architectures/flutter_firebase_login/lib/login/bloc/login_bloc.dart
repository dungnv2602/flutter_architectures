import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_firebase_login/repos/repos.dart';
import 'package:flutter_firebase_login/services/services.dart';
import 'package:rxdart/rxdart.dart';

import './bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepo;

  LoginBloc(this.userRepo);

  @override
  LoginState get initialState => LoginState.empty();

  @override
  Stream<LoginState> transformEvents(Stream<LoginEvent> events,
      Stream<LoginState> Function(LoginEvent event) next) {
    final observableStream = events as Observable<LoginEvent>;
    final nonDebounceStream = observableStream.where((event) {
      return (event is! EmailChanged && event is! PasswordChanged);
    });
    final debounceStream = observableStream.where((event) {
      return (event is EmailChanged || event is PasswordChanged);
    });
    return super
        .transformEvents(nonDebounceStream.mergeWith([debounceStream]), next);
  }

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is LoginWithGooglePressed) {
      yield* _mapLoginWithGooglePressedToState();
    } else if (event is Submitted) {
      yield* _mapLoginWithCredentialsPressedToState(
        email: event.email,
        password: event.password,
      );
    }
  }

  Stream<LoginState> _mapEmailChangedToState(String email) async* {
    yield state.updateEmailPwd(
      isEmailValid: Validators.isValidEmail(email),
    );
  }

  Stream<LoginState> _mapPasswordChangedToState(String password) async* {
    yield state.updateEmailPwd(
      isPwdValid: Validators.isValidPassword(password),
    );
  }

  Stream<LoginState> _mapLoginWithGooglePressedToState() async* {
    try {
      yield LoginState.loading();
      await userRepo.signInWithGoogle();
      yield LoginState.success();
    } catch (error) {
      yield LoginState.failure(error.toString());
    }
  }

  Stream<LoginState> _mapLoginWithCredentialsPressedToState({
    String email,
    String password,
  }) async* {
    try {
      yield LoginState.loading();
      await userRepo.signInWithCredentials(email, password);
      yield LoginState.success();
    } catch (error) {
      yield LoginState.failure(error.toString());
    }
  }
}
