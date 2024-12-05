import 'package:get/get.dart';

import '../constants/constants.dart';

class AppLanguage extends Translations{
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
    "en_US":{
      Constants.appName:"LOGIN",
      Constants.password:"Password",
      Constants.username:"Usernaem",
      Constants.create:"Create new account ",

    },
    "km_KH":{
      Constants.appName:"ហាងអន់ឡាញ ",
      Constants.password:"ពាក្យសម្អាត់ ",
      Constants.username:"ឈ្មោះអ្នកប្រើប្រាស់ ",
      Constants.create:"បង្កើតគណនេយ្យថ្មី",
    }
  };


}