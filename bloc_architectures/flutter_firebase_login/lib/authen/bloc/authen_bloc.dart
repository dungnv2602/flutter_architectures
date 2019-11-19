import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_firebase_login/repos/user_repo.dart';

import './bloc.dart';

class AuthenBloc extends Bloc<AuthenEvent, AuthenState> {
  final UserRepository userRepo;
  AuthenBloc(this.userRepo);
  @override
  AuthenState get initialState => Uninitialized();

  @override
  Stream<AuthenState> mapEventToState(
    AuthenEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    }
    if (event is LoggedIn) {
      yield* _mapLoggedInToState();
    }
    if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }

  Stream<AuthenState> _mapAppStartedToState() async* {
    try {
      final isLoggedIn = await userRepo.isLoggedIn();
      if (isLoggedIn) {
        final user = await userRepo.getUser();
        yield Authenticated(user);
      } else {
        yield Unauthenticated();
      }
    } catch (_) {
      yield Unauthenticated();
    }
  }

  Stream<AuthenState> _mapLoggedInToState() async* {
    yield Authenticated(await userRepo.getUser());
  }

  Stream<AuthenState> _mapLoggedOutToState() async* {
    yield Unauthenticated();
    userRepo.signOut();
  }
}
