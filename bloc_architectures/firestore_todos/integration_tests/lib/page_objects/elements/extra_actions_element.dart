import 'package:flutter_driver/flutter_driver.dart';

import 'test_element.dart';

class ExtraActionsElement extends TestElement {
  ExtraActionsElement(FlutterDriver driver) : super(driver);

  final _toggleAll = find.byValueKey('__markAllDone__');
  final _clearCompleted = find.byValueKey('__clearCompleted__');

  Future<ExtraActionsElement> tapToggleAll() async {
    await driver.tap(_toggleAll);
    return this;
  }

  Future<ExtraActionsElement> tapClearCompleted() async {
    await driver.tap(_clearCompleted);
    return this;
  }
}
