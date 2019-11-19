import 'package:meta/meta.dart';

@immutable
class LoginState {
  final bool isEmailValid;
  final bool isPwdValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final String errorMsg;

  bool get isFormValid => isEmailValid && isPwdValid;

  LoginState({
    @required this.isEmailValid,
    @required this.isPwdValid,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure,
    this.errorMsg = '',
  })  : assert(isEmailValid != null),
        assert(isPwdValid != null),
        assert(isSubmitting != null),
        assert(isSuccess != null),
        assert(isFailure != null);

  factory LoginState.empty() {
    return LoginState(
      isEmailValid: false,
      isPwdValid: false,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory LoginState.loading() {
    return LoginState(
      isEmailValid: true,
      isPwdValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory LoginState.failure(String msg) {
    return LoginState(
      isEmailValid: true,
      isPwdValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
      errorMsg: msg,
    );
  }

  factory LoginState.success() {
    return LoginState(
      isEmailValid: true,
      isPwdValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  LoginState copyWith({
    bool isEmailValid,
    bool isPwdValid,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
  }) {
    return LoginState(
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPwdValid: isPwdValid ?? this.isPwdValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  LoginState updateEmailPwd({bool isEmailValid, bool isPwdValid}) {
    return copyWith(
      isEmailValid: isEmailValid,
      isPwdValid: isPwdValid,
      isSubmitting: false,
      isFailure: false,
      isSuccess: false,
    );
  }

  @override
  String toString() {
    return '''LoginState {
      isEmailValid: $isEmailValid,
      isPwdValid: $isPwdValid,
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
    }''';
  }
}
