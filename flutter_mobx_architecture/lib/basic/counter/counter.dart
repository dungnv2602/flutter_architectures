import 'package:mobx/mobx.dart';

// include generated file
part 'counter.g.dart';

// This is the class used by rest of codebase
class Counter = _Counter with _$Counter;

abstract class _Counter with Store{
  @observable
  int value = 0;

  @action
  void increment(){
    value++;
  }
}