// import 'package:add_card_shop/App_route/route_App.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../auth/authControllers.dart';
//
// class LoginView extends StatefulWidget {
//   const LoginView({super.key});
//
//   @override
//   State<LoginView> createState() => _LoginViewState();
// }
//
// class _LoginViewState extends State<LoginView> {
//   AuthControllers authControllers = Get.put(AuthControllers());
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text("Logins"),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                 textAlign: TextAlign.center,
//                 "Logins",
//                 style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.all(16),
//               child: TextFormField(
//                 controller: authControllers.usernameController.value,
//                 decoration: InputDecoration(
//                     prefixIcon: Icon(Icons.account_circle_rounded),
//                     hintText: "username",
//                     labelText: "username"),
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.all(16),
//               child: TextFormField(
//                 obscureText: true,
//                 controller: authControllers.passwordController.value,
//                 decoration: InputDecoration(
//                     prefixIcon: Icon(Icons.lock),
//                     hintText: "password",
//                     labelText: "password"),
//               ),
//             ),
//             Row(
//               children: [
//                 Column(
//                   children: [
//                     Container(
//                       margin: EdgeInsets.only(left: 16),
//                       child: InkWell(
//                         onTap: ()=>{
//                           Get.toNamed(Route_App.register)
//                         },
//                         child: Text(
//                           "register",
//                           style: TextStyle(color: Colors.blue),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//
//             GestureDetector(
//               onTap: () {
//                 authControllers.login();
//               },
//               child: Container(
//                   width: double.infinity,
//                   margin: const EdgeInsets.all(16),
//                   padding: const EdgeInsets.only(top: 15, bottom: 15),
//                   decoration: BoxDecoration(
//                       color: Colors.indigo,
//                       borderRadius: BorderRadius.all(Radius.circular(14))),
//                   child: Obx(() {
//                     if (authControllers.loadingLogin.value) {
//                       return Center(
//                         child: CircularProgressIndicator(color: Colors.white),
//                       );
//                     }
//                     return Text(
//                       textAlign: TextAlign.center,
//                       "Logins",
//                       style: TextStyle(),
//                     );
//                   })),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
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
  final AuthControllers authControllers = Get.put(AuthControllers());
  final RxBool _isPasswordHidden = true.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 0, // Hide app bar, making it more similar to Facebook
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 60),

              // Logo Section
              Center(
                child: Image.asset(
                  'assets/logo.png', // Add your logo image asset here
                  height: 100,
                ),
              ),
              const SizedBox(height: 40),

              // Username Field
              TextFormField(
                controller: authControllers.usernameController.value,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.account_circle_rounded),
                  hintText: "Username or email",
                  labelText: "Username",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Password Field with Show/Hide Icon
              Obx(() => TextFormField(
                obscureText: _isPasswordHidden.value,
                controller: authControllers.passwordController.value,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordHidden.value
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      _isPasswordHidden.value = !_isPasswordHidden.value;
                    },
                  ),
                  hintText: "Password",
                  labelText: "Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              )),
              const SizedBox(height: 16),

              // Register Link
              Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: () => Get.toNamed(Route_App.register),
                  child: Text(
                    "Create new account",
                    style: TextStyle(
                      color: Colors.blue.shade700,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Login Button
              GestureDetector(
                onTap: authControllers.login,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade800,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Obx(() {
                    return authControllers.loadingLogin.value
                        ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                        : const Center(
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 16),

              // Forgot Password
              InkWell(
                onTap: () {
                  // Navigate to forgot password page or show a dialog
                },
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(
                    color: Colors.blue.shade700,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
