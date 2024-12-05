

import 'package:add_card_shop/post/view/show/show_data/view_model/detail_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/remote/api_url.dart';

class AddCardon extends StatelessWidget {
  final DetailView detailView = Get.find();  // Get the controller that manages the cart data

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
        centerTitle: true,
        backgroundColor: Colors.teal,
        actions: [
          // Shopping cart icon to show cart details (optional)
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              // Show snackbar or navigate to cart page
              Get.snackbar("Cart", "Go to cart page");
            },
          ),
        ],
      ),
      body: GetBuilder<DetailView>(  // Use GetBuilder to refresh the UI when cart data changes
        builder: (controller) {
          if (controller.cartProduct.isEmpty) {
            return const Center(
              child: Text(
                "Your cart is empty!",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }

          return ListView.builder(
            itemCount: controller.cartProduct.length,
            itemBuilder: (context, index) {
              final product = controller.cartProduct[index];

              return Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Product Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        "${ApiUrl.imageViewPath}${product.image}",
                        fit: BoxFit.cover,
                        width: 60,
                        height: 60,
                      ),
                    ),
                    // Product Details
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.title ?? "No Title",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text("Quantity: ${product.quantity}"),
                      ],
                    ),
                    // Price
                    Text(
                      "\$${(product.totalPrice ?? 0.0).toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    // Quantity Controls
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => detailView.decreaseQuantity(product),
                          icon: const Icon(Icons.remove),
                        ),
                        Text("${product.quantity}"),
                        IconButton(
                          onPressed: () => detailView.increaseQuantity(product),
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
