import 'package:flutter/widgets.dart';
import 'package:flutter_responsive_ui_arch/models/drawer_item_model.dart';
import 'package:flutter_responsive_ui_arch/widgets/base_model_widget.dart';

class DrawerItemTabletPortrait extends BaseModelWidget<DrawerItemModel> {
  @override
  Widget build(BuildContext context, DrawerItemModel model) {
    return Container(
      width: 152,
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(model.iconData, size: 45),
          Text(model.title, style: TextStyle(fontSize: 20)),
        ],
      ),
    );
  }
}
