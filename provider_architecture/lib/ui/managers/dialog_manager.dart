import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/core/models/alert.dart';
import 'package:provider_architecture/core/services/dialog_service.dart';
import 'package:provider_architecture/locator.dart';
import 'package:provider_architecture/ui/routing/global_navigator.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class DialogManager extends StatefulWidget {
  final Widget child;

  const DialogManager({Key key, @required this.child})
      : assert(child != null),
        super(key: key);

  @override
  _DialogManagerState createState() => _DialogManagerState();
}

class _DialogManagerState extends State<DialogManager> {
  final _dialogService = locator<DialogService>();

  @override
  void initState() {
    super.initState();
    _dialogService.registerCallback(_showDialog);
    _dialogService.registerLoadingDialogCallback(_showLoadingDialog);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _dialogService.registerCallback(_showDialog);
    _dialogService.registerLoadingDialogCallback(_showLoadingDialog);
  }

  void _showLoadingDialog() {
    showCupertinoDialog(
      context: context,
      builder: (_) {
        return Dialog(
          backgroundColor: Colors.black12,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          child: Container(
            height: 200,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.white70,
            ),
            child: Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
                strokeWidth: 2,
              ),
            ),
          ),
        );
      },
    );
  }

  void _showDialog(AlertRequest request) {
    Alert(
      context: context,
      title: request.title,
      desc: request.description,
      closeFunction: () =>
          _dialogService.completeDialog(AlertResponse(confirmed: false)),
      style: AlertStyle(
        isOverlayTapDismiss: false,
      ),
      buttons: [
        DialogButton(
          child: Text(request.buttonTitle),
          onPressed: () {
            _dialogService.completeDialog(AlertResponse(confirmed: true));
            pop();
          },
        )
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
