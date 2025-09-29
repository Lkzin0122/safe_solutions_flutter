import 'package:rxdart/rxdart.dart';

class SafeSolutionsAuthUser {
  final bool loggedIn;
  final String? uid;
  
  SafeSolutionsAuthUser({required this.loggedIn, this.uid});
}

class SafeSolutionsAuthUserProvider {
  final _userSubject = BehaviorSubject.seeded(SafeSolutionsAuthUser(loggedIn: false));
  
  Stream<SafeSolutionsAuthUser> get user => _userSubject.stream;
  SafeSolutionsAuthUser get currentUser => _userSubject.value;
  
  void dispose() {
    _userSubject.close();
  }
}

// Global subject for auth user
final safeSolutionsAuthUserSubject = BehaviorSubject.seeded(SafeSolutionsAuthUser(loggedIn: false));