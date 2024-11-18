import 'package:add_card_shop/post/view/show/show_data/view_model/detail_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:add_card_shop/model/postRegister/product/post_response.dart';

import '../../../../data/remote/api_url.dart'; // Assuming PostResponse is the data model

class DetailCart extends StatelessWidget {
  final DetailView detailView = Get.put(DetailView());

  @override
  Widget build(BuildContext context) {
    // Retrieve the arguments passed from the previous page (the selected product)
    final showData = Get.arguments as PostResponse; // Ensure PostResponse is the correct model type

    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
        backgroundColor: Colors.black12,
      ),
      body: Obx(() {
        if (detailView.loading.value) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
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
                    return Icon(Icons.error, color: Colors.red, size: 50);
                  },
                ),
              ),
              SizedBox(height: 16),

              // Product Title
              Text(
                showData.title ?? "No Title",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 8),

              // Product Category
              Text(
                "Category: ${showData.category?.name ?? "No Category"}",
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              SizedBox(height: 8),

              // Product Creator
              Text(
                "Created by: ${showData.createBy ?? "Unknown"}",
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              SizedBox(height: 16),

              // Product Description
              Text(
                "Description: ${showData.description ?? "No Description available."}",
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              SizedBox(height: 16),

              // Product Price
              SizedBox(height: 16),

              // Add to Cart Button
              // Center(
              //   child: ElevatedButton(
              //     onPressed: () {
              //       // Add to cart functionality (You can implement cart logic here)
              //       print("Added to Cart");
              //     },
              //     style: ElevatedButton.styleFrom(
              //       backgroundColor: Colors.orange,
              //       padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              //       textStyle: TextStyle(fontSize: 16),
              //     ),
              //     child: Text('Add to Cart'),
              //   ),
              // ),
            ],
          ),
        );
      }),
    );
  }
}
