// //
// // import 'package:add_card_shop/repository/post/repository_product/repositories_All.dart';
// // import 'package:get/get.dart';
// //
// // import '../../../../../model/postRegister/product/post_response.dart';
// // class DetailView extends GetxController{
// //   var postResponse = PostResponse().obs;
// //   var loading = true.obs;
// //   final repositoriesAll = RepositoriesAll();
// //
// //   @override
// //   void onInit() {
// //     fetchProductById();
// //     super.onInit();
// //   }
// //   fetchProductById()async{
// //     try{
// //       loading(true);
// //       var response = await repositoriesAll.getById(Get.arguments ?? 0);
// //       postResponse.value = response;
// //     }
// //     finally{
// //       loading(false);
// //     }
// //
// //   }
// //
// //   Future<void> fetchData() async {
// //     loading.value = true; // Set loading state to true
// //     // Fetch data logic
// //     await Future.delayed(Duration(seconds: 2)); // Simulate network request
// //     loading.value = false; // Set loading state to false once data is fetched
// //   }
// //   List<PostResponse> cartProduct = [];
// //     addCarts(postResponse){
// //       cartProduct.add(postResponse);
// //       print("Add Cart: ${cartProduct.length}");
// //       update();
// //     }
// //
// //   // addCart(PostResponse product) {
// //   //   if (!cartProduct.contains(product)) {
// //   //     cartProduct.add(product);
// //   //     print("Product added to cart: ${cartProduct.length}");
// //   //   } else {
// //   //     print("Product is already in the cart");
// //   //   }
// //   //   update();
// //   // }
// //
// //
// //
// //   removeFromCart(PostResponse){
// //       cartProduct.remove(postResponse);
// //       update();
// //     }
// //
// //
// // }
// //
//
// import 'dart:convert';
//
// import 'package:add_card_shop/repository/post/repository_product/repositories_All.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../../../../model/postRegister/product/post_response.dart';
//
// class DetailView extends GetxController {
//   late int productId;
//   var postResponse = PostResponse(
//     quantity: 0,
//   ).obs;
//   var loading = true.obs;
//   var fetchData  = ''.obs;
//   final repositoriesAll = RepositoriesAll();
//   var cartProduct = <PostResponse>[].obs;
//
//
//
//   @override
//   void onInit() {
//
//     super.onInit();
//     //loadCartFromStorage();
//     fetchProductById();
//    // loadCart();  // Load the cart from storage when the controller is initialized
//   }
//
//
//   void addToCarts(PostResponse product) {
//     cartProduct.add(product); // Add product to the cart
//     print("SSS:${cartProduct}");
//     update(); // Update the UI if necessary
//   }
//
//
//   fetchProductById() async {
//     try {
//       loading(true);
//       var response = await repositoriesAll.getById(Get.arguments ?? 0);
//       postResponse.value = response;
//       print("ID : ${response}");
//       productId = response.id!; // Store the product ID here
//     } finally {
//       loading(false);
//     }
//   }
//   // Add a product to the cart (if it's not already in the cart)
//   void addToCart(PostResponse product) {
//     // Check if the product already exists in the cart
//     final existingProduct = cartProduct.firstWhere(
//           (item) => item.id == product.id,
//       orElse: () => PostResponse(id: 0, quantity: 0),  // Return an empty PostResponse if not found
//     );
//
//     if (existingProduct.id != 0) { // Check if we found an existing product
//       // Increase quantity if product is already in the cart
//       existingProduct.quantity++;
//     } else {
//       // Add product to cart with quantity of 1
//       cartProduct.add(product..quantity = 1);
//     }
//
//     update(); // Update the UI after modifying the cart
//   }
//
//   // Increase the quantity of a product in the cart
//   void increaseQuantity(PostResponse product) {
//     product.quantity++;
//     update();
//   }
//
//   // Decrease the quantity of a product in the cart
//   void decreaseQuantity(PostResponse product) {
//     if (product.quantity > 1) {
//       product.quantity--;
//     } else {
//       // Optionally, remove the product if quantity reaches 0
//       cartProduct.remove(product);
//     }
//     update();
//   }
//
//   // Remove product from cart
//   void removeFromCart(PostResponse product) {
//     cartProduct.remove(product);
//     update();
//   }
//
//
//
// }
//
//

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';  // For json.decode and json.encode
import '../../../../../model/postRegister/basePostRequest.dart';
import '../../../../../model/postRegister/product/post_response.dart';


class DetailView extends GetxController {
  late int productId;
  var postResponse = PostResponse(quantity: 0).obs;
  var loading = true.obs;
  var cartProduct = <PostResponse>[].obs;
  var baseRequest = BasePostRequest().obs;
  var storage = GetStorage();

  // Reactive variables for user information
  var username = ''.obs;
  var email = ''.obs;
  var phoneNumber = ''.obs;
  var profile = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getUsernameFromStorage();
    loadCartFromStorage();  // Load the cart from SharedPreferences on initialization
    fetchProductById();
  }

  // Fetch product details (example for fetching a product by ID)
  fetchProductById() async {
    // Placeholder for actual API call to fetch product
    loading(true);
    try {
      // Example: Replace this with your actual API logic
      var response = PostResponse(id: 1, title: 'Sample Product', totalPrice: 15.0, quantity: 1);
      postResponse.value = response;
      productId = response.id!;
    } finally {
      loading(false);
    }
  }

  void addToCart(PostResponse product) {
    final existingProduct = cartProduct.firstWhere(
          (item) => item.id == product.id,
      orElse: () => PostResponse(id: 0, quantity: 0,),  // Return a dummy product if not found
    );

    if (existingProduct.id != 0) {
      existingProduct.quantity++;  // Increment quantity if product exists
    } else {
      cartProduct.add(product..quantity = 1);  // Add new product with quantity 1
    }

    saveCartToStorage();  // Save the updated cart to SharedPreferences
    update();  // Refresh UI
  }
  void saveCartToStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cartList = cartProduct.map((product) {
      return json.encode(product.toJson());  // Convert product to JSON string for storage
    }).toList();
    await prefs.setStringList('cart', cartList);  // Save the list of products to SharedPreferences
  }
  void loadCartFromStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? cartList = prefs.getStringList('cart');
    if (cartList != null) {
      // Convert the list of JSON strings back into PostResponse objects
      cartProduct.value = cartList.map((item) {
        Map<String, dynamic> jsonMap = json.decode(item);  // Decode the string into Map
        return PostResponse.fromJson(jsonMap);  // Use the decoded map to create a PostResponse object
      }).toList();
    }
  }
  // void loadCartFromStorage() async {
  //   // Retrieve user data from local storage
  //   var userData = storage.read("USER_KEY");
  //
  //   if (userData != null) {
  //     // Check if phoneNumber exists in the user data
  //     var phoneNumber = userData['user']?['phoneNumber'];
  //     print("PHONE:${phoneNumber}");
  //
  //     // Only proceed with loading the cart if the phoneNumber is not null or empty
  //     if (phoneNumber != null && phoneNumber.isNotEmpty) {
  //       // Proceed with loading cart data from SharedPreferences
  //       SharedPreferences prefs = await SharedPreferences.getInstance();
  //       List<String>? cartList = prefs.getStringList('cart');
  //
  //       if (cartList != null) {
  //         // Convert the list of JSON strings back into PostResponse objects
  //         cartProduct.value = cartList.map((item) {
  //           Map<String, dynamic> jsonMap = json.decode(item);  // Decode the string into Map
  //           return PostResponse.fromJson(jsonMap);  // Use the decoded map to create a PostResponse object
  //         }).toList();
  //       }
  //     } else {
  //       // If phoneNumber is not available or empty, skip loading the cart
  //       print("Phone number is missing or invalid. Cart not loaded.");
  //       cartProduct.value = [];  // Optionally, clear the cart
  //     }
  //   } else {
  //     print("User data not found in local storage.");
  //   }
  // }




  void increaseQuantity(PostResponse product) {
    product.quantity++;
    product.totalPrice = product.quantity * product.price;  // Update total price
    saveCartToStorage();  // Save updated cart data
    update();  // Refresh UI
  }

  void decreaseQuantity(PostResponse product) {
    if (product.quantity > 1) {
      product.quantity--;
      product.totalPrice = product.quantity * product.price;  // Update total price
    } else {
      cartProduct.remove(product);  // Remove from cart if quantity is 0
    }
    saveCartToStorage();  // Save updated cart data
    update();  // Refresh UI
  }


  // Remove product from the cart
  void removeFromCart(PostResponse product) {
    cartProduct.remove(product);
    saveCartToStorage();  // Save the updated cart to SharedPreferences
    update();  // Refresh UI
  }
  void getUsernameFromStorage() {
    if (storage.read("USER_KEY") != null) {
      var userData = storage.read("USER_KEY");
      print("USER:${userData}");
      var user = userData['user'];
      username.value = user['username'] ?? "No username"; // Update username observable
      email.value = user['email'] ?? "No Email";
      phoneNumber.value = user['phoneNumber'] ?? "No Phone";
      profile.value = user['profile'] ?? "No Phone";
    }
  }
}
