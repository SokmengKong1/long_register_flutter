
import 'package:add_card_shop/data/remote/api_url.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../repository/post/repository_product/model_view/product_all.dart';
import '../../../status.dart';
import '../../auth/authControllers.dart';
import 'fotter.dart';
import 'navbar_view.dart';

class ProductView extends StatelessWidget {
  var viewModel = Get.put(ProductAll());
  final AuthControllers authControllers = Get.put(AuthControllers());

  ProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavbarView(),
      body: Obx(
        () {
          // Loading status
          if (viewModel.LoadingRequestAllCategoryStatus.value ==
              Status.loading) {
            return Center(child: CircularProgressIndicator());
          }

          // Error status
          if (viewModel.LoadingRequestAllCategoryStatus.value == Status.error) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Error occurred!"),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Retry logic here if needed
                    },
                    child: Text("Retry"),
                  ),
                ],
              ),
            );
          }

          // No categories case
          if (viewModel.categoriesList.isEmpty) {
            return Center(child: Text("No categories available"));
          }

          // Main ListView for displaying categories
          return ListView.builder(
            itemCount: viewModel.categoriesList.length,
            padding: EdgeInsets.only(left: 10, right: 10, top: 20),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              var data = viewModel.categoriesList[index];
              if (kDebugMode) {
                print("Title for item : ${data.title} ${data.createBy}");
              } // Debug title value

              return Center(
                child: Container(
                  height: 350,
                  width: 400,
                  margin: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image placeholder section
                      Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(12)),
                        ),
                        child: Center(
                          child: CachedNetworkImage(
                            imageUrl: "${ApiUrl.imageViewPath}${data.image}",
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) {
                              print("Error loading image: $error");
                              return Icon(Icons.error);
                            },
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title and rating row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    data.title ?? "Product Name",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),



                                ),
                                Row(
                                  children: List.generate(
                                    5,
                                    (index) => Icon(
                                      Icons.star,
                                      size: 16,
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 8),

                            // Views, category, and user info
                            Row(
                              children: [
                                Text(
                                  "2 Views",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                ),
                                SizedBox(width: 10),
                                Icon(Icons.newspaper,
                                    size: 16, color: Colors.teal),
                                SizedBox(width: 4),
                                Text(
                                  "News Update",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.teal),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Text(
                              data.createBy ?? "Author Name",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[700],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Action buttons (edit/delete)
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () {
                                // Add your edit logic here
                              },
                              icon: Icon(Icons.edit, color: Colors.teal),
                            ),
                            IconButton(
                              onPressed: () {
                                // Add your delete logic here
                              },
                              icon: Icon(Icons.delete, color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: Footer(),
    );
  }
}