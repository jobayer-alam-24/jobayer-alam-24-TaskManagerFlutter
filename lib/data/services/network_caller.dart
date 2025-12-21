import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:task_manager/data/models/network_response.dart';

class NetworkCaller {
  static Future<NetworkResponse> getRequest(String url) async
  {
    try
    {
      Uri uri = Uri.parse(url);
      debugPrint(url);
      final response = await get(uri);
      printResponse(url, response);
      if(response.statusCode == 200)
      {
        final decodedData = jsonDecode(response.body);
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

  static Future<NetworkResponse> postRequest(String url, Map<String, dynamic>? body) async
  {
    try
    {
      Uri uri = Uri.parse(url);
      debugPrint(url);
      final response = await post(uri,
          headers: {
            'Content-Type' : 'application/json'
          },
          body: jsonEncode(body),
      );
      printResponse(url, response);
      if(response.statusCode == 200)
      {
        final decodedData = jsonDecode(response.body);
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

}