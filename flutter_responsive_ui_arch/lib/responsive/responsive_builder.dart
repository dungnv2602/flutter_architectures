import 'package:flutter/widgets.dart';
import 'package:flutter_responsive_ui_arch/utils/ui_utils.dart';
import 'sizing_info.dart';

class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, SizingInformation sizingInformation) builder;

  const ResponsiveBuilder({Key key, this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final mediaQuery = MediaQuery.of(context);
      final sizingInfo = SizingInformation(
        deviceScreenType: getDeviceScreenType(mediaQuery),
        screenSize: mediaQuery.size,
        localWidgetSize: Size(constraints.maxWidth, constraints.maxHeight),
      );
      return builder(context, sizingInfo);
    });
  }
}
