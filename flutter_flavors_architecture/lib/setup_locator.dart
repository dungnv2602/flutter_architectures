import 'package:flutter_flavors_architecture/setup_flavors.dart';
import 'package:get_it/get_it.dart';

import 'services/api/api.dart';
import 'services/api/fake_api.dart';
import 'services/api/http_api.dart';
import 'services/storage_service/fake_storage_service.dart';
import 'services/storage_service/local_storage_service.dart';
import 'services/storage_service/storage_service.dart';

GetIt locator = GetIt.instance;

/// NOTICE GET-IT DOESN'T HAVE ANY DISPOSING FUNCTION
void setupLocator() => Flavor.flavorType == FlavorType.MOCK ? _setupLocatorMock() : _setupLocatorProd();

void _setupLocatorMock() {
  locator.registerLazySingleton<Api>(() => FakeApi());
  locator.registerLazySingleton<StorageService>(() => FakeStorageService());
}

void _setupLocatorProd() {
  locator.registerLazySingleton<Api>(() => HttpApi());
  locator.registerLazySingleton<StorageService>(() => LocalStorageService());
}
