import 'package:add_card_shop/model/postRegister/base_post_reques.dart';
import 'package:add_card_shop/model/postRegister/product/create/post_create.dart';
import 'package:add_card_shop/model/postRegister/product/post_response.dart';
import 'package:add_card_shop/repository/post/repository_product/repositories_All.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../model/postRegister/product/post_body_request.dart';
import '../../../../status.dart';

class ProductAll extends GetxController {
  final _repositoriesAll = RepositoriesAll();
  //var categoriesList = <PostResponse>[].obs;
  var categoriesList = <PostCreate>[].obs;
  var LoadingRequestAllCategoryStatus = Status.loading.obs;

  void setLoadingRequestAllCategory(Status value) =>
      LoadingRequestAllCategoryStatus.value = value;

  var baseRequest = BasePostRequest().obs;
  var storage = GetStorage();

  // Reactive variables for user information
  var username = ''.obs;
  var email = ''.obs;
  var phoneNumber = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getUsernameFromStorage(); // Load username from storage
    loadingData();
  }

  // Method to load user information from storage
  void getUsernameFromStorage() {
    if (storage.read("USER_KEY") != null) {
      var userData = storage.read("USER_KEY");
      var user = userData['user'];
      username.value = user['username'] ?? "No username"; // Update username observable
      email.value = user['email'] ?? "No Email";
      phoneNumber.value = user['phoneNumber'] ?? "No Phone";
    }
  }

  // Load data and update status
  void loadingData() {
    setLoadingRequestAllCategory(Status.loading);
    try {
      _getAllPost();
    } catch (e) {
      setLoadingRequestAllCategory(Status.error);
      print("Error loading data: $e");
    } finally {
      setLoadingRequestAllCategory(Status.completed);
    }
  }

  // Method to fetch posts
  _getAllPost() async {
    if (storage.read("USER_KEY") != null) {
      var userData = storage.read("USER_KEY");
      print("USER EXIST: $userData");
      var user = userData['user'];
      //print("Username: ${user['email']}");
    }

    var request = PostBodyRequest();
    var response = await _repositoriesAll.getAllPosts(request);
    if (response.data != null) {
      categoriesList.clear();
      response.data.forEach((data) {
        categoriesList.add(PostCreate.fromJson(data));
        //categoriesList.add(PostResponse.fromJson(data));
      });
    }
  }

  // Method to refresh data
  Future<void> refreshData() async {
    LoadingRequestAllCategoryStatus.value = Status.loading;
    try {
      await _getAllPost(); // Call your data fetching function
      LoadingRequestAllCategoryStatus.value = Status.completed; // Replace `Status.success` if not defined
    } catch (e) {
      LoadingRequestAllCategoryStatus.value = Status.error;
      print("Error refreshing data: $e");
    }
  }
}
