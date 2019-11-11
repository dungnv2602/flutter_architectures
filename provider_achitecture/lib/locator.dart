import 'package:get_it/get_it.dart';

import 'core/services/background_service.dart';
import 'core/services/dialog_service.dart';
import 'core/services/location_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<DialogService>(() => DialogService());
  locator.registerLazySingleton<LocationService>(() => LocationService());
  locator.registerLazySingleton<BackgroundService>(() => BackgroundService());
}
