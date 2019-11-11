import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:provider_arc/core/models/alert.dart';

class DialogService {
  Function(AlertRequest) _callback;
  VoidCallback _loadingDialogCallback;
  Completer _completer;

  void registerLoadingDialogCallback(VoidCallback loadingDialogCallback) {
    _loadingDialogCallback = loadingDialogCallback;
  }

  void showLoadingDialog() {
    _loadingDialogCallback();
  }

  void registerCallback(Function(AlertRequest) callback) {
    _callback = callback;
  }

  /// trigger callback & return a future which will wait for dialogComplete
  Future showDialog({
    String title,
    String description,
    String buttonTitle = 'Ok',
  }) {
    _completer = Completer<AlertResponse>();
    _callback(AlertRequest(
      title: title,
      description: description,
      buttonTitle: buttonTitle,
    ));
    return _completer.future;
  }

  /// Completes the _dialogCompleter to resume the Future's execution call
  void completeDialog(AlertResponse response) {
    _completer.complete(response);
    _completer = null;
  }
}