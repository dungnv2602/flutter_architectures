import 'package:provider/provider.dart';
import 'package:provider_arc/core/models/user.dart';
import 'package:provider_arc/core/services/api.dart';
import 'package:provider_arc/core/services/authentication_service.dart';

List<SingleChildCloneableWidget> providers = [
  ...independentProviders,
  ...dependentProviders,
  ...uiConsumableProviders,
];

List<SingleChildCloneableWidget> independentProviders = [
  Provider.value(value: Api())
];
List<SingleChildCloneableWidget> dependentProviders = [
  ProxyProvider<Api, AuthenticationService>(
    builder: (context, api, authenticationService) =>
        AuthenticationService(api: api),
  )
];
List<SingleChildCloneableWidget> uiConsumableProviders = [
  ///This will only work with listen set to false because we'll bypass the "need to update" all dependencies when a didChangeDependencies is invoked. If you don't set listen to false this will not work.
  StreamProvider<User>(
    builder: (context) =>
        Provider.of<AuthenticationService>(context, listen: false).userStream,
  )
];
