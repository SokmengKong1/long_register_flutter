// import 'package:add_card_shop/App_route/route_App.dart';
// import 'package:add_card_shop/data/remote/api_url.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../repository/post/repository_product/model_view/product_all.dart';
// import '../../../status.dart';
// import 'fotter.dart';
// import 'navbar_view.dart';
//
// class ProductView extends StatelessWidget {
//   final viewModel = Get.put(ProductAll());
//   //final ProductAll productAll = Get.put(ProductAll());
//
//   ProductView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: NavbarView(),
//       body: Obx(
//         () {
//           // Loading status
//           if (viewModel.LoadingRequestAllCategoryStatus.value ==
//               Status.loading) {
//             return Center(child: CircularProgressIndicator());
//           }
//
//           // Error status
//           if (viewModel.LoadingRequestAllCategoryStatus.value == Status.error) {
//             return Center(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text("Error occurred!"),
//                   SizedBox(height: 10),
//                   ElevatedButton(
//                     onPressed: () {
//                       viewModel.refreshData();
//                     },
//                     child: Text("Retry"),
//                   ),
//                 ],
//               ),
//             );
//           }
//           // No categories case
//           if (viewModel.categoriesList.isEmpty) {
//             return Center(child: Text("No categories available"));
//           }
//           // Main ListView with RefreshIndicator
//           return RefreshIndicator(
//             onRefresh: viewModel.refreshData, // Trigger refresh when pulled
//             child: ListView.builder(
//               itemCount: viewModel.categoriesList.length,
//               padding: EdgeInsets.only(left: 10, right: 10, top: 20),
//               scrollDirection: Axis.vertical,
//               itemBuilder: (context, index) {
//                 var data = viewModel.categoriesList[index];
//                 if (kDebugMode) {
//                   print("Title for item : ${data.title} ${data.createBy}");
//                 }
//
//                 return Center(
//                   child: Container(
//                     height: 350,
//                     width: 400,
//                     margin: EdgeInsets.only(top: 20),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(12),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.5),
//                           spreadRadius: 3,
//                           blurRadius: 7,
//                           offset: Offset(0, 3),
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Image placeholder section
//                         Container(
//                           height: 200,
//                           width: double.infinity,
//                           decoration: BoxDecoration(
//                             color: Colors.grey[300],
//                             borderRadius:
//                                 BorderRadius.vertical(top: Radius.circular(12)),
//                           ),
//                           child: Center(
//                             child: CachedNetworkImage(
//                               imageUrl: "${ApiUrl.imageViewPath}${data.image}",
//                               // imageUrl: "${ApiUrl.imageViewPath}${data.image}",
//                               placeholder: (context, url) =>
//                                   CircularProgressIndicator(),
//                               errorWidget: (context, url, error) {
//                                 print("Error loading image: $error");
//                                 return Icon(Icons.error);
//                               },
//                             ),
//                           ),
//                         ),
//
//                         Padding(
//                           padding: const EdgeInsets.all(10.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               // Title and rating row
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Expanded(
//                                     child: Row(
//                                       children: [
//                                         Container(
//
//                                             child: CircleAvatar(
//
//                                               radius: 15, // Size of the profile circle
//                                               backgroundColor: Colors.grey[200], // Background color in case image fails to load
//                                               child: ClipOval( // Clip the image into a circular shape
//                                                 child: CachedNetworkImage(
//                                                   height: 30,
//                                                   imageUrl: "${ApiUrl.imageViewPath}${viewModel.profile.value}",
//                                                   fit: BoxFit.cover, // Ensures the image covers the circle area
//                                                   placeholder: (context, url) => const CircularProgressIndicator(), // Loading indicator
//                                                   errorWidget: (context, url, error) => const Icon(Icons.error, size: 30, color: Colors.red), // Error icon
//                                                 ),
//                                               ),
//                                             ),
//                                             ),
//                                         Text(
//                                           data.title ?? "Product Name",
//                                           style: TextStyle(
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.bold,
//                                             color: Colors.black87,
//                                           ),
//                                           overflow: TextOverflow.ellipsis,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   Row(
//                                     children: List.generate(
//                                       5,
//                                       (index) => Icon(
//                                         Icons.star,
//                                         size: 16,
//                                         color: Colors.grey[400],
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(height: 8),
//                               Row(
//                                 children: [
//                                   Text(
//                                     "2 Views",
//                                     style: TextStyle(
//                                         fontSize: 12, color: Colors.grey),
//                                   ),
//                                   SizedBox(width: 10),
//                                   Icon(Icons.newspaper,
//                                       size: 16, color: Colors.teal),
//                                   SizedBox(width: 4),
//                                   Expanded(
//                                     child: Text(
//                                       data.category?.name ??
//                                           "Description not available",
//
//                                       style: TextStyle(
//                                         fontSize: 12,
//                                         color: Colors.teal,
//                                       ),
//                                       overflow: TextOverflow
//                                           .ellipsis, // Optional: to prevent overflow if description is too long
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(height: 8),
//                               Text(
//                                 data.createBy ?? "Author Name",
//                                 style: TextStyle(
//                                   fontSize: 12,
//                                   color: Colors.grey[700],
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               SizedBox(height: 8),
//                               Row(
//                                 children: [
//                                   // Description aligned to the left
//                                   Expanded(
//                                     child: Text(
//                                       data.description ??
//                                           "Description not available",
//                                       style: TextStyle(
//                                         fontSize: 12,
//                                         color: Colors.grey[700],
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                       overflow: TextOverflow
//                                           .ellipsis, // Optional: to prevent overflow if description is too long
//                                     ),
//                                   ),
//
//                                   // The row of icons aligned to the right
//                                   Padding(
//                                     padding:
//                                         EdgeInsets.symmetric(horizontal: 1),
//                                     child: Row(
//                                       //mainAxisAlignment: MainAxisAlignment.end,
//                                       children: [
//                                         IconButton(
//                                           onPressed: () {
//                                             // Edit logic
//                                           },
//                                           icon: InkWell(
//                                             onTap: () {
//                                               Get.toNamed(Route_App.createView,
//                                                   parameters: {
//                                                     "id": "${data.id}",
//                                                   });
//                                             },
//                                             child: Icon(Icons.edit,
//                                                 color: Colors.teal),
//                                           ),
//                                         ),
//                                         IconButton(
//                                           onPressed: () {
//                                             // Delete logic
//                                           },
//                                           icon: Icon(Icons.delete,
//                                               color: Colors.red),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                         Spacer(),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           );
//         },
//       ),
//       bottomNavigationBar: Footer(),
//     );
//   }
// }



import 'package:add_card_shop/App_route/route_App.dart';
import 'package:add_card_shop/data/remote/api_url.dart';
import 'package:add_card_shop/model/postRegister/product/create/post_create.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../repository/post/repository_product/model_view/product_all.dart';
import '../../../status.dart';
import 'fotter.dart';
import 'navbar_view.dart';

class ProductView extends StatelessWidget {
  final viewModel = Get.put(ProductAll());
  final RxString userRole = ''.obs;


  ProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavbarView(),
      body: Obx(
            () {
          // Loading status
          if (viewModel.LoadingRequestAllCategoryStatus.value == Status.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          // Error status
          if (viewModel.LoadingRequestAllCategoryStatus.value == Status.error) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Error occurred!"),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      viewModel.refreshData();
                    },
                    child: const Text("Retry"),
                  ),
                ],
              ),
            );
          }

          // No categories case
          if (viewModel.categoriesList.isEmpty) {
            return const Center(child: Text("No categories available"));
          }

          // Main ListView with RefreshIndicator
          return RefreshIndicator(
            onRefresh: viewModel.refreshData, // Trigger refresh when pulled
            child: ListView.builder(
              itemCount: viewModel.categoriesList.length,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              itemBuilder: (context, index) {
                var data = viewModel.categoriesList[index];

                if (kDebugMode) {
                  print("Title for item: ${data.title} ${data.createBy}");
                }

                return Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image Section
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(12),
                        ),
                        child: CachedNetworkImage(
                          height: 200,
                          width: double.infinity,
                          imageUrl: "${ApiUrl.imageViewPath}${data.image}",
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                          const Icon(Icons.error, size: 50, color: Colors.red),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title and Rating Row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 15,
                                        backgroundColor: Colors.grey[200],
                                        child: ClipOval(
                                          child: CachedNetworkImage(
                                            height: 30,
                                            width: 30,
                                            imageUrl: "${ApiUrl.imageViewPath}${data.user!.profile}",
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                            const CircularProgressIndicator(),
                                            errorWidget: (context, url, error) =>
                                            const Icon(Icons.error, size: 15),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          data.createBy ?? "Product Name",
                                          style: const TextStyle(


                                            fontSize: 12,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: List.generate(
                                    5,
                                        (index) => Icon(
                                      Icons.star,
                                      size: 16,
                                      color: index < (data.rating ?? 0)
                                          ? Colors.amber
                                          : Colors.grey[400],
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 8),

                            // Views and Category Row
                            Row(
                              children: [
                                const Text(
                                  "2 Views",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                const Icon(Icons.newspaper, size: 16, color: Colors.teal),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    data.category?.name ?? "Category not available",
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.teal,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 8),

                            // Author Name
                            Text(
                              data.title ?? "Author Name",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,

                              ),
                            ),

                            const SizedBox(height: 8),

                            // Description and Icons Row
                            Row(
                              children: [
                                // Description
                                Expanded(
                                  child: Text(
                                    data.description ?? "Description not available",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[700],
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),

                                // Action Icons
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Get.toNamed(Route_App.createView, parameters: {
                                          "id": "${data.id}",
                                        });
                                      },
                                      icon: const Icon(Icons.edit, color: Colors.teal),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        // Add delete logic here
                                      },
                                      icon: const Icon(Icons.delete, color: Colors.red),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
      bottomNavigationBar: Footer(),
    );
  }
}

