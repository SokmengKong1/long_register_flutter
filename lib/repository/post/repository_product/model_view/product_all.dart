import 'package:add_card_shop/model/postRegister/base_post_reques.dart';
import 'package:add_card_shop/repository/post/repository_product/repositories_All.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../model/login/login_rep.dart';
import '../../../../model/postRegister/product/post_body_request.dart';
import '../../../../model/postRegister/product/post_response.dart';
import '../../../../status.dart';

// class ProductAll extends GetxController{
//   final _repositoriesAll = RepositoriesAll();
//   var categoriesList = <PostResponse>[].obs;
//   var LoadingRequestAllCategoryStatus = Status.loading.obs;
//   void setLoadingRequestAllCategory(Status value) =>
//       LoadingRequestAllCategoryStatus.value = value;
//   var baseRequest = BasePostRequest().obs;
//   var storage = GetStorage();
//   @override
//   void onInit() {
//     loadingData();
//     //_getAllPost();
//     super.onInit();
//   }
//   loadingData(){
//     setLoadingRequestAllCategory(Status.loading);
//     try{
//       _getAllPost();
//     }finally{
//       setLoadingRequestAllCategory(Status.completed);
//     }
//   }
//
//   _getAllPost() async {
//     // var user = LoginRep.fromJson(storage.read("USER_KEY"));
//     // if(user.accessToken != null){
//     //   print("USER:${user}");
//     // }
//     // if(storage.read("USER_KEY") != null){
//     //   var user = storage.read("USER_KEY");
//     //   print("USER EXIST ${user}");
//     //   print("USER createAt: ${user['createAt']}");
//     //
//     // }
//     if (storage.read("USER_KEY") != null) {
//       var userData = storage.read("USER_KEY"); // Read the data
//       print("USER EXIST: $userData");
//
//       // Assuming `userData` is a map and it contains a nested 'user' map
//       var user = userData['user']; // Access the nested 'user' map
//       var username = user['email']; // Access the 'username' field
//       print("Username: $username"); // Print the username
//     }
//
//
//     var request = PostBodyRequest();  // Ensure correct instantiation here
//     var response = await _repositoriesAll.getAllPosts(request);
//     if (response.data != null) {
//       categoriesList.clear(); // Clear the existing list before adding new data
//       response.data.forEach((data) {
//         categoriesList.add(PostResponse.fromJson(data));
//       });
//     }
//   }
// }
class ProductAll extends GetxController {
    final _repositoriesAll = RepositoriesAll();
  var categoriesList = <PostResponse>[].obs;
  var LoadingRequestAllCategoryStatus = Status.loading.obs;
  void setLoadingRequestAllCategory(Status value) =>
      LoadingRequestAllCategoryStatus.value = value;
  var baseRequest = BasePostRequest().obs;
  var storage = GetStorage();
  // Add a reactive variable for username
  var username = ''.obs;
  var email = ''.obs;
  var phoneNumber = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getUsernameFromStorage();  // Load username from storage
    loadingData();
  }

  // Method to load username from storage
  void getUsernameFromStorage() {
    if (storage.read("USER_KEY") != null) {
      var userData = storage.read("USER_KEY");
      var user = userData['user'];
      username.value = user['username'] ?? "No username";// Update the username observable
      email.value = user['email'] ?? "NO Email";
      phoneNumber.value = user['phoneNumber'] ?? "NO Email";

    }
  }

  void loadingData() {
    setLoadingRequestAllCategory(Status.loading);
    try {
      _getAllPost();
    } finally {
      setLoadingRequestAllCategory(Status.completed);
    }
  }

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
        categoriesList.add(PostResponse.fromJson(data));
      });
    }
  }
}
