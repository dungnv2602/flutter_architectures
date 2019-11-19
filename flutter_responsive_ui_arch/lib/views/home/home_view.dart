import 'package:flutter/material.dart';
import 'package:flutter_responsive_ui_arch/viewmodels/home_viewmodel.dart';
import 'package:flutter_responsive_ui_arch/widgets/base_widget.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'home_view_mobile.dart';
import 'home_view_tablet.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<HomeViewModel>(
      viewModel: HomeViewModel(),
      onModelReady: (model) => model.initialise(),
      child: ScreenTypeLayout(
        mobile: OrientationLayoutBuilder(
          portrait: (context) => HomeViewMobilePortrait(),
          landscape: (context) => HomeViewMobileLandscape(),
        ),
        tablet: HomeViewTablet(),
      ),
    );
  }
}
