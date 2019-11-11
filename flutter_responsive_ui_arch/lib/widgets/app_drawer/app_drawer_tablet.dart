import 'package:flutter/material.dart';

import 'app_drawer.dart';

class AppDrawerTablet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder:(context, orientation)=> Container(
        height: orientation == Orientation.portrait ? 130 : 250,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 16,
              color: Colors.black12,
            ),
          ],
        ),
        child: Row(children: AppDrawer.getDrawerItems()),
      ),
    );
  }
}
