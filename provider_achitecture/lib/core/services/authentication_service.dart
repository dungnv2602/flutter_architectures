import 'dart:async';

import 'package:provider_arc/core/models/user.dart';
import 'package:provider_arc/core/services/api.dart';

class AuthenticationService {
  final Api _api;

  AuthenticationService({Api api}) : _api = api;

  StreamController<User> _userStreamController = StreamController<User>();

  Stream<User> get userStream => _userStreamController.stream;

  Future<bool> login(int userId) async {
    var fetchedUser = await _api.getUserProfile(userId);

    var hasUser = fetchedUser != null;
    if (hasUser) {
      _userStreamController.add(fetchedUser);
    }

    return hasUser;
  }
}

