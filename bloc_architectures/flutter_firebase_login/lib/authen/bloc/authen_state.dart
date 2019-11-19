import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthenState extends Equatable {
  const AuthenState();
  @override
  List<Object> get props => [];
}

class Uninitialized extends AuthenState {}

class Unauthenticated extends AuthenState {}

class Authenticated extends AuthenState {
  final FirebaseUser user;
  const Authenticated(this.user);
  @override
  List<Object> get props => [user];
}
