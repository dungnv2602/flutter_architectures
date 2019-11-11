import 'package:flutter/material.dart';
import 'package:flutter_responsive_ui_arch/responsive/screen_type_layout.dart';
import 'package:flutter_responsive_ui_arch/widgets/drawer_item/drawer_item.dart';

import 'app_drawer_mobile.dart';
import 'app_drawer_tablet.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: AppDrawerMobile(),
      tablet: AppDrawerTablet(),
    );
  }

  static List<Widget> getDrawerItems() {
    return [
      DrawerItem(
        title: 'Images',
        iconData: Icons.image,
      ),
      DrawerItem(
        title: 'reports',
        iconData: Icons.photo_filter,
      ),
      DrawerItem(
        title: 'Incidents',
        iconData: Icons.message,
      ),
      DrawerItem(
        title: 'Settings',
        iconData: Icons.settings,
      ),
    ];
  }
}
