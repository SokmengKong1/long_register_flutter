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
//
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';  // For json.decode and json.encode
// import '../../../../../model/postRegister/basePostRequest.dart';
// import '../../../../../model/postRegister/product/post_response.dart';
//
//
// class DetailView extends GetxController {
//   late int productId;
//   var postResponse = PostResponse(quantity: 0).obs;
//   var loading = true.obs;
//   var cartProduct = <PostResponse>[].obs;
//   var baseRequest = BasePostRequest().obs;
//   var storage = GetStorage();
//
//   // Reactive variables for user information
//   var username = ''.obs;
//   var email = ''.obs;
//   var phoneNumber = ''.obs;
//   var profile = ''.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     getUsernameFromStorage();
//     loadCartFromStorage();  // Load the cart from SharedPreferences on initialization
//     fetchProductById();
//   }
//
//   // Fetch product details (example for fetching a product by ID)
//   fetchProductById() async {
//     // Placeholder for actual API call to fetch product
//     loading(true);
//     try {
//       // Example: Replace this with your actual API logic
//       var response = PostResponse(id: 1, title: 'Sample Product', totalPrice: 15.0, quantity: 1);
//       postResponse.value = response;
//       productId = response.id!;
//     } finally {
//       loading(false);
//     }
//   }
//
//   void addToCart(PostResponse product) {
//     final existingProduct = cartProduct.firstWhere(
//           (item) => item.id == product.id,
//       orElse: () => PostResponse(id: 0, quantity: 0,),  // Return a dummy product if not found
//     );
//
//     if (existingProduct.id != 0) {
//       existingProduct.quantity++;  // Increment quantity if product exists
//     } else {
//       cartProduct.add(product..quantity = 1);  // Add new product with quantity 1
//     }
//
//     saveCartToStorage();  // Save the updated cart to SharedPreferences
//     update();  // Refresh UI
//   }
//   void saveCartToStorage() async {
//     if(username.value.isNotEmpty){
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String key = 'cart_${username.value}'
//     List<String> cartList = cartProduct.map((product) {
//       return json.encode(product.toJson());  // Convert product to JSON string for storage
//     }).toList();
//     await prefs.setStringList(key, cartList); // Save the list of products for the specific user
//     }else{
//     }
//   }
//   void loadCartFromStorage() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     List<String>? cartList = prefs.getStringList('cart');
//     if (cartList != null) {
//       // Convert the list of JSON strings back into PostResponse objects
//       cartProduct.value = cartList.map((item) {
//         Map<String, dynamic> jsonMap = json.decode(item);  // Decode the string into Map
//         return PostResponse.fromJson(jsonMap);  // Use the decoded map to create a PostResponse object
//       }).toList();
//     }
//   }
//
//   void increaseQuantity(PostResponse product) {
//     product.quantity++;
//     product.totalPrice = product.quantity * product.price;  // Update total price
//     saveCartToStorage();  // Save updated cart data
//     update();  // Refresh UI
//   }
//
//   void decreaseQuantity(PostResponse product) {
//     if (product.quantity > 1) {
//       product.quantity--;
//       product.totalPrice = product.quantity * product.price;  // Update total price
//     } else {
//       cartProduct.remove(product);  // Remove from cart if quantity is 0
//     }
//     saveCartToStorage();  // Save updated cart data
//     update();  // Refresh UI
//   }
//
//
//   // Remove product from the cart
//   void removeFromCart(PostResponse product) {
//     cartProduct.remove(product);
//     saveCartToStorage();  // Save the updated cart to SharedPreferences
//     update();  // Refresh UI
//   }
//   void getUsernameFromStorage() {
//     if (storage.read("USER_KEY") != null) {
//       var userData = storage.read("USER_KEY");
//       print("USER:${userData}");
//       var user = userData['user'];
//       username.value = user['username'] ?? "No username"; // Update username observable
//       email.value = user['email'] ?? "No Email";
//       phoneNumber.value = user['phoneNumber'] ?? "No Phone";
//       profile.value = user['profile'] ?? "No Phone";
//     }
//   }
// }

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // For json.decode and json.encode
import '../../../../../model/postRegister/basePostRequest.dart';
import '../../../../../model/postRegister/product/post_response.dart';

class DetailView extends GetxController {
  late int productId;
  var postResponse = PostResponse(quantity: 0).obs;
  var loading = true.obs;
  var cartProduct = <PostResponse>[].obs;
  var baseRequest = BasePostRequest().obs;
  var storage = GetStorage();
  var username = ''.obs;
  var email = ''.obs;
  var phoneNumber = ''.obs;
  var profile = ''.obs;
  var isCartUpdating = false.obs;
  var isLoading = false.obs;


 //  var cartCount = 0.obs; // Reactive cart count
 // int get cartCount => cartProduct.fold(0, (previousValue, product) => previousValue + product.quantity);
  @override
  void onInit() {
    super.onInit();
    getUsernameFromStorage();
    loadCartForCurrentUser(); // Load the cart for the logged-in user
    fetchProductById();
    loadCartCountFromStorage(); // Load the cart count for the logged-in user
    loadCartForCurrentUser();   // Load the cart items

  }
  void fetchProductById() async {
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
  void addToCart(PostResponse product) async {
    // Prevent multiple clicks while the operation is in progress
    if (isLoading.value) return;
    isLoading.value = true; // Set loading to true before the operation starts
    // Simulate an async operation (e.g., adding to cart)
    await Future.delayed(Duration(seconds: 2));  // Simulating a delay (e.g., API call or heavy computation)
    // Check if the product already exists in the cart
    final existingProduct = cartProduct.firstWhere(
          (item) => item.id == product.id,
      orElse: () => PostResponse(id: 0, quantity: 0), // Return a dummy product if not found
    );
    if (existingProduct.id != 0) {
      existingProduct.quantity++;  // Increment quantity by 1 if product exists
      existingProduct.totalPrice = existingProduct.quantity * existingProduct.price; // Update total price
    } else {
      product.quantity = 1;  // Set quantity to 1 for the new product
      product.totalPrice = product.price;  // Set total price as price * quantity
      cartProduct.add(product);  // Add new product to the cart
    }
    // Save the updated cart for the current user
    saveCartForCurrentUser();
    isLoading.value = false; // Set loading to false after the operation is done
    update();  // Refresh UI
  }


  Future saveCartForCurrentUser() async {
    if (username.value.isNotEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String key = "cart_${username.value}"; // Unique key for each user's cart
      print("USERINCART${key}");

      List<String> cartList = cartProduct.map((product) {
        return json.encode(product.toJson()); // Convert product to JSON string for storage
      }).toList();

      await prefs.setStringList(key, cartList); // Save the list of products for the specific user
    } else {
      print("Error: No logged-in user to save the cart for.");
    }
  }

  void loadCartForCurrentUser() async {
    if (username.value.isNotEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String key = "cart_${username.value}"; // Unique key for each user's cart

      List<String>? cartList = prefs.getStringList(key);
      if (cartList != null) {
        // Convert the list of JSON strings back into PostResponse objects
        cartProduct.value = cartList.map((item) {
          Map<String, dynamic> jsonMap = json.decode(item); // Decode the string into Map
          return PostResponse.fromJson(jsonMap); // Use the decoded map to create a PostResponse object
        }).toList();
      } else {
        cartProduct.clear(); // Initialize an empty cart for new users
      }
    } else {
      print("Error: No logged-in user to load the cart for.");
    }
  }
  void increaseQuantity(PostResponse product) async {
    if (isLoading.value) return; // Prevent multiple clicks while loading
    isLoading.value = true; // Set loading to true
    // Simulate an async operation (e.g., API call or heavy computation)
    await Future.delayed(Duration(seconds: 1)); // Simulate some delay

    // Find the product in the cart and increment its quantity
    final existingProduct = cartProduct.firstWhere(
          (item) => item.id == product.id,
      orElse: () => PostResponse(id: 0, quantity: 0),
    );
    if (existingProduct.id != 0) {
      existingProduct.quantity++;  // Increment quantity if the product exists
      existingProduct.totalPrice = existingProduct.quantity * existingProduct.price; // Update total price
    } else {
      product.quantity = 1;  // If the product doesn't exist, initialize it with quantity 1
      product.totalPrice = product.price;  // Set the total price based on the quantity and price
      cartProduct.add(product);  // Add product to the cart
    }
    // Save the updated cart data for the current user
    saveCartForCurrentUser();

    isLoading.value = false; // Set loading to false after operation completes
    update(); // Refresh UI
  }

  void decreaseQuantity(PostResponse product) async {
    if (isLoading.value) return; // Prevent multiple clicks while loading

    isLoading.value = true; // Set loading to true

    // Simulate an async operation (e.g., API call or heavy computation)
    await Future.delayed(Duration(seconds: 1)); // Simulate some delay

    // Find the product in the cart and decrement its quantity
    final existingProduct = cartProduct.firstWhere(
          (item) => item.id == product.id,
      orElse: () => PostResponse(id: 0, quantity: 0),
    );

    if (existingProduct.id != 0 && existingProduct.quantity > 1) {
      existingProduct.quantity--;  // Decrement quantity
      existingProduct.totalPrice = existingProduct.quantity * existingProduct.price; // Update total price
    } else {
      cartProduct.remove(existingProduct); // If quantity is 1, remove the product from the cart
    }

    // Save the updated cart data for the current user
    saveCartForCurrentUser();

    isLoading.value = false; // Set loading to false after operation completes
    update(); // Refresh UI
  }

  // void removeFromCart(PostResponse product) {
  //   cartProduct.remove(product);
  //   saveCartForCurrentUser(); // Save the updated cart for the current user
  //   update(); // Refresh UI
  // }
  Future removeAllItemsFromCart() async {
    // Clear the cartProduct list (removes all items)
    cartProduct.clear();

    // Save the updated cart data to storage
    await saveCartForCurrentUser();

    // Refresh the UI
    update();
  }
  void removeItemFromCart(PostResponse product) {
    cartProduct.remove(product); // Remove the selected product from the cart
    saveCartForCurrentUser(); // Save updated cart to storage
    update(); // Refresh the UI
  }




  void getUsernameFromStorage() {
    if (storage.read("USER_KEY") != null) {
      var userData = storage.read("USER_KEY");
      var user = userData['user'];
      username.value = user['username'] ?? ""; // Update username observable
      email.value = user['email'] ?? "";
      phoneNumber.value = user['phoneNumber'] ?? "";
      profile.value = user['profile'] ?? "";
    } else {
      username.value = ""; // Clear username if no user data is found
      cartProduct.clear(); // Clear cart for non-logged-in users
    }
  }


  // List to store cart products
  List<PostResponse> cartProducts = [];
  int get cartCount {
    int count = cartProduct.fold(0, (previousValue, product) => previousValue + product.quantity);
    // Save the cart count to SharedPreferences for persistence
    saveCartCountToStorage(count);
    return count;
  }


// Save cart count to SharedPreferences
  Future<void> saveCartCountToStorage(int count) async {
    if (username.value.isNotEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String countKey = "cartCount_${username.value}"; // Unique key for each user's cart count
      await prefs.setInt(countKey, count); // Save cart count
      print("Cart count saved: $count");
    } else {
      print("Error: No logged-in user to save cart count.");
    }
  }

// Load cart count from SharedPreferences
  Future<void> loadCartCountFromStorage() async {
    if (username.value.isNotEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String countKey = "cartCount_${username.value}"; // Unique key for each user's cart count

      if (prefs.containsKey(countKey)) {
        int savedCount = prefs.getInt(countKey) ?? 0;
        print("Cart count loaded: $savedCount");
      } else {
        print("No saved cart count found for user ${username.value}.");
      }
    } else {
      print("Error: No logged-in user to load cart count.");
    }
  }

}

