import 'package:rxdart/rxdart.dart';

import 'custom_auth_manager.dart';

class SafeSolutionsAuthUser {
  SafeSolutionsAuthUser({required this.loggedIn, this.uid});

  bool loggedIn;
  String? uid;
}

/// Generates a stream of the authenticated user.
BehaviorSubject<SafeSolutionsAuthUser> safeSolutionsAuthUserSubject =
    BehaviorSubject.seeded(SafeSolutionsAuthUser(loggedIn: false));
Stream<SafeSolutionsAuthUser> safeSolutionsAuthUserStream() =>
    safeSolutionsAuthUserSubject
        .asBroadcastStream()
        .map((user) => currentUser = user);
