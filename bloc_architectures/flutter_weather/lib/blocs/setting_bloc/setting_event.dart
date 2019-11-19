import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SettingsEvent extends Equatable {}

class TemperatureUnitsToggled extends SettingsEvent {
  @override
  List<Object> get props => [];
}