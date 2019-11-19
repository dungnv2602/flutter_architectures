import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthenEvent extends Equatable {
  const AuthenEvent();
  @override
  List<Object> get props => [];
}

class AppStarted extends AuthenEvent {}

class LoggedIn extends AuthenEvent {}

class LoggedOut extends AuthenEvent {}
