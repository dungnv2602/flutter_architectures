import 'package:flutter/foundation.dart';
import 'package:provider_arc/core/services/dialog_service.dart';
import 'package:provider_arc/locator.dart';
import 'package:provider_arc/ui/routing/global_navigator.dart';

import '../core/services/authentication_service.dart';
import 'base_notifier.dart';

class LoginNotifier extends BaseNotifier {
  final AuthenticationService _authenticationService;
  final _dialogService = locator<DialogService>();

  LoginNotifier({@required AuthenticationService authenticationService})
      : _authenticationService = authenticationService;

  Future<bool> login(String userIdStr) async {
    busy(true);
    final userId = int.tryParse(userIdStr);
    bool isSucceeded = await _authenticationService.login(userId);
    busy(false);
    return isSucceeded;
  }

  Future<void> showDialog() async {
    print('dialog called');
    var dialogResult = await _dialogService.showDialog(
      title: 'Custom Title',
      description: 'FilledStacks architecture rocks',
    );
    if (dialogResult.confirmed) {
      print('User has confirmed');
    } else {
      print('User cancelled the dialog');
    }
  }

  Future<void> showLoadingDialog() async {
    print('dialog called');
    _dialogService.showLoadingDialog();
    await Future.delayed(const Duration(seconds: 2));
    pop();
    print('dialog closed');
  }
}
