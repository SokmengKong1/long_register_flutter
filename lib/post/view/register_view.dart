// import 'package:add_card_shop/App_route/route_App.dart';
// import 'package:add_card_shop/post/view/view_model/register_view_model.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import '../../widget/custom_input_widget.dart';
//
// class RegisterView extends StatefulWidget {
//   @override
//   _RegisterViewState createState() => _RegisterViewState();
// }
//
// class _RegisterViewState extends State<RegisterView> {
//   // Define controllers for each input field
//   final _formKey = GlobalKey<FormState>();
//   final registerViewModel = Get.put(RegisterViewModel());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Register"),
//     leading: IconButton(
//     icon: Icon(Icons.arrow_back),
//     onPressed: () {
//     Navigator.pop(context);
//     },
//     ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//               CustomInputWidget(
//                 controller: registerViewModel.firstNameController.value,
//                 labelText: "FirstName",
//                 hintText: "Enter your FirstName",
//                 prefixIcon: Icon(Icons.person),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'First name is required';
//                   }
//                   return null;
//                 },
//               ),
//               // buildTextField("Role", roleController),
//               CustomInputWidget(
//                 controller: registerViewModel.lastNameController.value,
//                 labelText: "LastName",
//                 hintText: "Enter your LastName",
//                 prefixIcon: Icon(Icons.person),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Last name is required';
//                   }
//                   return null;
//                 },
//               ),
//               CustomInputWidget(
//                 controller: registerViewModel.usernameController.value,
//                 labelText: "UserName",
//                 hintText: "Enter your UserName",
//                 prefixIcon: Icon(Icons.account_circle),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Username is required';
//                   }
//                   return null;
//                 },
//               ),
//               CustomInputWidget(
//                 controller: registerViewModel.emailController.value,
//                 labelText: "Email",
//                 hintText: "Enter your Email",
//                 prefixIcon: Icon(Icons.email),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Email is required';
//                   }
//                   if (!GetUtils.isEmail(value)) {
//                     return 'Enter a valid email';
//                   }
//                   return null;
//                 },
//               ),
//               CustomInputWidget(
//                 controller: registerViewModel.phoneNumberController.value,
//                 labelText: "PhoneNumber",
//                 hintText: "Enter your PhoneNumber",
//                 prefixIcon: Icon(Icons.phone),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Phone number is required';
//                   }
//                   if (!GetUtils.isPhoneNumber(value)) {
//                     return 'Enter a valid phone number';
//                   }
//                   return null;
//                 },
//               ),
//               CustomInputWidget(
//                 controller: registerViewModel.passwordController.value,
//                 labelText: "Password",
//                 hintText: "Enter your Password",
//                 prefixIcon: Icon(Icons.lock),
//                 obscureText: true,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Password is required';
//                   }
//                   if (value.length < 6) {
//                     return 'Password must be at least 6 characters long';
//                   }
//                   return null;
//                 },
//               ),
//               CustomInputWidget(
//                 controller: registerViewModel.confirmPasswordController.value,
//                 labelText: "ConfirmPassword",
//                 hintText: "Re-enter your password",
//                 prefixIcon: Icon(Icons.lock),
//                 obscureText: true,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please confirm your password';
//                   }
//                   if (value !=
//                       registerViewModel.passwordController.value.text) {
//                     return 'Passwords do not match';
//                   }
//                   return null;
//                 },
//               ),
//               CustomInputWidget(
//                 controller: registerViewModel.profileController.value,
//                 labelText: "Profile",
//                 hintText: "Enter your Profile",
//                 prefixIcon: Icon(Icons.person_outline),
//               ),
//               CustomInputWidget(
//                 controller: registerViewModel.roleController.value,
//                 labelText: "Role",
//                 hintText: "Enter your Role",
//                 prefixIcon: Icon(Icons.group),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Role is required';
//                   }
//                   return null;
//                 },
//               ),
//
//               SizedBox(height: 20),
//               ElevatedButton(
//                 //onPressed: registerUser,
//                 onPressed: registerViewModel.onRegister,
//                 child: InkWell(
//                     onTap: () {
//                       Get.toNamed(Route_App.loginView);
//                       //registerViewModel.register();
//                     },
//                     child: Text("Register")),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


// import 'package:add_card_shop/App_route/route_App.dart';
// import 'package:add_card_shop/post/view/view_model/register_view_model.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../widget/custom_input_widget.dart';
//
// class RegisterView extends StatefulWidget {
//   @override
//   _RegisterViewState createState() => _RegisterViewState();
// }
//
// class _RegisterViewState extends State<RegisterView> {
//   // Define controllers for each input field
//   final _formKey = GlobalKey<FormState>();
//   final registerViewModel = Get.put(RegisterViewModel());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Register"),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//               CustomInputWidget(
//                 controller: registerViewModel.firstNameController.value,
//                 labelText: "FirstName",
//                 hintText: "Enter your FirstName",
//                 prefixIcon: Icon(Icons.person),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'First name is required';
//                   }
//                   return null;
//                 },
//               ),
//               CustomInputWidget(
//                 controller: registerViewModel.lastNameController.value,
//                 labelText: "LastName",
//                 hintText: "Enter your LastName",
//                 prefixIcon: Icon(Icons.person),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Last name is required';
//                   }
//                   return null;
//                 },
//               ),
//               CustomInputWidget(
//                 controller: registerViewModel.usernameController.value,
//                 labelText: "UserName",
//                 hintText: "Enter your UserName",
//                 prefixIcon: Icon(Icons.account_circle),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Username is required';
//                   }
//                   return null;
//                 },
//               ),
//               CustomInputWidget(
//                 controller: registerViewModel.emailController.value,
//                 labelText: "Email",
//                 hintText: "Enter your Email",
//                 prefixIcon: Icon(Icons.email),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Email is required';
//                   }
//                   if (!GetUtils.isEmail(value)) {
//                     return 'Enter a valid email';
//                   }
//                   return null;
//                 },
//               ),
//               CustomInputWidget(
//                 controller: registerViewModel.phoneNumberController.value,
//                 labelText: "PhoneNumber",
//                 hintText: "Enter your PhoneNumber",
//                 prefixIcon: Icon(Icons.phone),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Phone number is required';
//                   }
//                   if (!GetUtils.isPhoneNumber(value)) {
//                     return 'Enter a valid phone number';
//                   }
//                   return null;
//                 },
//               ),
//               CustomInputWidget(
//                 controller: registerViewModel.passwordController.value,
//                 labelText: "Password",
//                 hintText: "Enter your Password",
//                 prefixIcon: Icon(Icons.lock),
//                 obscureText: true,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Password is required';
//                   }
//                   if (value.length < 6) {
//                     return 'Password must be at least 6 characters long';
//                   }
//                   return null;
//                 },
//               ),
//               CustomInputWidget(
//                 controller: registerViewModel.confirmPasswordController.value,
//                 labelText: "ConfirmPassword",
//                 hintText: "Re-enter your password",
//                 prefixIcon: Icon(Icons.lock),
//                 obscureText: true,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please confirm your password';
//                   }
//                   if (value !=
//                       registerViewModel.passwordController.value.text) {
//                     return 'Passwords do not match';
//                   }
//                   return null;
//                 },
//               ),
//               CustomInputWidget(
//                 controller: registerViewModel.profileController.value,
//                 labelText: "Profile",
//                 hintText: "Enter your Profile",
//                 prefixIcon: Icon(Icons.person_outline),
//               ),
//               CustomInputWidget(
//                 controller: registerViewModel.roleController.value,
//                 labelText: "Role",
//                 hintText: "Enter your Role",
//                 prefixIcon: Icon(Icons.group),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Role is required';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: registerViewModel.onRegister,
//                 child: InkWell(
//                   // onTap: () {
//                   //   Get.toNamed(Route_App.loginView);
//                   //
//                   // },
//                   child: Text("Register"),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:add_card_shop/App_route/route_App.dart';
import 'package:add_card_shop/post/view/view_model/register_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widget/custom_input_widget.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final registerViewModel = Get.put(RegisterViewModel());

  // Observables for toggling password visibility
  final RxBool _isPasswordHidden = true.obs;
  final RxBool _isConfirmPasswordHidden = true.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Register"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // First Name
              CustomInputWidget(
                controller: registerViewModel.firstNameController.value,
                labelText: "First Name",
                hintText: "Enter your first name",
                prefixIcon: const Icon(Icons.person),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'First name is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Last Name
              CustomInputWidget(
                controller: registerViewModel.lastNameController.value,
                labelText: "Last Name",
                hintText: "Enter your last name",
                prefixIcon: const Icon(Icons.person),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Last name is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Username
              CustomInputWidget(
                controller: registerViewModel.usernameController.value,
                labelText: "Username",
                hintText: "Enter your username",
                prefixIcon: const Icon(Icons.account_circle),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Username is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Email
              CustomInputWidget(
                controller: registerViewModel.emailController.value,
                labelText: "Email",
                hintText: "Enter your email",
                prefixIcon: const Icon(Icons.email),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is required';
                  }
                  if (!GetUtils.isEmail(value)) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Phone Number
              CustomInputWidget(
                controller: registerViewModel.phoneNumberController.value,
                labelText: "Phone Number",
                hintText: "Enter your phone number",
                prefixIcon: const Icon(Icons.phone),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Phone number is required';
                  }
                  if (!GetUtils.isPhoneNumber(value)) {
                    return 'Enter a valid phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Password with Show/Hide Toggle
              Obx(() => CustomInputWidget(
                controller: registerViewModel.passwordController.value,
                labelText: "Password",
                hintText: "Enter your password",
                prefixIcon: const Icon(Icons.lock),
                obscureText: _isPasswordHidden.value,
                suffixIcon: IconButton(
                  icon: Icon(_isPasswordHidden.value
                      ? Icons.visibility_off
                      : Icons.visibility),
                  onPressed: () {
                    _isPasswordHidden.value = !_isPasswordHidden.value;
                  },
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters long';
                  }
                  return null;
                },
              )),
              const SizedBox(height: 16),

              // Confirm Password with Show/Hide Toggle
              Obx(() => CustomInputWidget(
                controller: registerViewModel.confirmPasswordController.value,
                labelText: "Confirm Password",
                hintText: "Re-enter your password",
                prefixIcon: const Icon(Icons.lock),
                obscureText: _isConfirmPasswordHidden.value,
                suffixIcon: IconButton(
                  icon: Icon(_isConfirmPasswordHidden.value
                      ? Icons.visibility_off
                      : Icons.visibility),
                  onPressed: () {
                    _isConfirmPasswordHidden.value = !_isConfirmPasswordHidden.value;
                  },
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  }
                  if (value != registerViewModel.passwordController.value.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              )),
              const SizedBox(height: 16),

              // Profile
              CustomInputWidget(
                controller: registerViewModel.profileController.value,
                labelText: "Profile",
                hintText: "Enter your profile",
                prefixIcon: const Icon(Icons.person_outline),
              ),
              const SizedBox(height: 16),

              // Role
              CustomInputWidget(
                controller: registerViewModel.roleController.value,
                labelText: "Role",
                hintText: "Enter your role",
                prefixIcon: const Icon(Icons.group),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Role is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Register Button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    registerViewModel.onRegister();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade800,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Register",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
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
