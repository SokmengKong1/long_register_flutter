// import 'package:add_card_shop/post/view/show/create_post/view_model/post_category_form_viewModel.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../../repository/post/widget/custom_button_widget.dart';
// import '../../../../repository/post/widget/custom_input_widget.dart';
//
// class PostCategoryFormView extends StatefulWidget {
//   PostCategoryFormView({super.key});
//   @override
//   State<PostCategoryFormView> createState() => _PostCategoryFormViewState();
// }
//
// class _PostCategoryFormViewState extends State<PostCategoryFormView> {
//   var viewModel = Get.put(PostCategoryFormViewModel());
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.indigo,
//         iconTheme: IconThemeData(color: Colors.white),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back), // Back arrow icon
//           onPressed: () => Navigator.pop(context), // Navigate back when pressed
//         ),
//         title: Text(
//           "${viewModel.postCreate.value.id == 0 ? "Create" : "Update"} Post".tr,
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//       body: SingleChildScrollView(child: Obx(() {
//         return Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             CustomInputWidget(
//               controller: viewModel.TittleNameController.value,
//               labelText: "title",
//               hintText: "title",
//             ),
//             CustomInputWidget(
//               controller: viewModel.DescriptionControlller.value,
//               labelText: "description",
//               hintText: "description",
//             ),
//             CustomButtonWidget(
//               onLoading: viewModel.onCreateLoading.value,
//               onTap: () => {viewModel.onCreateCategory()},
//               title: viewModel.postCreate.value.id == 0 ? "Create" : "Update",
//             )
//           ],
//         );
//       })),
//     );
//   }
// }


import 'package:add_card_shop/post/view/show/create_post/view_model/post_category_form_viewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart'; // Import image_picker
import 'dart:io';
import '../../../../repository/post/widget/custom_button_widget.dart';
import '../../../../repository/post/widget/custom_input_widget.dart';

class PostCategoryFormView extends StatelessWidget {
  PostCategoryFormView({super.key});

  var viewModel = Get.put(PostCategoryFormViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        iconTheme: IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "${viewModel.postCreate.value.id == 0 ? "Create" : "Update"} Post".tr,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Obx(() {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image upload section
                Center(
                  child: GestureDetector(
                    onTap: () async {
                      print("Picking image...");  // Print when image picking starts
                      await viewModel.pickImage(); // Call the pickImage method
                      if (viewModel.selectedImage != null) {
                        print("Image picked successfully: ${viewModel.selectedImage!.path}");  // Print selected image path
                      } else {
                        print("No image selected.");
                      }
                    },
                    child: Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                        image: viewModel.selectedImage != null
                            ? DecorationImage(
                          image: FileImage(viewModel.selectedImage!),
                          fit: BoxFit.cover,
                        )
                            : null,
                      ),
                      child: viewModel.selectedImage == null
                          ? Center(
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.grey[700],
                          size: 40,
                        ),
                      )
                          : null,
                    ),
                  ),
                ),
                SizedBox(height: 16), // Space between image and form

                // Title input field
                CustomInputWidget(
                  controller: viewModel.TittleNameController.value,
                  labelText: "Title",
                  hintText: "Enter the title",
                ),

                SizedBox(height: 16), // Space between fields

                // Description input field
                CustomInputWidget(
                  controller: viewModel.DescriptionControlller.value,
                  labelText: "Description",
                  hintText: "Enter a detailed description",
                ),

                SizedBox(height: 24), // Space before button

                // Submit button
                CustomButtonWidget(
                  onLoading: viewModel.onCreateLoading.value,
                  onTap: () {
                    if (viewModel.TittleNameController.value.text.isEmpty) {
                      // Show error if title is empty
                      Get.snackbar(
                        'Title Required',
                        'Please enter a title before submitting.',
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                    } else if (viewModel.DescriptionControlller.value.text.isEmpty) {
                      // Show error if description is empty
                      Get.snackbar(
                        'Description Required',
                        'Please enter a description before submitting.',
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                    } else if (viewModel.selectedImage == null) {
                      // Show error if no image selected
                      Get.snackbar(
                        'Image Required',
                        'Please upload an image before submitting.',
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                    } else {
                      // Proceed with form submission if everything is valid
                      print("Submitting form with title: ${viewModel.TittleNameController.value.text}");
                      viewModel.onCreateCategory();
                    }
                  },
                  title: viewModel.postCreate.value.id == 0 ? "Create" : "Update",
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
