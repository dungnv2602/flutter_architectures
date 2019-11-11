import 'package:flutter/widgets.dart';

class DrawerItemModel {
  final String title;
  final IconData iconData;

  DrawerItemModel({
    @required this.title,
    @required this.iconData,
  })  : assert(title != null),
        assert(iconData != null);
}
