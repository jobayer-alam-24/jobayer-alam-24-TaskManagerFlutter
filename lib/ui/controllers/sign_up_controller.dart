import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';

class SignUpController extends GetxController
{
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  Future<bool> singUp(String email, String firstName, String  lastName, String mobile, String password) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    try {
      Map<String, dynamic> reqBody = {
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "mobile": mobile,
        "password": password,
        "photo": ""
      };

      NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.registration,
        body: reqBody,
      );

      if (response.isSuccess) {
        isSuccess = true;
      }
    } catch (e) {
      debugPrint("SIGN UP ERROR: $e");
    }
    finally {
      _inProgress = false;
      update();
    }
      return isSuccess;
  }
}