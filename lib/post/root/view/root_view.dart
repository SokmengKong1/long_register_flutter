import 'package:add_card_shop/App_route/route_App.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../auth/authControllers.dart';
import '../../splash/controller/splash_controller.dart';

class RootView extends StatelessWidget {
  var splashController = Get.put(SplashController());
  AuthControllers authControllers = Get.put(AuthControllers());
  RootView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        leading: Icon(Icons.grid_view, color: Colors.white),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "New App",
              style: TextStyle(color: Colors.white),
            ),
            InkWell(
              onTap: () => {
                //Get.toNamed(RouteName.profile)
                authControllers.remove()
              },
              child: Icon(Icons.account_circle, color: Colors.white),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: 20),
              margin: EdgeInsets.only(left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(20),
                      width: double.infinity,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Center(
                        child: Text(
                          "Hello",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => {Get.toNamed(Route_App.postManageCategory)},
                      child: Container(
                        padding: EdgeInsets.all(20),
                        width: double.infinity,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Center(
                          child: Text(
                            'Category',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.indigo,
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home, color: Colors.white),
              onPressed: () {
                // Navigate to home or perform an action
              },
            ),
            IconButton(
              icon: Icon(Icons.favorite, color: Colors.white),
              onPressed: () {
                // Navigate to favorites or perform an action
              },
            ),
            IconButton(
              icon: Icon(Icons.person, color: Colors.white),
              onPressed: () {
                Get.toNamed(Route_App.profile);
              },
            ),
          ],
        ),
      ),
    );
  }
}
