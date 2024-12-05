import 'package:add_card_shop/App_route/route_App.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.teal,
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: const Icon(Icons.home, color: Colors.white),
            onPressed: () {
              // Navigate to home and trigger a rebuild of NavbarView
              Get.offAllNamed(Route_App.showpost);
            },
          ),
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () {
              // Navigate to product view and trigger a rebuild of NavbarView
              Get.toNamed(Route_App.productView);
            },
          ),
          IconButton(
            icon: const Icon(Icons.person, color: Colors.white),
            onPressed: () {
              // Navigate to profile and trigger a rebuild of NavbarView
              Get.toNamed(Route_App.profile);
            },
          ),
        ],
      ),
    );
  }
}
