import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/user.dart';

class LoggedInUserProvider extends StateNotifier<User?> {

  LoggedInUserProvider(): super(null);

  User? get value => state;

  set setUser(User? val) {
    state = val;
  }
}

final loggedInUserProvider = StateNotifierProvider<LoggedInUserProvider, User?>(
      (ref) => LoggedInUserProvider(),
);