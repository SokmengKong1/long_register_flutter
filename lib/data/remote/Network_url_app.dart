// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
// import 'package:add_card_shop/model/login/login_rep.dart';
// import 'package:add_card_shop/model/login/login_req.dart';
// import 'package:get_storage/get_storage.dart';
//
// import '../app_exception.dart';
// import 'base_url_app.dart';
// import 'package:http/http.dart' as http;
//
// class NetworkUrlApp implements BaseApiService {
//   @override
//   Future getApi(String url) async {
//     dynamic responseJson;
//     try {
//       var response =
//           await http.get(Uri.parse(url)).timeout(Duration(seconds: 20));
//       switch (response.statusCode) {
//         case 200:
//           responseJson = jsonDecode(response.body);
//           break;
//         case 500:
//           return NoInternetConnectionException();
//       }
//     } on SocketException {
//       throw NoInternetConnectionException();
//     } on TimeoutException {
//       throw RequestTimeout();
//     }
//     return responseJson;
//   }
//
//   @override
//   Future postApi(String url, requestBody) async {
//     dynamic responseJson;
//     try {
//       var storage = GetStorage();
//       var user = LoginRep.fromJson(storage.read("USER_KEY"));
//       var token = "";
//       if (null != user.refreshToken) {
//         token = user.accessToken ?? "";
//       }
//       var headers = {
//         "Content-Type": "application/json",
//         "Authorization": "Bearer ${token}"
//       };
//       var response = await http
//           .post(Uri.parse(url), headers: headers, body: jsonEncode(requestBody))
//           .timeout(Duration(seconds: 20)); // Timeo
//       switch (response.statusCode) {
//         case 200:
//           responseJson = jsonDecode(response.body);
//           break;
//         case 401:
//           throw UnAuthorization();
//         case 500:
//           throw InternetServerException();
//       }
//     } on SocketException {
//       throw InternetServerException();
//     } on RequestTimeout {
//       throw RequestTimeout();
//     }
//     return responseJson;
//   }
//
//   @override
//   Future loginApi(String url, requestBody) async {
//     dynamic responseJson;
//     try {
//       var headers = {
//         "Content-Type": "application/json",
//       };
//       var response = await http
//           .post(Uri.parse(url), headers: headers, body: jsonEncode(requestBody))
//           .timeout(Duration(seconds: 20)); // Timeout after 20 seconds
//       switch (response.statusCode) {
//         case 200:
//           responseJson = jsonDecode(response.body);
//           break;
//         case 401:
//           throw UnAuthorization();
//         // if (await refreshTokenApi() == true) {
//         //   print("Retry");
//         // } else {
//         //   print("Logout");
//         // }
//         case 500:
//           throw InternetServerException();
//       }
//     } on SocketException {
//       throw InternetServerException();
//     } on RequestTimeout {
//       throw RequestTimeout();
//     }
//     catch (e) {
//       // Handle other types of exceptions
//       print('Other error: $e');
//     }
//
//     return responseJson;
//   }
//   @override
//   Future register(String url, requestBody) async {
//     dynamic responseJson;
//     try {
//       var headers = {
//         "Content-Type": "application/json",
//       };
//       var response = await http
//           .post(Uri.parse(url), headers: headers, body: jsonEncode(requestBody))
//           .timeout(Duration(seconds: 20));
//
//       switch (response.statusCode) {
//         case 200:
//           responseJson = jsonDecode(response.body);
//           break;
//         case 401:
//           throw UnAuthorization();
//         case 500:
//           throw InternetServerException();
//       }
//     } on SocketException {
//       throw InternetServerException();
//     } on RequestTimeout {
//       throw RequestTimeout();
//     }
//     catch (e) {
//       // Handle other types of exceptions
//       print('Other error: $e');
//     }
//
//     return responseJson;
//   }
//   @override
//   Future uploadImage(String url, requestBody) {
//     // TODO: implement uploadImage
//     throw UnimplementedError();
//   }
//
// }


import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:add_card_shop/App_route/route_App.dart';
import 'package:add_card_shop/data/remote/api_url.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

import '../app_exception.dart';
import 'base_url_app.dart';
import 'package:flutter/material.dart';

import 'package:add_card_shop/model/login/login_rep.dart';






class NetworkUrlApp implements BaseApiService {
  @override
  Future<dynamic> getApi(String url) async {
    dynamic responseJson;

    try {
      var response = await http.get(Uri.parse(url)).timeout(
          Duration(seconds: 20));

      switch (response.statusCode) {
        case 200:
          responseJson = jsonDecode(response.body);
          break;
        case 500:
          throw InternetServerException();
        default:
          throw Exception(
              "Unexpected error. Status Code: ${response.statusCode}");
      }
    } on SocketException {
      throw NoInternetConnectionException();
    } on TimeoutException {
      throw RequestTimeout();
    }

    return responseJson;
  }

  @override
  Future<dynamic> postApi(String url, dynamic requestBody) async {
    dynamic responseJson;

    try {
      var storage = GetStorage();
      var user = LoginRep.fromJson(storage.read("USER_KEY"));
      var token = user.accessToken ?? "";
      var headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
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
        default:
          throw Exception(
              "Unexpected error. Status Code: ${response.statusCode}");
      }
    } on SocketException {
      throw InternetServerException();
    } on TimeoutException {
      throw RequestTimeout();
    }

    return responseJson;
  }

  @override
  Future<dynamic> loginApi(String url, dynamic requestBody) async {
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
          // Assuming your response contains `accessToken` and `refreshToken`
          var accessToken = responseJson['accessToken'];
          var refreshToken = responseJson['refreshToken'];

          // Save the tokens to local storage
          var storage = GetStorage();
          storage.write("USER_KEY", {
            'accessToken': accessToken,
            'refreshToken': refreshToken,
          });

          break;
        case 401:
          throw UnAuthorization();
        case 500:
          throw InternetServerException();
        default:
          throw Exception(
              "Unexpected error. Status Code: ${response.statusCode}");
      }
    } on SocketException {
      throw InternetServerException();
    } on TimeoutException {
      throw RequestTimeout();
    } catch (e) {
      print("Error during login: $e");
    }

    return responseJson;
  }


  @override
  Future<dynamic> register(String url, dynamic requestBody) async {
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
        default:
          throw Exception(
              "Unexpected error. Status Code: ${response.statusCode}");
      }
    } on SocketException {
      throw InternetServerException();
    } on TimeoutException {
      throw RequestTimeout();
    } catch (e) {
      print("Error during registration: $e");
    }

    return responseJson;
  }

  @override
  Future<Map<String, dynamic>> handleResponse(
      http.StreamedResponse response) async {
    final responseBody = await response.stream.bytesToString();
    print("Server Response: $responseBody");

    try {
      return jsonDecode(responseBody) as Map<String, dynamic>;
    } catch (e) {
      print("Error parsing response: $e");
      throw Exception("Failed to parse response");
    }
  }

  Future<Map<String, String>?> refreshTokenApi() async {
    try {
      // Retrieve the stored refresh token
      var storage = GetStorage();
      var user = storage.read("USER_KEY");
      var refreshToken = user?['refreshToken'];
      if (refreshToken == null) {
        print("No refresh token found.");
        return null;
      }

      // Define the refresh token API endpoint
      const String refreshTokenUrl = 'https://your-api.com/refresh-token';

      // Prepare headers and body
      var headers = {
        "Content-Type": "application/json",
      };

      var requestBody = {
        "refreshToken": refreshToken,
      };

      // Send POST request to refresh the token
      var response = await http
          .post(Uri.parse(refreshTokenUrl), headers: headers,
          body: jsonEncode(requestBody))
          .timeout(Duration(seconds: 20));

      if (response.statusCode == 200) {
        var responseJson = jsonDecode(response.body);
        var newAccessToken = responseJson['accessToken'];
        var newRefreshToken = responseJson['refreshToken'];

        // Update the storage with new tokens
        user['accessToken'] = newAccessToken;
        user['refreshToken'] = newRefreshToken;
        storage.write("USER_KEY", user);

        print("Token refreshed successfully.");
        return {'accessToken': newAccessToken, 'refreshToken': newRefreshToken};
      } else {
        print("Failed to refresh token. Status code: ${response.statusCode}");
        return null;
      }
    } on SocketException {
      print("No internet connection.");
      return null;
    } on TimeoutException {
      print("Token refresh request timed out.");
      return null;
    } catch (e) {
      print("Error refreshing token: $e");
      return null;
    }
  }



  Future<dynamic> uploadImageApi(String url, File imageFile) async {
    // if (kDebugMode) {
    //   print("UPLOAD IMAGE REQUEST URL $url");
    // }

    dynamic responseJson;
    try {
      var storage = GetStorage();

      if (storage.read("USER_KEY") == null) {
        Get.offAllNamed(Route_App.postSplash);
      }

      var user = LoginRep.fromJson(storage.read("USER_KEY"));
      var token = user.accessToken ?? "";

      var request = http.MultipartRequest('POST', Uri.parse(url))
        ..headers['Authorization'] = 'Bearer $token'
        ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      // if (kDebugMode) {
      //   print("STATUS CODE UPLOAD: ${response.statusCode}");
      //   print("RESPONSE UPLOAD: $responseBody");
      // }

      switch (response.statusCode) {
        case 200:
          responseJson = jsonDecode(responseBody);
          print("UPLOAD IMAGE SUCCESS");
          break;
        case 401:
          print("UPLOAD IMAGE CODE 401 - Unauthorized");
          if (await refreshTokenApi() == true) {
            responseJson = await uploadImageApi(url, imageFile); // Retry after refreshing token
          } else {
            Get.offAllNamed(Route_App.postSplash);
          }
          break;
        case 403:
          print("UPLOAD IMAGE CODE 403 - Forbidden");
          if (await refreshTokenApi() == true) {
            responseJson = await uploadImageApi(url, imageFile); // Retry after refreshing token
          } else {
            Get.offAllNamed(Route_App.postSplash);
          }
          break;
        case 500:
          throw InternetServerException();
        default:
          throw Exception("Failed to upload image");
      }
    } on SocketException {
      throw NoInternetConnectionException();
    } on TimeoutException {
      throw RequestTimeout();
    }

    // if (kDebugMode) {
    //   print("UPLOAD IMAGE RESPONSE BODY: $responseJson\n");
    // }
    return responseJson;
  }





  Future<Map<String, dynamic>> uploadImage(File image) async {
    var storage = GetStorage();
    final url = Uri.parse(ApiUrl.uploadImage);
    // Map<String, dynamic> responseJson;
    dynamic responseJson;
    try {
      // Create a multipart request
      var request = http.MultipartRequest("POST", url);

      // Attach the image file as a multipart file
      final mimeTypeData = lookupMimeType(image.path)!.split('/'); // Get mime type
      request.files.add(
        http.MultipartFile(
          'File',
          image.readAsBytes().asStream(),
          image.lengthSync(),
          filename: image.path.split('/').last,
          contentType: MediaType(mimeTypeData[0], mimeTypeData[1]),
        ),
      );

      // Retrieve and set the authorization token
      var user = LoginRep.fromJson(storage.read("USER_KEY"));
      var token = user.accessToken ?? "";
      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Cache-Control'] = 'no-cache';
      request.headers['Accept'] = '*/*';

      // Send the request
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      switch(response.statusCode){
        case 200:
          responseJson = jsonDecode(responseBody);
          print("Image uploaded successfully2: ${responseJson["data"]['data']}");
        case 401:
          if (await refreshTokenApi() == true) {
            print("ON RETRY REFRESH");
            responseJson = await refreshUploadImage(image);

          } else {
            storage.remove("USER_KEY");
            Get.offAllNamed(Route_App.postSplash);
          }
        case 500:
          throw InternetServerException();
        default:
          throw Exception("Failed to upload image");
      }
    } catch (e) {
      print("Image upload failed: $e");
      throw Exception("Image upload failed: $e");
    }

    return responseJson;
  }


  Future<Map<String, dynamic>> refreshUploadImage(File image) async {
    var storage = GetStorage();
    final url = Uri.parse(ApiUrl.uploadImage);
    // Map<String, dynamic> responseJson;
    dynamic responseJson;

    try {
      // Create a multipart request
      var request = http.MultipartRequest("POST", url);

      // Attach the image file as a multipart file
      final mimeTypeData = lookupMimeType(image.path)!.split('/'); // Get mime type
      request.files.add(
        http.MultipartFile(
          'File',
          image.readAsBytes().asStream(),
          image.lengthSync(),
          filename: image.path.split('/').last,
          contentType: MediaType(mimeTypeData[0], mimeTypeData[1]),
        ),
      );

      // Retrieve and set the authorization token
      var user = LoginRep.fromJson(storage.read("USER_KEY"));
      var token = user.accessToken ?? "";
      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Cache-Control'] = 'no-cache';
      request.headers['Accept'] = '*/*';

      // Send the request
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      switch(response.statusCode){
        case 200:
          responseJson = jsonDecode(responseBody);
          print("Image uploaded successfully2: ${responseJson["data"]['data']}");
        case 401:
          storage.remove("USER_KEY");
          Get.offAllNamed(Route_App.postSplash);
        case 500:
          throw InternetServerException();
        default:
          throw Exception("Failed to upload image");
      }
    } catch (e) {
      print("Image upload failed: $e");
      throw Exception("Image upload failed: $e");
    }

    return responseJson;
  }





  Future refreshTokenUploadImage(File image) async {
    final url = Uri.parse(ApiUrl.uploadImage);
    print("REFRESH TOKEN");
    dynamic responseJson;
    try {
      var storage = GetStorage();
      var user = LoginRep.fromJson(storage.read("USER_KEY"));
      var token = "";
      if (user.refreshToken != null) {
        token = user.accessToken ?? "";
      }
      try {
        // Create a multipart request
        var request = http.MultipartRequest("POST", url);

        // Attach the image file as a multipart file
        final mimeTypeData = lookupMimeType(image.path)!.split('/'); // Get mime type
        request.files.add(
          http.MultipartFile(
            'File',
            image.readAsBytes().asStream(),
            image.lengthSync(),
            filename: image.path.split('/').last,
            contentType: MediaType(mimeTypeData[0], mimeTypeData[1]),
          ),
        );

        // Retrieve and set the authorization token
        var user = LoginRep.fromJson(storage.read("USER_KEY"));
        var token = user.accessToken ?? "";
        request.headers['Authorization'] = 'Bearer $token';
        request.headers['Cache-Control'] = 'no-cache';
        request.headers['Accept'] = '*/*';

        // Send the request
        final response = await request.send();
        final responseBody = await response.stream.bytesToString();


        switch (response.statusCode) {
          case 200:
            responseJson = responseBody;
            print("REFRESH API CODE 200");
        // break;
          case 401:
            print("REFRESH API CODE 401");
            // if (await refreshTokenApi() == true) {
            //   print("ON RETRY REFRESH");
            // } else {
            storage.remove("USER_KEY");
            Get.offAllNamed(Route_App.postSplash);
        // }
          case 500:
            throw InternetServerException();
        }
      } catch (e) {
        print("Image upload failed: $e");
        throw Exception("Image upload failed: $e");
      }
    } on SocketException {
      throw NoInternetConnectionException();
    } on TimeoutException {
      throw RequestTimeout();
    }
    return responseJson;
  }



  @override
  Future postApiUploadImage(String url, File imageFile) async {
    dynamic responseJson;

    try {
      // Create a Multipart request
      var request = http.MultipartRequest('POST', Uri.parse(url));

      // Add headers
      request.headers['Authorization'] = 'Bearer your-token-here';
      request.headers['Content-Type'] = 'multipart/form-data';

      // Attach the image file
      request.files.add(
        await http.MultipartFile.fromPath(
          'image', // The name parameter here should match the expected key on the server
          imageFile.path,
        ),
      );

      // Send the request and get the response
      var response = await request.send();
      var responseString = await response.stream.bytesToString();

      print("STATUS CODE POST: ${response.statusCode}");
      print("RESPONSE POST: $responseString");

      // Parse the response
      switch (response.statusCode) {
        case 200:
          responseJson = jsonDecode(responseString);
          print("POST API CODE 200: Success");
          break;

        case 401:
          print("POST API CODE 401: Unauthorized");
          bool refreshed = await _handleTokenRefresh(url, imageFile);
          if (refreshed) {
            // Retry the request after the token is refreshed
            return await postApiUploadImage(url, imageFile); // Recursive call to retry the request
          } else {
            Get.offAllNamed(Route_App.postSplash); // Navigate to splash screen
            print("Unauthorized: Token refresh failed");
          }
          break;

        case 500:
          throw InternetServerException("Internal Server Error");

        default:
          throw HttpException("Unexpected status code: ${response.statusCode}");
      }
    } on SocketException {
      throw NoInternetConnectionException("No Internet Connection");
    } on TimeoutException {
      throw RequestTimeout("Request Timed Out");
    } catch (e) {
      // Log any other unexpected exceptions for debugging
      print("Unexpected error: $e");
      rethrow; // Rethrow the exception for higher-level handling
    }
    //
    // if (kDebugMode) {
    //   print("RESPONSE POST API BODY: $responseJson\n");
    // }
    return responseJson;
  }





  Future<bool> _handleTokenRefresh(String url, dynamic requestBody) async {
    try {
      Map<String, String>? response = await refreshTokenApi();
      if (response != null && response['status'] == 'success') {
        print("Token refreshed successfully, retrying POST request");
        return true;
      } else {
        print("Token refresh failed");
        return false;
      }
    } catch (e) {
      print("Error during token refresh: $e");
      return false;
    }
  }








}

