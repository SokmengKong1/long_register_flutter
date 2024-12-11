import 'package:add_card_shop/App_route/route_App.dart';
import 'package:add_card_shop/core/language/app_language.dart';
import 'package:add_card_shop/post/view/show/show_data/view_model/show_Grid_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  Get.put(ShowGridView());
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final storage = GetStorage();
    return GetMaterialApp(

    translations: AppLanguage(), // your translations
    locale:storage.read("KEY_STORAGE") == "KH" ? Locale('km', 'KH') : Locale('en', 'US'), // translations will be displayed in that locale
    fallbackLocale: storage.read("KEY_STORAGE") == "KH" ?  Locale('en', 'US') :Locale('km', 'KH') , // specify the fallback locale in case an invalid locale is selected.
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
        //initialRoute: Route_App.loginView,
      //initialRoute: Route_App.home,
      initialRoute: Route_App.postSplash,
      getPages: routeApp.appRoute(),

    );
  }
}
