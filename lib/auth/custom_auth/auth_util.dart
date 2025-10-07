import 'custom_auth_user_provider.dart';

final authManager = SafeSolutionsAuthUserProvider();

SafeSolutionsAuthUser get currentUser => authManager.currentUser;