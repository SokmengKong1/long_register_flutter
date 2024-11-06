import 'package:add_card_shop/App_route/route_App.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../auth/authControllers.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  AuthControllers authControllers = Get.put(AuthControllers());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Logins"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              child: Text(
                textAlign: TextAlign.center,
                "Logins",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
              ),
            ),
            Container(
              margin: EdgeInsets.all(16),
              child: TextFormField(
                controller: authControllers.usernameController.value,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.account_circle_rounded),
                    hintText: "username",
                    labelText: "username"),
              ),
            ),
            Container(
              margin: EdgeInsets.all(16),
              child: TextFormField(
                obscureText: true,
                controller: authControllers.passwordController.value,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    hintText: "password",
                    labelText: "password"),
              ),
            ),
            Row(
              children: [
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 16),
                      child: InkWell(
                        onTap: ()=>{
                          Get.toNamed(Route_App.register)
                        },
                        child: Text(
                          "register",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(left: 16),
                  child: InkWell(
                    onTap: ()=>{
                      Get.toNamed(Route_App.register_O_view)
                    },
                    child: Text(
                      "register_0",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
              ],
            ),

            GestureDetector(
              onTap: () {
                authControllers.login();
              },
              child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.only(top: 15, bottom: 15),
                  decoration: BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.all(Radius.circular(14))),
                  child: Obx(() {
                    if (authControllers.loadingLogin.value) {
                      return Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      );
                    }
                    return Text(
                      textAlign: TextAlign.center,
                      "Logins",
                      style: TextStyle(),
                    );
                  })),
            ),
          ],
        ),
      ),
    );
  }
}
