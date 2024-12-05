

  import 'package:add_card_shop/repository/post/repository_product/model_view/product_all.dart';
  import 'package:cached_network_image/cached_network_image.dart';
  import 'package:flutter/material.dart';
  import 'package:get/get.dart';
  import 'package:get/get_core/src/get_main.dart';
  import 'package:get_storage/src/storage_impl.dart';

  import '../../../data/remote/api_url.dart';
  import '../../auth/authControllers.dart';

  class ProfileView extends StatelessWidget {
    final ProductAll productAll = Get.put(ProductAll());
    final AuthControllers authControllers = Get.put(AuthControllers());

    ProfileView({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Text(
            "កែប្រែព័ត៌មាន", // "Edit Information" in Khmer
            style: TextStyle(color: Colors.black, fontFamily: 'KhmerFont'),
          ),
          centerTitle: true,
          actions: [
            TextButton(
              onPressed: () {},
              child: Text(
                "រក្សាទុក", // "Save" in Khmer
                style: TextStyle(color: Colors.black, fontFamily: 'KhmerFont'),
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
                        radius: 60,
                        backgroundColor: Colors.grey[200],
                        child: ClipOval(
                          child: CachedNetworkImage(
                            height: 120,
                            width: 120,
                            imageUrl: "${ApiUrl.imageViewPath}${productAll.profile.value}",
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                            const Icon(Icons.error, size: 30, color: Colors.red),
                          ),
                        ),
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
                    style: TextStyle(color: Colors.black, fontFamily: 'KhmerFont'),
                  );
                }),
                SizedBox(height: 20),

                // Form Section 1
                _buildSectionHeader("ព័ត៌មានផ្ទាល់ខ្លួន"), // "Personal Information" in Khmer
                _buildTextField(Icons.person, "${productAll.username.value}"), // Name
                _buildTextField(Icons.person, "${productAll.email.value}"), // Surname
                _buildTextField(Icons.calendar_today, "12-11-2023"), // Date of Birth

                SizedBox(height: 20),

                // Form Section 2
                _buildSectionHeader("ព័ត៌មានទាក់ទង"), // "Contact Information" in Khmer
                _buildTextField(Icons.location_on, "${productAll.userRole.value}"), // Address
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
                      style: TextStyle(color: Colors.black, fontFamily: 'KhmerFont'),
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
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'KhmerFont',
            ),
          ),
        ),
      );
    }

    // Function to create text fields with icon
    Widget _buildTextField(IconData icon, String hintText) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: TextField(
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: Colors.black),
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.black45),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
        ),
      );
    }
  }
