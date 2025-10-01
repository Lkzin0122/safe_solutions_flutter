import 'package:get_storage/get_storage.dart';

class SessionStorage {
  static final _storage = GetStorage();

  // Keys
  static const String _userIdKey = 'user_id';
  static const String _idKey = 'id';
  static const String _idTokenKey = 'id_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _deviceTokenKey = 'device_token';
  static const String _userType = 'user_type';
  static const String _accessToken = 'access_token';

  // Save session data
  static void saveSession({
    required int userId,
    required int id,
    required String idToken,
    required String refreshToken,
    required String deviceToken,
    required int userType,
    required String accessToken,
  }) {
    _storage.write(_userIdKey, userId);
    _storage.write(_idKey, id);
    _storage.write(_idTokenKey, idToken);
    _storage.write(_refreshTokenKey, refreshToken);
    _storage.write(_deviceTokenKey, deviceToken);
    _storage.write(_userType, userType);
    _storage.write(_accessToken, accessToken);
  }

  // Getters
  static int? get userId => _storage.read(_userIdKey);
  static int? get id => _storage.read(_idKey);
  static String? get idToken => _storage.read(_idTokenKey);
  static String? get refreshToken => _storage.read(_refreshTokenKey);
  static String? get deviceToken => _storage.read(_deviceTokenKey);
  static int? get userType => _storage.read(_userType);
  static String? get accessToken => _storage.read(_accessToken);
  static String get token => accessToken ?? '';
  static bool get isLoggedIn => idToken != null;

  // Clear all session data
  static void clearSession() {
    _storage.remove(_userIdKey);
    _storage.remove(_idKey);
    _storage.remove(_idTokenKey);
    _storage.remove(_refreshTokenKey);
    _storage.remove(_deviceTokenKey);
    _storage.remove(_userType);
    _storage.remove(_accessToken);
  }
}