import 'package:flutter/widgets.dart';
import 'package:flutter_responsive_ui_arch/models/drawer_item_model.dart';
import 'package:flutter_responsive_ui_arch/responsive/orientation_layout.dart';
import 'package:flutter_responsive_ui_arch/responsive/screen_type_layout.dart';
import 'package:provider/provider.dart';
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
        mobile: OrientationLayout(
          portrait: (context) => DrawerItemMobilePortrait(),
          landscape: (context) => DrawerItemMobileLandscape(),
        ),
        tablet: OrientationLayout(
          portrait: (context) => DrawerItemTabletPortrait(),
          // use mobile portrait for tablet landscape
          landscape: (context) => DrawerItemMobilePortrait(),
        ),
      ),
    );
  }
}
