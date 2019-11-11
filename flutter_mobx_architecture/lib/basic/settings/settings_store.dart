import 'package:mobx/mobx.dart';

import 'preference_service.dart';

part 'settings_store.g.dart';



class SettingStore = _SettingStore with _$SettingStore;

abstract class _SettingStore with Store {
  final PreferenceService _preferenceService;

  _SettingStore(this._preferenceService) {
    useDarkMode = _preferenceService.useDarkMode;
  }

  @observable
  bool useDarkMode;

  void setDarkMode(bool value) {
    _preferenceService.useDarkMode = value;
    useDarkMode = value;
  }
}
