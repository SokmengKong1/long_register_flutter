import 'package:add_card_shop/post/root/view/profile_view.dart';
import 'package:add_card_shop/post/view/login_view.dart';
import 'package:add_card_shop/post/view/register_o_view.dart';
import 'package:add_card_shop/post/view/register_view.dart';
import 'package:add_card_shop/post/view/show/create_post/postFormView.dart';
import 'package:add_card_shop/post/view/show/create_post/post_category_formView.dart';
import 'package:add_card_shop/post/view/show/product_view.dart';
import 'package:add_card_shop/post/view/show/show_data/add_CardOn.dart';
import 'package:add_card_shop/post/view/show/show_data/detail_Cart.dart';
import 'package:add_card_shop/post/view/show/show_data/show_Grid.dart';
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
  static const String profile = "/post/manage/profile";
  static const String register = "/post/login/register";
  static const String productView = "/post/productView";
  static const String createView = "/post/create";
  static const String showpost = "/post/show";
  static const String detailCart = "/post/detail";
  static const String fromCreate = "/post/fromCreate/view";
  static const String postManageCreateCategoryPath = "/post/manage/category/create";
  static const String searchPageInfo = "/Search/pageInfo";
  static const String addCardOn  = "/AddCardON";
  // static const String register_O_view = "/post/login/register";

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
    GetPage(
        name: Route_App.productView,
        page: () => ProductView(),
        transition: Transition.rightToLeft),
    GetPage(
        name: Route_App.profile,
        page: () => ProfileView(),
        transition: Transition.rightToLeft),
    GetPage(
        name: Route_App.createView,
        page: () => PostCategoryFormView(),
        transition: Transition.rightToLeft),
    GetPage(
        name: Route_App.showpost,
        page: () => ShowPost(),
        transition: Transition.rightToLeft),
    GetPage(
        name: Route_App.detailCart,
        page: () => DetailCart(),
        transition: Transition.rightToLeft),
    GetPage(
        name: Route_App.postManageCreateCategoryPath,
        page: () => PostFormView(),
        transition: Transition.rightToLeft),
    GetPage(
        name: Route_App.addCardOn,
        page: () => AddCardon(),
        transition: Transition.rightToLeft),
    // GetPage(
    //     name: Route_App.searchPageInfo,
    //     page: () => SearchPage(),
    //     transition: Transition.leftToRight),
  ];
}