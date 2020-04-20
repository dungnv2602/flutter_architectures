import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:provider_architecture/core/models/user.dart';
import 'package:provider_architecture/core/services/api.dart';
import 'package:provider_architecture/core/services/authentication_service.dart';

List<SingleChildWidget> providers = [
  ...independentProviders,
  ...dependentProviders,
  ...uiConsumableProviders,
];

List<SingleChildWidget> independentProviders = [Provider(create: (_) => Api())];
List<SingleChildWidget> dependentProviders = [
  ProxyProvider<Api, AuthenticationService>(
    update: (context, api, authenticationService) =>
        AuthenticationService(api: api),
  )
];
List<SingleChildWidget> uiConsumableProviders = [
  ///This will only work with listen set to false because we'll bypass the "need to update" all dependencies when a didChangeDependencies is invoked. If you don't set listen to false this will not work.
  StreamProvider<User>(
    create: (context) =>
        Provider.of<AuthenticationService>(context, listen: false).userStream,
  )
];
