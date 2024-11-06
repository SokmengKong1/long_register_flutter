import 'package:add_card_shop/App_route/route_App.dart';
import 'package:add_card_shop/repository/post/login_repositories.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../data/app_exception.dart';

class AuthControllers extends GetxController {
  var usernameController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;
  var loadingLogin = false.obs;
  var _loginReposoitory = LoginRepositories();

  Future<void> login() async {
    if (usernameController.value.text.isEmpty) {
      Get.snackbar("Error", "Please Enter Your UserName");
    }
    if (passwordController.value.text.isEmpty) {
      Get.snackbar("Error", "Please Enter Your Password");
    }
    loadingLogin(true);
    try {
      var response = await _loginReposoitory.login(
          username: usernameController.value.text,
          password: passwordController.value.text);
      Get.offAllNamed(Route_App.postSplash);
      _loginReposoitory.saveUserLocal(response);
    } on UnAuthorization {
      Get.snackbar("Error", "your username and password incorrect!");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      loadingLogin(false);
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
}
