import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:add_card_shop/model/login/login_rep.dart';
import 'package:add_card_shop/model/login/login_req.dart';
import 'package:get_storage/get_storage.dart';

import '../app_exception.dart';
import 'base_url_app.dart';
import 'package:http/http.dart' as http;

class NetworkUrlApp implements BaseApiService {
  @override
  Future getApi(String url) async {
    dynamic responseJson;
    try {
      var response =
          await http.get(Uri.parse(url)).timeout(Duration(seconds: 20));
      switch (response.statusCode) {
        case 200:
          responseJson = jsonDecode(response.body);
          break;
        case 500:
          return NoInternetConnectionException();
      }
    } on SocketException {
      throw NoInternetConnectionException();
    } on TimeoutException {
      throw RequestTimeout();
    }
    return responseJson;
  }

  @override
  Future postApi(String url, requestBody) async {
    dynamic responseJson;
    try {
      var storage = GetStorage();
      var user = LoginRep.fromJson(storage.read("USER_KEY"));
      var token = "";
      if (null != user.refreshToken) {
        token = user.accessToken ?? "";
      }
      var headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${token}"
      };
      var response = await http
          .post(Uri.parse(url), headers: headers, body: jsonEncode(requestBody))
          .timeout(Duration(seconds: 20)); // Timeo
      switch (response.statusCode) {
        case 200:
          responseJson = jsonDecode(response.body);
          break;
        case 401:
          throw UnAuthorization();
        case 500:
          throw InternetServerException();
      }
    } on SocketException {
      throw InternetServerException();
    } on RequestTimeout {
      throw RequestTimeout();
    }
    return responseJson;
  }

  @override
  Future loginApi(String url, requestBody) async {
    dynamic responseJson;
    try {
      var headers = {
        "Content-Type": "application/json",
      };
      var response = await http
          .post(Uri.parse(url), headers: headers, body: jsonEncode(requestBody))
          .timeout(Duration(seconds: 20)); // Timeout after 20 seconds
      switch (response.statusCode) {
        case 200:
          responseJson = jsonDecode(response.body);
          break;
        case 401:
          throw UnAuthorization();
        // if (await refreshTokenApi() == true) {
        //   print("Retry");
        // } else {
        //   print("Logout");
        // }
        case 500:
          throw InternetServerException();
      }
    } on SocketException {
      throw InternetServerException();
    } on RequestTimeout {
      throw RequestTimeout();
    }
    catch (e) {
      // Handle other types of exceptions
      print('Other error: $e');
    }

    return responseJson;
  }
  @override
  Future register(String url, requestBody) async {
    dynamic responseJson;
    try {
      var headers = {
        "Content-Type": "application/json",
      };
      var response = await http
          .post(Uri.parse(url), headers: headers, body: jsonEncode(requestBody))
          .timeout(Duration(seconds: 20));

      switch (response.statusCode) {
        case 200:
          responseJson = jsonDecode(response.body);
          break;
        case 401:
          throw UnAuthorization();
        case 500:
          throw InternetServerException();
      }
    } on SocketException {
      throw InternetServerException();
    } on RequestTimeout {
      throw RequestTimeout();
    }
    catch (e) {
      // Handle other types of exceptions
      print('Other error: $e');
    }

    return responseJson;
  }
}
