import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_responsive_ui_arch/viewmodels/home_viewmodel.dart';
import 'package:flutter_responsive_ui_arch/widgets/app_drawer/app_drawer.dart';
import 'package:flutter_responsive_ui_arch/widgets/base_model_widget.dart';

class HomeViewTablet extends BaseModelWidget<HomeViewModel> {
  @override
  Widget build(BuildContext context, HomeViewModel model) {
    final children = [
      Expanded(
        child: Center(
          child: Text(
            model.counter.toString(),
            style: TextStyle(fontSize: 50),
          ),
        ),
      ),
      AppDrawer()
    ];
    return OrientationBuilder(
      builder: (context, orientation) => PlatformScaffold(
        body: orientation == Orientation.portrait
            ? Column(children: children)
            : Row(children: children.reversed.toList()),
      ),
    );
  }
}
