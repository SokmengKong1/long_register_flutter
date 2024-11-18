
import 'dart:convert'; // For base64 encoding
import 'dart:io'; // For File class
import 'package:add_card_shop/App_route/route_App.dart';
import 'package:add_card_shop/model/postRegister/base_post_reques.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import '../../../../../model/postRegister/post_category.dart';
import '../../../../../model/postRegister/product/create/category.dart';
import '../../../../../model/postRegister/product/create/post_create.dart';
import '../../../../../repository/post/repository_product/repositories_All.dart';
import '../../../../../repository/post/widget/showCustomToast.dart';
import '../../../../../status.dart';
import 'package:path_provider/path_provider.dart'; // For local file management

class PostCategoryFormViewModel extends GetxController {
  RxString filenameUploaded = "".obs;
  var CategoryNameController = TextEditingController().obs;
  var TittleNameController = TextEditingController().obs;
  var DescriptionControlller = TextEditingController().obs;
  var IdController = TextEditingController().obs;
  var ImgaeController = TextEditingController().obs;
  var repositoriesAll = RepositoriesAll();
  var onCreateLoading = false.obs;
  var requestCategoryLoadingStatus = Status.loading.obs;

  void setRequestCategoryLoadingStatus(Status value) =>
      requestCategoryLoadingStatus.value = value;

  var postCreate = PostCreate().obs;
  var category = Category().obs;
  var storage = GetStorage();
  File? selectedImage;

  var createdByUser = "".obs;
  var selectedStatus = "".obs;
  var imageFilePath = "".obs;
  var selectedCategory = Rx<PostCategory?>(null); // Selected category
  var testCategory = Rx<PostCategory?>(null); // Selected category


  // Make _selectedImage an Rx<File?> variable
  var _selectedImage = Rx<File?>(null);

  // Getter for _selectedImage
  //File? get selectedImage => _selectedImage.value;


  @override
  void onInit() {
    _getCategoryById();
    super.onInit();
  }
  _getCategoryById() async {
    try {
      postCreate.value.id = 0;
      int id = int.parse(Get.parameters["id"] ?? "0");
      if (id != 0) {
        setRequestCategoryLoadingStatus(Status.loading);
        var baseRequest = BasePostRequest(id: id);
        var response = await repositoriesAll.getCategoryById(baseRequest);
        if (response.code == "SUC-000") {
          postCreate.value = PostCreate.fromJson(response.data);
          TittleNameController.value.text = postCreate.value.title ?? "";
          ImgaeController.value.text = postCreate.value.image ?? "";
          DescriptionControlller.value.text = postCreate.value.description ?? "";
        }
      }
    } finally {
      setRequestCategoryLoadingStatus(Status.completed);
    }
  }
  // Method to pick an image and upload it to the server
  Future<void> pickImage() async {
    try {
      final ImagePicker _picker = ImagePicker();
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        // Generate a timestamp for the filename
        String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
        String newFileName = '$timestamp.jpg';

        // Get the temporary directory where the image will be saved
        final directory = await getTemporaryDirectory();
        final imagePath = '${directory.path}/$newFileName';

        // Read the image file as bytes
        final bytes = await pickedFile.readAsBytes();

        // Save the image to the generated file path locally
        final File savedImage = await File(imagePath).writeAsBytes(bytes);

        // If you want to store the base64 image string (optional)
        String base64Image = base64Encode(bytes);

        // Set the base64 string and filename to the PostCreate model
        postCreate.value.setBase64Image(base64Image); // Store base64 if needed
        postCreate.value.image = newFileName; // Store the image filename (e.g., 1731513836788.jpg)

        // Now upload the image to the server
        await uploadImageToServer(savedImage);

        // Update the reactive _selectedImage variable correctly
        _selectedImage.value = savedImage;  // Correctly use .value to update the Rx<File?> variable

        print("Image saved and uploaded with filename: $newFileName");
      } else {
        Get.snackbar("No Image Selected", "Please select an image to upload.",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to pick an image: $e",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  // Method to upload the image to the server
  Future<void> uploadImageToServer(File imageFile) async {
    try {
      print("Uploading image to server...");

      final Uri url = Uri.parse('http://194.233.91.140:20099/app/public/v1/image/upload');
      var request = http.MultipartRequest('POST', url);

      var file = await http.MultipartFile.fromPath('file', imageFile.path);
      request.files.add(file);

      print("Sending image file with path: ${imageFile.path}");

      var response = await request.send();

      if (response.statusCode == 200) {
        print('Image uploaded successfully!');
        final responseBody = await response.stream.bytesToString();
        print('Server Response: $responseBody');
        // Handle the response...
      } else {
        print("Failed to upload image. Status Code: ${response.statusCode}");
        Get.snackbar("Error", "Failed to upload image to server.",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      print("Error uploading image: $e");
      Get.snackbar("Error", "Error occurred while uploading image: $e",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  Future<void> onCreateCategory() async {
    try {
      // Start loading state
      onCreateLoading(true);

      // Ensure the title is provided before creating the category
      if (TittleNameController.value.text.isEmpty) {
        Get.snackbar("Error", "Please enter a title.");
        return;
      }

      // Ensure the description is provided before creating the category
      if (DescriptionControlller.value.text.isEmpty) {
        Get.snackbar("Error", "Please enter a description.");
        return;
      }

      // If the image is not selected yet, trigger the image picker
      if (_selectedImage.value == null) {
        await pickImage();  // This triggers the image picking process
        if (_selectedImage.value == null) {
          // If still no image selected after pickImage, show an error
          Get.snackbar("Error", "Please select an image.");
          return;
        }
      }

      // At this point, we have the image selected or already available
      print("Selected image path: ${_selectedImage.value?.path}");

      // Set post data from controllers
      postCreate.value.title = TittleNameController.value.text;
      postCreate.value.description = DescriptionControlller.value.text;
      postCreate.value.status = "ACT"; // Set default status
      category.value.id = 2; // Set category ID (this could be dynamic if needed)
      postCreate.value.category = category.value;

      // Send the data to the backend with the image (if any)
      var response = await repositoriesAll.createPost(postCreate.value);
      print("Backend response: ${response.code}, ${response.message}");

      if (response.code == "SUC-000") {
        Get.back(result: true); // Go back if successful
      } else {
        Get.snackbar("Error", response.message ?? "Failed to create category");
      }
    } catch (e) {
      // Handle errors and show an error message
      Get.snackbar("Error", "An error occurred: $e",
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      onCreateLoading(false); // End loading state
    }
  }



  Future uploadImage(File imageFile) async {
    try {
      var response = await repositoriesAll.uploadImage(imageFile);
      print(response.data['data']);
      filenameUploaded.value = response.data['data'];
      print(response.code);
      if(response.code == "200"){
        print("Print file ${filenameUploaded}");
        // await onCreatePost();
        // Get.offAllNamed(RouteName.postManagePath);
      }else{
        showCustomToast(message: response.message.toString());
      }
      // Handle success
      print("Image uploaded successfully1: ${response.data.data}");
    } catch (e) {
      // Handle errors
      print("Image upload failed: $e");
    }

  }




  onCreateOrUpdatePost(int id) async {
    print("FILE NAME FROM CREATE ${filenameUploaded} AND ID: ${id}");
    var userData = storage.read("USER_KEY");
    var user = userData['user'];
    var userName = user['username'];
    var createUser = "".obs;
    print(selectedStatus.value);
    print(imageFilePath);
    if(DescriptionControlller.value.text.isEmpty){
      showCustomToast(message: "Please Input Description");
      return;
    }

    // if(selectedStatus.value.isEmpty){
    //   showCustomToast(message: "Please Select Status");
    //   return;
    // }

    // Set the selected category in postRequest
    if (selectedCategory.value == null) {
      showCustomToast(message: "Please Select Category");
      return;
    }

    if(postCreate.value.id != 0){
      createUser.value = createdByUser.value;
      if(selectedImage==null){
        filenameUploaded.value = imageFilePath.value;
        print(filenameUploaded);
      }
    }else{
      createUser.value = userName;
    }

    try {
      onCreateLoading(true);

      if(selectedImage != null) {
        await uploadImage(selectedImage!);
      }else{
        if(postCreate.value.id != 0){
          filenameUploaded.value = imageFilePath.value;
          print(filenameUploaded);

        }else{
          filenameUploaded.value = "NON";
        }
      }
      // postRequest.value.status = "ACT";
      postCreate.value.createAt = "";
      postCreate.value.image = filenameUploaded.value;
      postCreate.value.updateAt = "";
      postCreate.value.createBy = createUser.value;

      postCreate.value.updateBy = userName;
      postCreate.value.id = id;
      postCreate.value.title = "Post Status from ${userName}";
      postCreate.value.category = selectedCategory.value!.toCategory();
      postCreate.value.status = selectedStatus.value;
      postCreate.value.description = DescriptionControlller.value.text;
      postCreate.value.totalView = 0;


      var response = await repositoriesAll.createPost(postCreate.value);
      print(filenameUploaded);
      if(response.code == "SUC-000"){
        showCustomToast(message: response.message!);
        Get.offAllNamed(Route_App.createView);
      }else{
        showCustomToast(message: response.message!);
      }

      print(response);

    } finally {
      onCreateLoading(false);
    }
  }
}

