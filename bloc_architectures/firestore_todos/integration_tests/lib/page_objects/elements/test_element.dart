import 'package:flutter_driver/flutter_driver.dart';

abstract class TestElement {
  final FlutterDriver driver;
  const TestElement(this.driver);
}
