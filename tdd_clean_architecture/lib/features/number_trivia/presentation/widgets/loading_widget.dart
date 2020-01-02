import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      child: const Center(
        child:  SizedBox(
            height: 33,
            width: 33,
            child: CircularProgressIndicator(strokeWidth: 1.5)),
      ),
    );
  }
}
