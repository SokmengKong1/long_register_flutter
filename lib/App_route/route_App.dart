import 'package:add_card_shop/post/view/login_view.dart';
import 'package:add_card_shop/post/view/register_o_view.dart';
import 'package:add_card_shop/post/view/register_view.dart';
import 'package:add_card_shop/view/Add_Card/add_Card.dart';
import 'package:add_card_shop/view/homeScreen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

import '../post/splash/view/splash_view.dart';


class Route_App{
  static const String home  = "/";
  static const String addCard  = "/AddCard";
  static const String loginView  = "/Login";
  static const String postSplash = "/post/splash";
  static const String homeScreen = '/';
  static const String productScreen = '/product';
  static const String loginScreen = '/login';
  static const String productDetailView = '/product/details';
  static const String postRoot = '/post/root';
  static const String postLogin = '/post/login';
  static const String postManageCategory = "/post/manage/categories";
  static const String profile = "/post/manage/categories/profile";
  static const String register = "/post/login/register";
  static const String register_O_view = "/post/login/register";

}
class routeApp{
  static appRoute()=>[
    GetPage(
        name: Route_App.home,
        page: () => Homescreen(),
        transition: Transition.leftToRight),
    GetPage(
        name: Route_App.addCard,
        page: () => AddCard(),
        transition: Transition.leftToRight),






    GetPage(
        name: Route_App.loginView,
        page: () => LoginView(),
        transition: Transition.leftToRight),
    GetPage(
        name: Route_App.postSplash,
        page: () => SplashView(),
        transition: Transition.rightToLeft),
    GetPage(
        name: Route_App.register,
        page: () => RegisterView(),
        transition: Transition.rightToLeft),
    // GetPage(
    //     name: Route_App.register_O_view,
    //     page: () => RegisterOView(),
    //     transition: Transition.rightToLeft),
  ];
}