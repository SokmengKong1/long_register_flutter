import 'package:add_card_shop/repository/product_repository.dart';
import 'package:get/get.dart';

import '../model/products/products.dart';

class ProductController extends GetxController {
  List<Products> products = <Products>[].obs;
  final ProductRepository productRepository = ProductRepository();
  var loadingProduct = true.obs;
  var cartItems = <Products>[].obs;

  // List for cart items
  @override
  void onInit() {
    FethProduct();
    super.onInit();
  }

  Future FethProduct() async {
    try {
      products = [];
      loadingProduct(true);
      var response = await productRepository.getAllProduct();
      products.addAll(response.products!);
    } catch (e) {
      Get.snackbar("Error places FethAllProduct in Controller", e.toString());
    } finally {
      loadingProduct(false);
    }
  }

  void printProductDetails(product) {
    print(product.title ?? "No title available");
    print(product.price ?? "No price available");
    print(product.id ?? "No id available");
    //print(product. ?? "No id available");
  }

  // Method to add product to cart
  void addToCart(Products product) {
  cartItems.add(product); // Add product to the cart
  update(); // Update the UI if necessary
  }

  // // Optional: Method to print product details (for debugging)
  // void printProductDetails(Products product) {
  // print('Product: ${product.title}, Price: ${product.price}');
  // }
}
