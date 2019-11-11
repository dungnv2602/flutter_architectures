import 'package:flutter/material.dart';
import 'package:flutter_responsive_ui_arch/viewmodels/home_viewmodel.dart';
import 'package:flutter_responsive_ui_arch/widgets/app_drawer/app_drawer.dart';
import 'package:flutter_responsive_ui_arch/widgets/base_model_widget.dart';

class HomeViewMobilePortrait extends BaseModelWidget<HomeViewModel> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context, HomeViewModel model) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: AppDrawer(),
      floatingActionButton: FloatingActionButton(onPressed: () => model.increment()),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: IconButton(
              icon: Icon(Icons.menu, size: 30),
              onPressed: () => _scaffoldKey?.currentState?.openDrawer(),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(model.counter.toString()),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeViewMobileLandscape extends BaseModelWidget<HomeViewModel> {
  @override
  Widget build(BuildContext context, HomeViewModel model) {
    return Scaffold(
      body: Row(
        children: <Widget>[
          AppDrawer(),
          Expanded(
            child: Center(
              child: Text(
                model.counter.toString(),
                style: TextStyle(fontSize: 35),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
