import 'package:get/get.dart';

import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';
import 'auth_controller.dart';

class SignInController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;
  String? _errorMessege;
  String? get errorMessege => _errorMessege;

  Future<bool> signIn(String email, String password) async
  {
    bool isSuccess = false;
    _inProgress = true;
    update();
    Map<String, dynamic> reqBody =
    {
      "email" : email,
      "password" : password
    };
    final NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.login,
        body: reqBody
    );
    if(response.isSuccess)
    {
      final data = response.responseData['data'];
      await AuthController.saveUserData(
          token: response.responseData['token'],
          email: data['email'],
          firstName: data['firstName'],
          lastName: data['lastName'],
          phone: data['mobile'],
          photo: 'profile_image.png'
      );
      isSuccess = true;
    }
    else
    {
      _errorMessege = response.errorMessege;

    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}