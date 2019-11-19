import 'package:flutter_driver/flutter_driver.dart';

import 'test_element.dart';

class FiltersElement extends TestElement {
  FiltersElement(FlutterDriver driver) : super(driver);
  final _allFilter = find.byValueKey('__allFilter__');
  final _activeFilter = find.byValueKey('__activeFilter__');
  final _completedFilter = find.byValueKey('__completedFilter__');

  Future<Null> tapShowAll() async => await driver.tap(_allFilter);

  Future<Null> tapShowActive() async => await driver.tap(_activeFilter);

  Future<Null> tapShowCompleted() async => await driver.tap(_completedFilter);
}
