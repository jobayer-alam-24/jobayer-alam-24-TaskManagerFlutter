import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:task_manager/app.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/ui/controllers/auth_controller.dart';
import 'package:task_manager/ui/screens/sign_in_screen.dart';


class NetworkCaller {
  static Future<NetworkResponse> getRequest({required String url}) async
  {
    try
    {
      Uri uri = Uri.parse(url);
      Map<String, String> headers = {
        'token' : AuthController.accessToken.toString(),
      };
      debugPrint(url);
      final response = await get(uri, headers: headers);
      printResponse(url, response);
      if(response.statusCode == 200 || response.statusCode == 201)
      {
        final decodedData = jsonDecode(response.body);
        return NetworkResponse(
            isSuccess: true,
            statusCode: response.statusCode,
            responseData: decodedData
        );
      }else if(response.statusCode == 401)
      {
        _moveToLogin();
        return NetworkResponse(
            isSuccess: false,
            statusCode: response.statusCode,
            errorMessege: 'Unauthenticated user.'
        );
      }
      else {
        return NetworkResponse(
            isSuccess: false,
            statusCode: response.statusCode,
        );
      }
    }
    catch(e)
    {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessege: e.toString()
      );
    }
  }

  static Future<NetworkResponse> postRequest(
      {required String url, Map<String, dynamic>? body}) async
  {
    try
    {
      Uri uri = Uri.parse(url);
      debugPrint(url);
      final response = await post(uri,
          headers: {
            'Content-Type' : 'application/json',
            'token' : AuthController.accessToken.toString()
          },
          body: jsonEncode(body),
      );
      printResponse(url, response);
      if(response.statusCode == 200 || response.statusCode == 201)
      {
        final decodedData = jsonDecode(response.body);
        if(decodedData['status'] == "fail")
          {
            return NetworkResponse(
                isSuccess: false,
                statusCode: response.statusCode,
                errorMessege: decodedData["data"]
            );
          }else if(response.statusCode == 401)
            {
              _moveToLogin();
              return NetworkResponse(
                  isSuccess: false,
                  statusCode: response.statusCode,
                  errorMessege: 'Unauthenticated user.'
              );
            }
        return NetworkResponse(
            isSuccess: true,
            statusCode: response.statusCode,
            responseData: decodedData
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      }
    }
    catch(e)
    {
      return NetworkResponse(
          isSuccess: false,
          statusCode: -1,
          errorMessege: e.toString()
      );
    }
  }

  static void printResponse(String url, Response response)
  {
    debugPrint("\nURL: $url \n. RESPONSE CODE: ${response.statusCode}\bBODY: ${response.body}");
  }
  static Future<void> _moveToLogin()
  async {
    await AuthController.ClearUserData();
    Navigator.pushAndRemoveUntil(TaskManagerApp.navigatorKey.currentContext!, MaterialPageRoute(builder: (context) => const SignInScreen()), (_) => false);
  }
}