import 'package:firebase_auth/firebase_auth.dart';

abstract class UserRepository {
  Future<FirebaseUser> signInWithGoogle();

  Future<FirebaseUser> signInWithCredentials(String email, String password);
  Future<FirebaseUser> signUp({String email, String password});

  Future<void> signOut();

  Future<bool> isLoggedIn();

  Future<FirebaseUser> getUser();
}
