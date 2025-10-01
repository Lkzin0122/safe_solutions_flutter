import 'package:get_storage/get_storage.dart';
import 'session_storage.dart';

class StorageExample {
  // Example of saving session data
  static void saveUserSession() {
    SessionStorage.saveSession(
      userId: 123,
      id: 456,
      idToken: 'sample_id_token',
      refreshToken: 'sample_refresh_token',
      deviceToken: 'sample_device_token',
      userType: 1,
      accessToken: 'sample_access_token',
    );
  }

  // Example of checking login status
  static void checkLoginStatus() {
    if (SessionStorage.isLoggedIn) {
      final token = SessionStorage.token;
      print("Logged in with token: $token");
    } else {
      print("User not logged in");
    }
  }

  // Example of getting user data
  static void getUserData() {
    final userId = SessionStorage.userId;
    final userType = SessionStorage.userType;
    print("User ID: $userId, User Type: $userType");
  }

  // Example of creating HTTP headers with token
  static Map<String, String> getAuthHeaders() {
    return {
      'Authorization': 'Bearer ${SessionStorage.token}',
      'Content-Type': 'application/json',
    };
  }

  // Example of logout
  static void logout() {
    SessionStorage.clearSession();
    // Navigate to login screen
    // Get.offAll(() => LoginScreen());
  }

  // Direct GetStorage access example
  static void directStorageExample() {
    final storage = GetStorage();
    storage.write('custom_key', 'custom_value');
    print(storage.read('custom_key'));
  }
}