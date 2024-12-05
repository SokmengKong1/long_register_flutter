
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
  var TittleNameController = TextEditingController().obs;
  var DescriptionControlller = TextEditingController().obs;
  var CategotyController = TextEditingController().obs;
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
  String get imageUrl => postCreate.value.image ?? ""; // Safely get the image URL


  @override
  void onInit() {
    _getCategoryById();
    super.onInit();
  }
  _getCategoryById() async {
    try {
      postCreate.value.id = 0; // Ensure postCreate is reset before fetching
      int id = int.parse(Get.parameters["id"] ?? "0"); // Get the ID from parameters
      if (id != 0) {
        setRequestCategoryLoadingStatus(Status.loading); // Show loading status

        // Create a request object for category
        var baseRequest = BasePostRequest(id: id);

        // Fetch category data from backend
        var response = await repositoriesAll.getCategoryById(baseRequest);
        if (response.code == "SUC-000") {
          // Populate postCreate data from response
          postCreate.value = PostCreate.fromJson(response.data);

          // Set the text fields with the fetched data
          TittleNameController.value.text = postCreate.value.title ?? "";
          DescriptionControlller.value.text = postCreate.value.description ?? "";
          CategotyController.value.text = postCreate.value.category?.name ?? "";
          selectedCategory.value = PostCategory(
            id: postCreate.value.category?.id,
            name: postCreate.value.category?.name,
            status: postCreate.value.category?.status,
            createAt: postCreate.value.category?.createAt,
            createBy: postCreate.value.category?.createBy,
            imageUrl: postCreate.value.category?.imageUrl,
            updateAt: postCreate.value.category?.updateAt,
            updateBy: postCreate.value.category?.updateBy,
          );


          // Fetch and save the image if URL is provided
          //String? imageUrl = postCreate.value.image;

          if (imageUrl != null && imageUrl.isNotEmpty) {
            print("Image URL: $imageUrl"); // Debugging line
            try {
              final Directory tempDir = await getTemporaryDirectory();
              final String tempPath = tempDir.path;

              // Ensure directory exists
              final Directory directory = Directory(tempPath);
              if (!await directory.exists()) {
                await directory.create(recursive: true);
              }

              // Make the HTTP request to download the image
              final httpResponse = await http.get(Uri.parse(imageUrl));
              print("HTTP response status code: ${httpResponse.statusCode}");
              if (httpResponse.statusCode == 200) {
                // Save the image locally
                final File imageFile = File('$tempPath/${Uri.parse(imageUrl).pathSegments.last}');

                // Check if the file exists before overwriting
                if (await imageFile.exists()) {
                  print("Image already exists at ${imageFile.path}");
                } else {
                  await imageFile.writeAsBytes(httpResponse.bodyBytes);
                  print("Image saved at ${imageFile.path}");

                  // Update the selected image and filename
                  selectedImage = imageFile;
                  filenameUploaded.value = imageUrl;

                  update(); // Notify UI of changes
                }
              } else {
                print("Failed to download image: ${httpResponse.statusCode}");
              }
            } catch (e) {
              print("Error fetching image: $e");
            }
          }
        } else {
          print("Failed to load category: ${response.message}");
        }
      }
    } finally {
      setRequestCategoryLoadingStatus(Status.completed); // Complete the loading state
    }
  }


  Future<void> onCreateCategory(int id) async {
    print("FILE NAME FROM CREATE ${filenameUploaded} AND ID: ${id}");
    var userData = storage.read("USER_KEY");
    var user = userData['user'];
    var userName = user['username'];
    var createUser = "".obs;
    print(selectedStatus.value);
    print("IMAGE: $imageFilePath");
    if(DescriptionControlller.value.text.isEmpty){
      showCustomToast(message: "Please Input Description");
      return;
    }
    if(CategotyController.value.text.isEmpty){
      showCustomToast(message: "Please Input Category");
      return;
    }
    if(postCreate.value.id != 0){
      createUser.value = createdByUser.value;
      if(selectedImage==null){
        filenameUploaded.value = imageFilePath.value;

        print("IMAGE UPDATES :$filenameUploaded");
      }
    }else{
      createUser.value = userName;
    }



    try {

      onCreateLoading(true);
      if (selectedImage != null) {
        await uploadImage(selectedImage!);
      } else {
        if (postCreate.value.id != 0) {
          filenameUploaded.value = imageFilePath.value;
          print("IMAGE UPDATE :$filenameUploaded");
        } else {
          filenameUploaded.value = "NON";
        }
      }

      // Set post data from controllers
      postCreate.value.title = TittleNameController.value.text;
      postCreate.value.description = DescriptionControlller.value.text;
      postCreate.value.status = "ACT"; // Set default status
      category.value.id = 2; // Set category ID (this could be dynamic if needed)
      postCreate.value.category = category.value;
      postCreate.value.image = filenameUploaded.value;


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
      if (response.code == "200") {
        filenameUploaded.value = response.data['data'];
        print("Image uploaded successfully: ${filenameUploaded.value}");
      } else {
        throw Exception("Failed to upload image: ${response.message}");
      }
    } catch (e) {
      Get.snackbar("Error", "Image upload failed: $e",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }





  onCreateOrUpdatePost(int id) async {
    print("FILE NAME FROM CREATE ${filenameUploaded} AND ID: ${id}");
    var userData = storage.read("USER_KEY");
    var user = userData['user'];
    var userName = user['username'];
    var createUser = "".obs;
    print(selectedStatus.value);
    print("IMAGE: $imageFilePath");
    if(DescriptionControlller.value.text.isEmpty){
      showCustomToast(message: "Please Input Description");
      return;
    }

    if (selectedCategory.value == null) {
      showCustomToast(message: "Please Select Category");
      return;
    }

    if(postCreate.value.id != 0){
      createUser.value = createdByUser.value;
      if(selectedImage==null){
        filenameUploaded.value = imageFilePath.value;

        print("IMAGE UPDATES :$filenameUploaded");
      }
    }else{
      createUser.value = userName;
    }

    try {
      onCreateLoading(true);
      if (selectedImage != null) {
        await uploadImage(selectedImage!);
      } else {
        if (postCreate.value.id != 0) {
          filenameUploaded.value = imageFilePath.value;
          print("IMAGE UPDATE :$filenameUploaded");
        } else {
          filenameUploaded.value = "NON";
        }
      }
      postCreate.value.createAt = "";
      postCreate.value.updateAt = "";
      postCreate.value.createBy = createUser.value;
      postCreate.value.updateBy = userName;
      postCreate.value.title = "Post Status from ${userName}";
      postCreate.value.status = selectedStatus.value;
      postCreate.value.totalView = 0;
      postCreate.value.status = "ACT"; // Set default status
      category.value.id = id; // Set category ID (this could be dynamic if needed)
      postCreate.value.image = filenameUploaded.value;
      postCreate.value.title = TittleNameController.value.text;
      postCreate.value.description = DescriptionControlller.value.text;
      postCreate.value.category = selectedCategory.value!.toCategory();





      var response = await repositoriesAll.createPost(postCreate.value);
      print("Backend response: ${response.code}, ${response.message}");

      if (response.code == "SUC-000") {
        Get.back(result: true); // Go back if successful
      } else {
        Get.snackbar("Error", response.message ?? "Failed to create category");
      }
    }
    catch (e) {
      // Handle errors and show an error message
      Get.snackbar("Error", "An error occurred: $e",
          backgroundColor: Colors.red, colorText: Colors.white);
    }

    finally {
      onCreateLoading(false); // End loading state
    }
  }


}

