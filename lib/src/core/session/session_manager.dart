import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SessionManager {
  static final SessionManager _instance = SessionManager._internal();
  factory SessionManager() => _instance;
  SessionManager._internal();

  static const String _isLoggedInKey = 'is_user_logged_in';
  static const String _userIdKey = 'user_id';
  static const String _userEmailKey = 'user_email';
  static const String _lastLoginKey = 'last_login_time';

  /// Save login state
  static Future<void> saveLoginState({
    required String userId,
    required String userEmail,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_isLoggedInKey, true);
      await prefs.setString(_userIdKey, userId);
      await prefs.setString(_userEmailKey, userEmail);
      await prefs.setString(_lastLoginKey, DateTime.now().toString());

      print('💾 SessionManager: Login state saved');
      print('   - User ID: $userId');
      print('   - Email: $userEmail');
      print('   - Time: ${DateTime.now()}');
    } catch (e) {
      print('❌ SessionManager: Error saving login state: $e');
    }
  }

  /// Clear login state
  static Future<void> clearLoginState() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_isLoggedInKey, false);
      await prefs.remove(_userIdKey);
      await prefs.remove(_userEmailKey);
      print('🗑️ SessionManager: Login state cleared');
    } catch (e) {
      print('❌ SessionManager: Error clearing login state: $e');
    }
  }

  /// Check if user was previously logged in
  static Future<bool> wasUserLoggedIn() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isLoggedIn = prefs.getBool(_isLoggedInKey) ?? false;

      print('🔍 SessionManager: Was user logged in? $isLoggedIn');

      if (isLoggedIn) {
        final userId = prefs.getString(_userIdKey);
        final userEmail = prefs.getString(_userEmailKey);
        final lastLogin = prefs.getString(_lastLoginKey);

        print('   - User ID: $userId');
        print('   - Email: $userEmail');
        print('   - Last login: $lastLogin');
      }

      return isLoggedIn;
    } catch (e) {
      print('❌ SessionManager: Error checking login state: $e');
      return false;
    }
  }

  /// Get saved user info
  static Future<Map<String, String>> getSavedUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'userId': prefs.getString(_userIdKey) ?? '',
      'userEmail': prefs.getString(_userEmailKey) ?? '',
    };
  }

  /// Force restore Supabase session
  static Future<bool> restoreSupabaseSession() async {
    try {
      print('🔄 SessionManager: Attempting to restore Supabase session...');

      final client = Supabase.instance.client;

      // Wait for Supabase to initialize
      await Future.delayed(const Duration(seconds: 2));

      // Check if session exists
      final session = client.auth.currentSession;
      final user = client.auth.currentUser;

      print('📊 SessionManager: Supabase state after restore:');
      print('   - Session: ${session != null ? "EXISTS" : "NONE"}');
      print('   - User: ${user?.email ?? "NONE"}');

      return session != null && user != null;
    } catch (e) {
      print('❌ SessionManager: Error restoring session: $e');
      return false;
    }
  }

  /// Debug: Print all storage
  static Future<void> debugStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final allKeys = prefs.getKeys();

      print('\n🔍 === STORAGE DEBUG ===');
      print('Total keys: ${allKeys.length}');

      for (final key in allKeys) {
        final value = prefs.get(key);
        print('   $key: $value');
      }

      print('========================\n');
    } catch (e) {
      print('❌ Storage debug error: $e');
    }
  }
}