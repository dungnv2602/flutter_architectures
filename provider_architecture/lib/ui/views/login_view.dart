import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_architecture/provider/login_notifier.dart';
import 'package:provider_architecture/ui/routing/global_navigator.dart';
import 'package:provider_architecture/ui/routing/router.dart';
import 'package:provider_architecture/ui/shared/app_colors.dart';
import 'package:provider_architecture/ui/shared/text_styles.dart';
import 'package:provider_architecture/ui/shared/ui_helpers.dart';

import 'base_view.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginNotifier>(
      notifier: LoginNotifier(
          // Inject authentication service setup in the provider_setup
          authenticationService: Provider.of(context)),
      consumerChild: LoginHeader(controller: _controller),
      consumerBuilder: (context, notifier, child) => Scaffold(
        backgroundColor: backgroundColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            child,
            notifier.isBusy
                ? CircularProgressIndicator()
                : FlatButton(
                    color: Colors.white,
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () async {
                      bool isSucceeded = await notifier.login(_controller.text);
                      if (isSucceeded) pushNamed(route: RoutePaths.home);
                    },
                  ),
            FlatButton(
              color: Colors.white,
              child: const Text(
                'Show Dialog',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () async => await notifier.showDialog(),
            ),
            FlatButton(
              color: Colors.white,
              child: const Text(
                'Show Loading Dialog',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () async => await notifier.showLoadingDialog(),
            ),
            FlatButton(
              color: Colors.white,
              child: const Text(
                'Fake Posts',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () => pushNamed(route: RoutePaths.fakePosts),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginHeader extends StatelessWidget {
  final TextEditingController controller;
  final String validationMessage;

  LoginHeader({@required this.controller, this.validationMessage});

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text('Login', style: headerStyle),
      UIHelper.verticalSpaceMedium,
      Text('Enter a number between 1 - 10', style: subHeaderStyle),
      LoginTextField(controller),
      this.validationMessage != null
          ? Text(validationMessage, style: TextStyle(color: Colors.red))
          : Container()
    ]);
  }
}

class LoginTextField extends StatelessWidget {
  final TextEditingController controller;

  LoginTextField(this.controller);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
      height: 50.0,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
      child: TextField(
          decoration: InputDecoration.collapsed(hintText: 'User Id'),
          controller: controller),
    );
  }
}
