import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  static final String _accessTokenKey = "access-token";
  static String? accessToken;
  static Future<void> SaveAccessToken(String token) async
  {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(_accessTokenKey, token);
    accessToken = token;
  }
  static Future<String?> GetAccessToken(String token) async
  {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(_accessTokenKey);
    accessToken = token;
    return token;
  }
  static Future<void> ClearUserData() async
  {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    accessToken = null;
  }
  static bool IsLoggedIn()
  {
    return accessToken != null;
  }
}