import 'package:add_card_shop/App_route/route_App.dart';
import 'package:add_card_shop/post/view/show/product_view.dart';
import 'package:add_card_shop/post/view/show/product_view.dart';
import 'package:add_card_shop/post/view/show/product_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        color: Colors.indigo,
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home, color: Colors.white),
              onPressed: () {
                Get.toNamed(Route_App.showpost);
              },
            ),
            IconButton(
              icon: Icon(Icons.add, color: Colors.white),

              onPressed: () {
                Get.toNamed(Route_App.productView);
              },
            ),
            IconButton(
              icon: Icon(Icons.person, color: Colors.white),
                onPressed: () {
                  Get.toNamed(Route_App.profile);
                }
            ),
          ],
        ),
      ),
    );
  }
}
