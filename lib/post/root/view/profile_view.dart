import 'package:add_card_shop/repository/post/repository_product/model_view/product_all.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/src/storage_impl.dart';

import '../../auth/authControllers.dart';

// class ProfileView extends StatelessWidget {
//   final ProductAll productAll = Get.put(ProductAll());
//   final AuthControllers authControllers = Get.put(AuthControllers());
//    ProfileView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     String username = productAll.storage.read("usename") ?? "No username";
//     return Scaffold(
//       backgroundColor: Colors.lightBlueAccent, // Set background color to black
//       appBar: AppBar(
//         backgroundColor: Colors.blue, // Set app bar color to red
//         title: Text("កែប្រែព័ត៌មាន", style: TextStyle(fontFamily: 'KhmerFont')), // "Edit Information" in Khmer
//         centerTitle: true,
//         actions: [
//           TextButton(
//             onPressed: () {},
//             child: Text(
//               "រក្សាទុក", // "Save" in Khmer
//               style: TextStyle(color: Colors.white, fontFamily: 'KhmerFont'),
//             ),
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           child: Column(
//             children: [
//               SizedBox(height: 20),
//               // Profile Picture with Edit Icon
//               Center(
//                 child: Stack(
//                   alignment: Alignment.center,
//                   children: [
//                     CircleAvatar(
//                       radius: 50,
//                       backgroundColor: Colors.white,
//                       child: Icon(Icons.account_circle, size: 100, color: Colors.red),
//                     ),
//                     Positioned(
//                       bottom: 0,
//                       right: 0,
//                       child: CircleAvatar(
//                         radius: 15,
//                         backgroundColor: Colors.black,
//                         child: Icon(Icons.camera_alt, color: Colors.white, size: 16),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 10),
//               Text(
//                 "កែប្រែរូបថតផ្ទាល់ខ្លួន", // "Edit Profile Picture" in Khmer
//                 style: TextStyle(color: Colors.red, fontFamily: 'KhmerFont'),
//
//               ),
//               SizedBox(height: 20),
//
//               // Form Section 1
//               _buildSectionHeader("ព័ត៌មានផ្ទាល់ខ្លួន"), // "Personal Information" in Khmer
//               _buildTextField(Icons.person, "sok"), // Name
//               _buildTextField(Icons.person, "meng"), // Surname
//               _buildTextField(Icons.calendar_today, "12-11-2023"), // Date of Birth
//
//               SizedBox(height: 20),
//
//               // Form Section 2
//               _buildSectionHeader("ព័ត៌មានទាក់ទង"), // "Contact Information" in Khmer
//               _buildTextField(Icons.location_on, "អាស័យដ្ឋានរបស់អ្នក"), // Address
//               _buildTextField(Icons.phone, "855965866444"), // Phone Number
//
//               SizedBox(height: 10),
//               Align(
//                 alignment: Alignment.centerRight,
//                 child: TextButton(
//                   onPressed: () {
//                     authControllers.remove();
//                   },
//                   child: Text(
//                     "ផ្លាស់ប្តូរ", // "Change" in Khmer
//                     style: TextStyle(color: Colors.red, fontFamily: 'KhmerFont'),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   // Function to create section header
//   Widget _buildSectionHeader(String title) {
//     String username = productAll.storage.read("usename") ?? "No username";
//     return Align(
//       alignment: Alignment.centerLeft,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 10.0),
//         child: Text(
//           title,
//           style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'KhmerFont'),
//         ),
//       ),
//     );
//   }
//
//   // Function to create text fields with icon
//   Widget _buildTextField(IconData icon, String hintText) {
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 8),
//       decoration: BoxDecoration(
//         color: Colors.grey[800],
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: TextField(
//         style: TextStyle(color: Colors.white),
//         decoration: InputDecoration(
//           prefixIcon: Icon(icon, color: Colors.white),
//           hintText: hintText,
//           hintStyle: TextStyle(color: Colors.white70),
//           border: InputBorder.none,
//           contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//         ),
//       ),
//     );
//   }
// }


class ProfileView extends StatelessWidget {
  final ProductAll productAll = Get.put(ProductAll());
  final AuthControllers authControllers = Get.put(AuthControllers());

  ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("កែប្រែព័ត៌មាន", style: TextStyle(fontFamily: 'KhmerFont')), // "Edit Information" in Khmer
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              "រក្សាទុក", // "Save" in Khmer
              style: TextStyle(color: Colors.white, fontFamily: 'KhmerFont'),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              SizedBox(height: 20),
              // Profile Picture with Edit Icon
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.account_circle, size: 100, color: Colors.red),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.black,
                        child: Icon(Icons.camera_alt, color: Colors.white, size: 16),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              // Display the username reactively
              Obx(() {
                return Text(
                  productAll.email.value, // Display reactive username
                  style: TextStyle(color: Colors.red, fontFamily: 'KhmerFont'),
                );
              }),
              SizedBox(height: 20),

              // Form Section 1
              _buildSectionHeader("ព័ត៌មានផ្ទាល់ខ្លួន"), // "Personal Information" in Khmer
              _buildTextField(Icons.person, "${productAll.username.value}"), // Name
              _buildTextField(Icons.person, "meng"), // Surname
              _buildTextField(Icons.calendar_today, "12-11-2023"), // Date of Birth

              SizedBox(height: 20),

              // Form Section 2
              _buildSectionHeader("ព័ត៌មានទាក់ទង"), // "Contact Information" in Khmer
              _buildTextField(Icons.location_on, "អាស័យដ្ឋានរបស់អ្នក"), // Address
              _buildTextField(Icons.phone, "${productAll.phoneNumber.value}"), // Phone Number

              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    authControllers.remove();
                  },
                  child: Text(
                    "ផ្លាស់ប្តូរ", // "Change" in Khmer
                    style: TextStyle(color: Colors.red, fontFamily: 'KhmerFont'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to create section header
  Widget _buildSectionHeader(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'KhmerFont'),
        ),
      ),
    );
  }

  // Function to create text fields with icon
  Widget _buildTextField(IconData icon, String hintText) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.white),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.white70),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
    );
  }
}
