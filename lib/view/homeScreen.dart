import 'package:add_card_shop/App_route/route_App.dart';
import 'package:add_card_shop/model_view_model/widget/list_product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../post/auth/authControllers.dart';
class Homescreen extends StatefulWidget {

  const Homescreen({Key? key}) : super(key: key);

  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final AuthControllers authControllers = Get.put(AuthControllers());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text("Product List"),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: badges.Badge(
              badgeContent: Text(
                '0',
                style: TextStyle(color: Colors.blue),
              ),
              badgeAnimation: badges.BadgeAnimation.scale(),
              child: InkWell(
                onTap: () {
                  Get.toNamed(Route_App.addCard);
                },
                child: Icon(
                  Icons.shopping_bag_outlined,
                  size: 30,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: badges.Badge(
              badgeContent: Text(
                '5',
                style: TextStyle(color: Colors.white),
              ),
              badgeAnimation: badges.BadgeAnimation.scale(),
              child: InkWell(
                onTap: () {
                  // Add functionality for the second icon here
                  authControllers.remove();
                },
                child: Icon(
                  Icons.sign_language,
                  size: 30,
                ),
              ),
            ),
          ),
        ],
      ),
      body: ListProduct(),
    );
  }
}

