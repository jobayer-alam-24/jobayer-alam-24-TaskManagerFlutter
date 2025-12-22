import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
class AuthController {
  static const String _accessTokenKey = "access-token";
  static const String _emailKey = "email";
  static const String _firstNameKey = "first-name";
  static const String _lastNameKey = "last-name";
  static const String _phoneKey = "phone";
  static const String _photoKey = "photo";
  static String? accessToken;

  static Future<void> saveUserData({
    required String token,
    required String email,
    required String firstName,
    required String lastName,
    required String phone,
    required String photo
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString(_accessTokenKey, token);
    await prefs.setString(_emailKey, email);
    await prefs.setString(_firstNameKey, firstName);
    await prefs.setString(_lastNameKey, lastName);
    await prefs.setString(_phoneKey, phone);
    await prefs.setString(_photoKey, photo);
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
  static Future<String?> getPhoneNo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_phoneKey);
  }
  static Future<String?> getPhotoName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_photoKey);
  }
  static Future<String> getProfileImagePath(String fileName) async {
    final dir = await getApplicationDocumentsDirectory();
    return '${dir.path}/images/$fileName';
  }
  static Future<String?> getFullName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final firstName = prefs.getString(_firstNameKey);
    final lastName = prefs.getString(_lastNameKey);

    if (firstName == null || lastName == null) return null;
    return "$firstName $lastName";
  }
static Future<String> saveProfileImage(String base64Image, String fileName) async {
  if (base64Image.contains(',')) {
    base64Image = base64Image.split(',')[1];
  }
  final bytes = base64Decode(base64Image);
  final dir = await getApplicationDocumentsDirectory();
  final file = File('${dir.path}/$fileName');
  await file.writeAsBytes(bytes);
  return file.path;
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
