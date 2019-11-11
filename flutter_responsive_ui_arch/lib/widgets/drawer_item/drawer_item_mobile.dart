import 'package:flutter/widgets.dart';
import 'package:flutter_responsive_ui_arch/models/drawer_item_model.dart';
import 'package:flutter_responsive_ui_arch/widgets/base_model_widget.dart';

class DrawerItemMobilePortrait extends BaseModelWidget<DrawerItemModel> {
  @override
  Widget build(BuildContext context, DrawerItemModel model) {
    return Container(
      padding: const EdgeInsets.only(left: 25),
      height: 80,
      child: Row(
        children: <Widget>[
          Icon(model.iconData, size: 25),
          SizedBox(width: 25),
          Text(model.title, style: TextStyle(fontSize: 21)),
        ],
      ),
    );
  }
}

class DrawerItemMobileLandscape extends BaseModelWidget<DrawerItemModel> {
  @override
  Widget build(BuildContext context, DrawerItemModel model) {
    return Container(
      height: 70,
      alignment: Alignment.center,
      child: Icon(model.iconData),
    );
  }
}
