import 'package:add_card_shop/data/remote/api_url.dart';
import 'package:add_card_shop/post/view/show/create_post/postCategoryViewModel.dart';
import 'package:add_card_shop/post/view/show/create_post/view_model/post_category_form_viewModel.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart'; // Import image_picker
import 'dart:io';
import '../../../../repository/post/widget/custom_button_widget.dart';
import '../../../../repository/post/widget/custom_input_widget.dart';

class PostCategoryFormView extends StatefulWidget {
  PostCategoryFormView({super.key});

  @override
  _PostCategoryFormViewState createState() => _PostCategoryFormViewState();
}

class _PostCategoryFormViewState extends State<PostCategoryFormView> {
  final PostCategoryFormViewModel viewModel =
      Get.put(PostCategoryFormViewModel());
  final PostCategoryViewModel categoryViewModel =
      Get.put(PostCategoryViewModel());
  final ImagePicker _picker = ImagePicker();
  var _selectedImage = Rx<File?>(null);
  //File? _selectedImage;

  @override
  void initState() {
    super.initState();
    // Add a delay to allow time for imageFilePath to be set in viewModel
    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {}); // Rebuild the widget after the delay
    });
  }

  // Method to pick image from gallery
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage.value = File(pickedFile.path);
        viewModel.selectedImage = _selectedImage.value;
        viewModel.filenameUploaded.value = pickedFile.name;
      });
    }
  }

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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Other UI elements...
              Center(
                child: GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                      image: _selectedImage.value != null
                          ? DecorationImage(
                        image: FileImage(_selectedImage.value!), // Display the selected image
                        fit: BoxFit.cover,
                      )
                          : null,
                    ),
                    child: _selectedImage.value == null
                        ? (viewModel.postCreate.value.image?.isNotEmpty == true
                        ? CachedNetworkImage(
                      imageUrl: "${ApiUrl.imageViewPath}${viewModel.postCreate.value.image!}",
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) => Icon(
                        Icons.error,
                        color: Colors.red,
                      ),
                    )
                        : Center(
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.grey[700],
                        size: 40,
                      ),
                    ))
                        : null,
                  ),
                ),
              ),
              // Title input field
              CustomInputWidget(
                controller: viewModel.TittleNameController.value,
                labelText: "Title",
                hintText: "Enter the title",
              ),
              SizedBox(height: 16), // Space between sections
              // Description input field
                            CustomInputWidget(
                              controller: viewModel.DescriptionControlller.value,
                              labelText: "Description",
                              hintText: "Enter a detailed description",
                            ),

              // Add the dynamic option picker
              Obx(() => _buildOptionItem(
                    Icons.category,
                    viewModel.postCreate.value.id != 0
                        ? viewModel.selectedCategory.value?.name ??
                            "Select Category"
                        : "Select Category", // Default option if no category is selected
                    Colors.blue,
                    _showCategoryPicker,
                  )),

              SizedBox(height: 24), // Space before button

              CustomButtonWidget(
                onLoading: viewModel.onCreateLoading.value,
                onTap: () {
                  if (viewModel.TittleNameController.value.text.isEmpty) {
                    Get.snackbar(
                      'Title Required',
                      'Please enter a title before submitting.',
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  } else if (viewModel
                      .DescriptionControlller.value.text.isEmpty) {
                    Get.snackbar(
                      'Description Required',
                      'Please enter a description before submitting.',
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  } else {
                    // Proceed with form submission if everything is valid
                    viewModel.selectedImage =
                        _selectedImage.value; // Assign selected image
                    viewModel.onCreateOrUpdatePost(
                        viewModel.postCreate.value.id ?? 0);
                  }
                },
                title: viewModel.postCreate.value.id == 0 ? "Create" : "Update",
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds a reusable option item for category selection
  Widget _buildOptionItem(
    IconData icon,
    String title,
    Color iconColor,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(title),
      trailing: Icon(Icons.arrow_drop_down, color: Colors.grey),
      onTap: onTap,
    );
  }

  /// Shows a modal bottom sheet for selecting a category
  void _showCategoryPicker() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Obx(() {
          return ListView.builder(
            itemCount: categoryViewModel.categoryList.length,
            itemBuilder: (context, index) {
              final category = categoryViewModel.categoryList[index];
              return ListTile(
                title: Text(category.name ?? ""),
                onTap: () {
                  viewModel.selectedCategory.value =
                      category; // Set the selected category in viewModel
                  Navigator.pop(context);
                },
              );
            },
          );
        });
      },
    );
  }
  //
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       backgroundColor: Colors.indigo,
  //       iconTheme: IconThemeData(color: Colors.white),
  //       leading: IconButton(
  //         icon: Icon(Icons.arrow_back),
  //         onPressed: () => Navigator.pop(context),
  //       ),
  //       title: Text(
  //         "${viewModel.postCreate.value.id == 0 ? "Create" : "Update"} Post".tr,
  //         style: TextStyle(color: Colors.white),
  //       ),
  //     ),
  //     body: SingleChildScrollView(
  //       child: Obx(() {
  //         return Padding(
  //           padding: const EdgeInsets.all(16.0),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               // Image upload section
  //               Center(
  //                 child: GestureDetector(
  //                   onTap: _pickImage,
  //                   child: Container(
  //                     height: 150,
  //                     width: 150,
  //                     decoration: BoxDecoration(
  //                       color: Colors.grey[200],
  //                       borderRadius: BorderRadius.circular(8),
  //                       image: _selectedImage.value != null
  //                           ? DecorationImage(
  //                         image: FileImage(_selectedImage.value!), // Display the selected image
  //                         fit: BoxFit.cover,
  //                       )
  //                           : null,
  //                     ),
  //                     child: _selectedImage.value == null
  //                         ? (viewModel.postCreate.value.image?.isNotEmpty == true
  //                         ? CachedNetworkImage(
  //                       imageUrl: "${ApiUrl.imageViewPath}${viewModel.postCreate.value.image!}",
  //                       width: double.infinity,
  //                       height: 200,
  //                       fit: BoxFit.cover,
  //                       errorWidget: (context, url, error) => Icon(
  //                         Icons.error,
  //                         color: Colors.red,
  //                       ),
  //                     )
  //                         : Center(
  //                       child: Icon(
  //                         Icons.camera_alt,
  //                         color: Colors.grey[700],
  //                         size: 40,
  //                       ),
  //                     ))
  //                         : null,
  //                   ),
  //                 ),
  //               ),
  //
  //
  //               SizedBox(height: 16), // Space between image and form
  //
  //               // Display filename if an image is selected
  //               if (_selectedImage.value != null)
  //                 Text(
  //                   "Selected Image: ${viewModel.filenameUploaded.value}", // Display the filename
  //                   style: TextStyle(fontSize: 16, color: Colors.black),
  //                 ),
  //
  //               SizedBox(height: 16), // Space between fields
  //
  //               // Title input field
  //               CustomInputWidget(
  //                 controller: viewModel.TittleNameController.value,
  //                 labelText: "Title",
  //                 hintText: "Enter the title",
  //               ),
  //
  //               SizedBox(height: 16), // Space between fields
  //
  //               // Description input field
  //               CustomInputWidget(
  //                 controller: viewModel.DescriptionControlller.value,
  //                 labelText: "Description",
  //                 hintText: "Enter a detailed description",
  //               ),
  //               CustomInputWidget(
  //                 controller: viewModel.CategotyController.value,
  //                 labelText: "Category",
  //                 hintText: "Enter a detailed Category",
  //               ),
  //               SizedBox(height: 24), // Space before button
  //
  //               // Submit button
  //               CustomButtonWidget(
  //                 onLoading: viewModel.onCreateLoading.value,
  //                 onTap: () {
  //                   if (viewModel.TittleNameController.value.text.isEmpty) {
  //                     // Show error if title is empty
  //                     Get.snackbar(
  //                       'Title Required',
  //                       'Please enter a title before submitting.',
  //                       backgroundColor: Colors.red,
  //                       colorText: Colors.white,
  //                     );
  //                   } else if (viewModel
  //                       .DescriptionControlller.value.text.isEmpty) {
  //                     // Show error if description is empty
  //                     Get.snackbar(
  //                       'Description Required',
  //                       'Please enter a description before submitting.',
  //                       backgroundColor: Colors.red,
  //                       colorText: Colors.white,
  //                     );
  //                   } else if(viewModel.CategotyController.value.text.isEmpty){
  //                     Get.snackbar(
  //                       'Title Required',
  //                       'Please enter a title before submitting.',
  //                       backgroundColor: Colors.red,
  //                       colorText: Colors.white,
  //                     );
  //                   }
  //                   // else if (_selectedImage.value == null) {
  //                   //   // Show error if no image selected
  //                   //   Get.snackbar(
  //                   //     'Image Required',
  //                   //     'Please upload an image before submitting.',
  //                   //     backgroundColor: Colors.red,
  //                   //     colorText: Colors.white,
  //                   //   );
  //                   // }
  //
  //
  //                   else {
  //                     // Proceed with form submission if everything is valid
  //                     viewModel.selectedImage =
  //                         _selectedImage.value; // Assign selected image
  //                     viewModel.onCreateOrUpdatePost(
  //                         viewModel.postCreate.value.id ?? 0);
  //                   }
  //                 },
  //                 title:
  //                     viewModel.postCreate.value.id == 0 ? "Create" : "Update",
  //               ),
  //             ],
  //           ),
  //         );
  //       }),
  //     ),
  //   );
  // }
  // void _showCategoryPicker() {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Obx(() {
  //         return ListView.builder(
  //           itemCount: categoryViewModel.categoryList.length,
  //           itemBuilder: (context, index) {
  //             final category = categoryViewModel.categoryList[index];
  //             return ListTile(
  //               title: Text(category.name ?? ""),
  //               onTap: () {
  //                 viewModel.selectedCategory.value =
  //                     category; // Set the selected category in viewModel
  //                 Navigator.pop(context);
  //               },
  //             );
  //           },
  //         );
  //       });
  //     },
  //   );
  // }
}
