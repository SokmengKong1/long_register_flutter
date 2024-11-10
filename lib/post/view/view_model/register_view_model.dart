import 'package:add_card_shop/data/remote/Network_url_app.dart';
import 'package:add_card_shop/model/postRegister/registerLogin.dart';
import 'package:add_card_shop/repository/post/register_repositories.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../App_route/route_App.dart';

class RegisterViewModel extends GetxController{
  final RegisterRepositories _registerRepositories = RegisterRepositories();
  var registerRpo = RegisterRepositories();
  var onRegisterLoading = false.obs;
  var registerLogin = RegisterLogin().obs;
  var firstNameController = TextEditingController().obs;
  var lastNameController = TextEditingController().obs;
  var usernameController = TextEditingController().obs;
  var emailController = TextEditingController().obs;
  var phoneNumberController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;
  var confirmPasswordController = TextEditingController().obs;
  var profileController = TextEditingController().obs;
  var roleController = TextEditingController().obs;

  onRegister()async{
    try{
      onRegisterLoading(true);
      if (firstNameController.value.text.isEmpty) {
        Get.snackbar("Error", "please Enter FirstName");
        return;
      }
      if (lastNameController.value.text.isEmpty) {
        Get.snackbar("Error", "please Enter LastName");
        return;
      }
      if (usernameController.value.text.isEmpty) {
        Get.snackbar("Error", "please Enter Username");
        return;
      }
      if (emailController.value.text.isEmpty) {
        Get.snackbar("Error", "please Enter Email");
        return;
      } if (phoneNumberController.value.text.isEmpty) {
        Get.snackbar("Error", "please Enter phone");
        return;
      } if (passwordController.value.text.isEmpty) {
        Get.snackbar("Error", "please Enter password");
        return;
      }
      if (confirmPasswordController.value.text.isEmpty) {
        Get.snackbar("Error", "please Enter confirmPw");
        return;
      }
      if (profileController.value.text.isEmpty) {
        Get.snackbar("Error", "please Enter profile");
        return;
      }
      if (roleController.value.text.isEmpty) {
        Get.snackbar("Error", "please Enter role");
        return;
      }
      if(null != usernameController.value.text.isEmpty || null != passwordController.value.text.isEmpty){
        Get.toNamed(Route_App.loginView);
      }
      registerLogin.value.firstName = firstNameController.value.text;
      registerLogin.value.lastName = lastNameController.value.text;
      registerLogin.value.username = usernameController.value.text;
      registerLogin.value.email = emailController.value.text;
      registerLogin.value.phoneNumber = phoneNumberController.value.text;
      registerLogin.value.password = passwordController.value.text;
      registerLogin.value.confirmPassword = confirmPasswordController.value.text;
      registerLogin.value.profile = profileController.value.text;
      registerLogin.value.role =roleController.value.text;
      var response = await _registerRepositories.registerLogin(registerLogin.value);
      return response;
    }finally{
      onRegisterLoading (false);
    }
  }
}
