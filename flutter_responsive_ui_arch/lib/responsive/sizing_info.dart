import 'package:flutter/widgets.dart';
import 'package:flutter_responsive_ui_arch/constants/device_screen_type.dart';

class SizingInformation {
  final DeviceScreenType deviceScreenType;
  final Size screenSize;
  final Size localWidgetSize;

  SizingInformation({
    @required this.deviceScreenType,
    @required this.screenSize,
    @required this.localWidgetSize,
  })  : assert(deviceScreenType != null),
        assert(screenSize != null),
        assert(localWidgetSize != null);

  @override
  String toString() {
    return 'DeviceType:$deviceScreenType ScreenSize:$screenSize LocalWidgetSize:$localWidgetSize';
  }
}
