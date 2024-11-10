import 'package:flutter/material.dart';
import 'package:add_card_shop/App_route/route_App.dart';
import 'package:badges/badges.dart' as badges;
import 'package:get/get.dart';

import '../../auth/authControllers.dart';

class NavbarView extends StatelessWidget implements PreferredSizeWidget {
  final AuthControllers authControllers = Get.put(AuthControllers());

  NavbarView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.indigo,
      title: Text("Product List"),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: InkWell(
            onTap: () {
              // authControllers.remove();
              Get.toNamed(Route_App.createView);
            },
            child: Icon(
              Icons.logout,
              size: 30,
            ),
          ),

        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
