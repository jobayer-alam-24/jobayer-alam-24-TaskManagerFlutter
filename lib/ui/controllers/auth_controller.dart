import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  static const String _accessTokenKey = "access-token";
  static const String _emailKey = "email";
  static const String _firstNameKey = "first-name";
  static const String _lastNameKey = "last-name";
  static String? accessToken;


  static Future<void> saveUserData({
    required String token,
    required String email,
    required String firstName,
    required String lastName,
    required String photoBase64
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString(_accessTokenKey, token);
    await prefs.setString(_emailKey, email);
    await prefs.setString(_firstNameKey, firstName);
    await prefs.setString(_lastNameKey, lastName);
    accessToken = token;
  }

  static Future<void> SaveAccessToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_accessTokenKey, token);
    accessToken = token;
  }

  static Future<String?> GetAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString(_accessTokenKey);
    return accessToken;
  }


  static Future<String?> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_emailKey);
  }

  static Future<String?> getFullName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final firstName = prefs.getString(_firstNameKey);
    final lastName = prefs.getString(_lastNameKey);

    if (firstName == null || lastName == null) return null;
    return "$firstName $lastName";
  }

  static Future<void> ClearUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    accessToken = null;
  }

  static bool IsLoggedIn() {
    return accessToken != null;
  }
}
