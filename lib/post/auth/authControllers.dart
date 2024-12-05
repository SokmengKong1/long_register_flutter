import 'package:add_card_shop/App_route/route_App.dart';
import 'package:add_card_shop/model/postRegister/product/post_body_request.dart';
import 'package:add_card_shop/model/postRegister/product/post_response.dart';
import 'package:add_card_shop/repository/post/login_repositories.dart';
import 'package:add_card_shop/repository/post/repository_product/repositories_All.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../data/app_exception.dart';

class AuthControllers extends GetxController {
  var usernameController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;
  var loadingLogin = false.obs;
  var _loginReposoitory = LoginRepositories();
  var postSearchList = <PostResponse>[].obs;
  final _postRepository = RepositoriesAll();
  var loading = true.obs;
  //
  // Future<void> login() async {
  //   if (usernameController.value.text.isEmpty) {
  //     Get.snackbar("Error", "Please Enter Your UserName");
  //   }
  //   if (passwordController.value.text.isEmpty) {
  //     Get.snackbar("Error", "Please Enter Your Password");
  //   }
  //   loadingLogin(true);
  //   try {
  //     var response = await _loginReposoitory.login(
  //         username: usernameController.value.text,
  //         password: passwordController.value.text);
  //     Get.offAllNamed(Route_App.postSplash);
  //     _loginReposoitory.saveUserLocal(response);
  //   } on UnAuthorization {
  //     Get.snackbar("Error", "your username and password incorrect!");
  //   } catch (e) {
  //     Get.snackbar("Error", e.toString());
  //   } finally {
  //     loadingLogin(false);
  //   }
  // }


  Future<void> login() async {
    if (usernameController.value.text.isEmpty) {
      Get.snackbar("Error", "Please Enter Your Username");
      return; // Prevent further execution if username is empty
    }

    if (passwordController.value.text.isEmpty) {
      Get.snackbar("Error", "Please Enter Your Password");
      return; // Prevent further execution if password is empty
    }

    loadingLogin(true); // Show loading indicator

    try {
      // Call the login repository
      var response = await _loginReposoitory.login(
        username: usernameController.value.text,
        password: passwordController.value.text,
      );

      // Save the user locally
      await _loginReposoitory.saveUserLocal(response);

      // Navigate to the post-splash screen
      Get.offAllNamed(Route_App.postSplash);
    } on UnAuthorization {
      // Show error for incorrect credentials
      Get.snackbar("Error", "Your username or password is incorrect!");
    } catch (e) {
      // Log and display generic error
      print("Login Error: $e");
      Get.snackbar("Error", "An unexpected error occurred. Please try again.");
    } finally {
      loadingLogin(false); // Hide loading indicator
    }
  }


  Future<void> remove() async {
    loadingLogin(true);
    try {
      Get.offAllNamed(Route_App.loginView);
      await _loginReposoitory.removeUserLocal();
    } on UnAuthorization {
      Get.snackbar("Error", "your username and password incorrect!");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      loadingLogin(false);
    }
  }

  onSearch(String? name) async {
    if (name == null || name.trim().isEmpty) {
      postSearchList.value = [];
      return; // Exit if search query is empty
    }
    loading(true); // Indicate loading state
    postSearchList.value =[]; // Clear previous search results
    try {
      var request = PostBodyRequest(status: "ACT", name: name);
      var response = await _postRepository.getAllPosts(request);
      if (response.data != null) {
        response.data.forEach((data) {
          postSearchList.add(PostResponse.fromJson(data));
        });
      }
    } finally {
      loading(false); // Reset loading state
    }
  }
}
