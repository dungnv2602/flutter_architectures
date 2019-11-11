import 'package:flutter/widgets.dart';
import 'package:flutter_responsive_ui_arch/constants/device_screen_type.dart';

import 'responsive_builder.dart';

class ScreenTypeLayout extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const ScreenTypeLayout({
    Key key,
    @required this.mobile,
    this.tablet,
    this.desktop,
  })  : assert(mobile != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInfo) {
        if (sizingInfo.deviceScreenType == DeviceScreenType.Tablet && tablet != null) {
          return tablet;
        } else if (sizingInfo.deviceScreenType == DeviceScreenType.Desktop && desktop != null) {
          return desktop;
        } else {
          return mobile;
        }
      },
    );
  }
}
