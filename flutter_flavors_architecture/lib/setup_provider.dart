import 'package:provider/provider.dart';

import 'services/api/api.dart';
import 'services/api/fake_api.dart';
import 'services/api/http_api.dart';
import 'services/storage_service/fake_storage_service.dart';
import 'services/storage_service/local_storage_service.dart';
import 'services/storage_service/storage_service.dart';
import 'setup_flavors.dart';

List<SingleChildCloneableWidget> providers =
    Flavor.flavorType == FlavorType.MOCK ? _setupProvidersMock() : _setupProvidersProd();

List<SingleChildCloneableWidget> _setupProvidersMock() {
  return [
    Provider<StorageService>(
      builder: (_) => FakeStorageService(),
      dispose: (_, service) => service.dispose(),
    ),
    Provider<Api>(
      builder: (_) => FakeApi(),
    ),
  ];
}

List<SingleChildCloneableWidget> _setupProvidersProd() {
  return [
    Provider<StorageService>(
      builder: (_) => LocalStorageService(),
      dispose: (_, service) => service.dispose(),
    ),
    Provider<Api>(
      builder: (_) => HttpApi(),
    ),
  ];
}
