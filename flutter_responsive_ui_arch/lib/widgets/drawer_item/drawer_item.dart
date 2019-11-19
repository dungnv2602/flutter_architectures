import 'package:flutter/widgets.dart';
import 'package:flutter_responsive_ui_arch/models/drawer_item_model.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'drawer_item_mobile.dart';
import 'drawer_item_tablet.dart';

class DrawerItem extends StatelessWidget {
  final String title;
  final IconData iconData;

  const DrawerItem({
    Key key,
    @required this.title,
    @required this.iconData,
  })  : assert(title != null),
        assert(iconData != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: DrawerItemModel(title: title, iconData: iconData),
      child: ScreenTypeLayout(
        mobile: OrientationLayoutBuilder(
          portrait: (context) => DrawerItemMobilePortrait(),
          landscape: (context) => DrawerItemMobileLandscape(),
        ),
        tablet: OrientationLayoutBuilder(
          portrait: (context) => DrawerItemTabletPortrait(),
          // use mobile portrait for tablet landscape
          landscape: (context) => DrawerItemMobilePortrait(),
        ),
      ),
    );
  }
}
