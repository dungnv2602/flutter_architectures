import 'dart:ui';
import 'package:mobx/mobx.dart';

import 'package:validators/validators.dart';

part 'form_store.g.dart';

class FormStore = _FormStore with _$FormStore;

abstract class _FormStore with Store {
  final FormErrorState error = FormErrorState();

  @observable
  CustomColor color;

  @observable
  String name = '';

  @observable
  String email = '';

  @observable
  String password = '';

  @observable
  ObservableFuture<bool> _nameCheck = ObservableFuture.value(true);

  @computed
  bool get isNameCheckPending => _nameCheck.status == FutureStatus.pending;

  @computed
  bool get canLogin => !error.hasErrors;

  Future<bool> checkValidName(String value) async {
    await Future.delayed(Duration(seconds: 1));
    return value != 'admin';
  }

  /// A callable class that is used to dispose a reaction, autorun or when
  List<ReactionDisposer> _disposers;

  void setupValidations() {
    _disposers = [
      reaction<String>((_) => name, validateUsername), // trigger when name changes
      reaction<String>((_) => email, validateEmail), // trigger when email changes
      reaction<String>((_) => password, validatePassword), // trigger when password changes
    ];
  }

  void validateAll() {
    validatePassword(password);
    validateEmail(email);
    validateUsername(name);
  }

  @action
  Future<void> validateUsername(String value) async {
    if (isNull(value) || value.isEmpty) {
      error.name = 'Cannot be blank';
      return;
    }

    try {
      _nameCheck = ObservableFuture(checkValidName(value));

      final isValid = await _nameCheck;

      if (!isValid) {
        error.name = 'Name cannot be "admin"';
        return;
      }

      error.name = null;
    } on Object catch (_) {
      error.name = null;
    }

    error.name = null;
  }

  @action
  void validatePassword(String value) => error.password = isNull(value) || value.isEmpty ? 'Cannot be blank' : null;

  @action
  void validateEmail(String value) => error.email = isEmail(value) ? null : 'Email invalid';

  @override
  void dispose() {
    _disposers.map((d) => d());
    super.dispose();
  }
}

class FormErrorState = _FormErrorState with _$FormErrorState;

abstract class _FormErrorState with Store {
  @observable
  String name;

  @observable
  String email;

  @observable
  String password;

  @computed
  bool get hasErrors => name != null || email != null || password != null;
}

class CustomColor extends Color {
  CustomColor(int value) : super(value);
}
