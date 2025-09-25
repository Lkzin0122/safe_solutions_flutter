import 'package:rxdart/rxdart.dart';

class SafeSolutionsAuthUser {
  final bool loggedIn;
  
  SafeSolutionsAuthUser({required this.loggedIn});
}

class SafeSolutionsAuthUserProvider {
  final _userSubject = BehaviorSubject.seeded(SafeSolutionsAuthUser(loggedIn: false));
  
  Stream<SafeSolutionsAuthUser> get user => _userSubject.stream;
  SafeSolutionsAuthUser get currentUser => _userSubject.value;
  
  void dispose() {
    _userSubject.close();
  }
}