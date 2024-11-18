// import 'package:get/get.dart';
// import 'package:flutter/material.dart'; // If you plan to use Material widgets for UI feedback
// import '../../../../model/postRegister/product/create/post_create.dart';
// import '../../../../model/postRegister/post_base_response.dart';
// import '../uploadImage.dart';
//
// class UploadImageView extends GetxController {
//   final _uploadImageService = UploadImage();  // Service that handles the image upload
//   var isLoading = false.obs;  // To manage loading state
//   var uploadSuccess = false.obs;  // To indicate success or failure of the upload
//
//   // Create the upload image function
//   Future<void> uploadImage(PostCreate postCreate, String base64Image) async {
//     isLoading.value = true; // Start loading
//
//     postCreate.setBase64Image(base64Image);  // Set the image data in postCreate
//
//     try {
//       // Call the upload image API method
//       PostBaseResponse response = await _uploadImageService.uploadImages(postCreate);
//
//       // Handle the response
//       if (response != null && response.code == 'SUC-000') {
//         uploadSuccess.value = true;
//         Get.snackbar('Success', 'Image uploaded successfully',
//             backgroundColor: Colors.green, colorText: Colors.white);
//       } else {
//         uploadSuccess.value = false;
//         Get.snackbar('Error', 'Failed to upload image',
//             backgroundColor: Colors.red, colorText: Colors.white);
//       }
//     } catch (error) {
//       uploadSuccess.value = false;
//       Get.snackbar('Error', 'An error occurred: $error',
//           backgroundColor: Colors.red, colorText: Colors.white);
//     } finally {
//       isLoading.value = false;  // End loading after the attempt
//     }
//   }
// }
