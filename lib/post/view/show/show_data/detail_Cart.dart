import 'package:add_card_shop/App_route/route_App.dart';
import 'package:add_card_shop/post/view/show/show_data/view_model/detail_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:add_card_shop/model/postRegister/product/post_response.dart';
import '../../../../data/remote/api_url.dart';
import '../../../widget/CartIconButton .dart';
import 'add_CardOn.dart';

class DetailCart extends StatelessWidget {
  final DetailView detailView = Get.put(DetailView());
  var postResponse = PostResponse(quantity: 0).obs;

  @override
  Widget build(BuildContext context) {
    // Retrieve the arguments passed from the previous page (the selected product)
    final showData = Get.arguments as PostResponse; // Ensure PostResponse is the correct model type
    var product = detailView.postResponse;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        centerTitle: true,
        backgroundColor: Colors.teal,
        actions: [
          // The InkWell widget wraps the CartIconButton
          InkWell(
            onTap: () {
              // This triggers the navigation to the route defined in Route_App.addCardOn
              Get.toNamed(Route_App.addCardOn);
            },
            child: CartIconButton(), // The custom CartIconButton widget
          ),
        ],
      ),

      body: Obx(() {
        if (detailView.loading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  "${ApiUrl.imageViewPath}${showData.image}",
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 250,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                            (loadingProgress.expectedTotalBytes ?? 1)
                            : null,
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.error, color: Colors.red, size: 50);
                  },
                ),
              ),
              const SizedBox(height: 16),

              // Product Title
              Text(
                showData.title ?? "No Title",
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),

              // Divider
              const Divider(color: Colors.grey, thickness: 1, height: 20),

              // Product Metadata Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    // "Category:" ,
                    //showData.id ?? "",
                  showData.id?.toString() ?? "",


        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    showData.category?.name ?? "No Category",
                    style: const TextStyle(fontSize: 16, color: Colors.teal),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Created By:",
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    showData.createBy ?? "Unknown",
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Divider
              const Divider(color: Colors.grey, thickness: 1, height: 20),

              // Description Section
              const Text(
                "Description:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                showData.description ?? "No Description available.",
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 16),

              // Divider
              const Divider(color: Colors.grey, thickness: 1, height: 20),

              // Additional Information Section
              const Text(
                "Additional Information:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.info_outline, color: Colors.teal),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "You can add extra metadata or information here if needed.",
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Actions Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  ElevatedButton(
                    onPressed: () {
                      // Adds product as a new cart item each time, even if it already exists in the cart
                      detailView.addToCart(showData); // Add the product to the cart
                      Get.snackbar(
                        "Added to Cart",
                        "${showData.title} has been added to your cart!",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.teal,
                        colorText: Colors.white,
                      );
                    },
                    child: const Text("Add to Cart"),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      if (detailView.postResponse.value != null) {
                        // Add product to the cart
                        //detailView.addToCart(detailView.postResponse.value);
                        detailView.addToCart(showData); // Add product to the cart
                        Get.snackbar(
                          "Cart",
                          "Product added to cart!",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.teal,
                          colorText: Colors.white,
                        );
                      } else {
                        // Handle case where postResponse is null
                        Get.snackbar(
                          "Error",
                          "Product details are unavailable!",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                      }
                    },
                    icon: const Icon(Icons.shopping_bag_rounded, color: Colors.white),
                    label: const Text("ADD"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  OutlinedButton.icon(
                    onPressed: () {
                      // Delete button functionality
                    },
                    icon: const Icon(Icons.delete, color: Colors.red),
                    label: const Text(
                      "Delete",
                      style: TextStyle(color: Colors.red),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.red),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
