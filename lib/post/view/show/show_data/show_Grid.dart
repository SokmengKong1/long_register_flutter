import 'package:add_card_shop/App_route/route_App.dart';
import 'package:add_card_shop/post/view/show/show_data/view_model/show_Grid_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/remote/api_url.dart';
import '../../../../status.dart';
import '../fotter.dart';
import '../navbar_view.dart';

class ShowPost extends StatelessWidget {
  ShowPost({super.key});
  final ShowGridView _showGridView = Get.put(ShowGridView()); // Get the controller instance

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavbarView(),
      body:
      Obx(() {
        // if (_showGridView.LoadingRequestAllCategoryStatus.value == Status.loading) {
        //   return const Center(child: CircularProgressIndicator());
        // }
        // if (_showGridView.LoadingRequestAllCategoryStatus.value == Status.error) {
        //   return Center(
        //     child: Column(
        //       mainAxisSize: MainAxisSize.min,
        //       children: [
        //         const Text("Error occurred!"),
        //         const SizedBox(height: 10),
        //         ElevatedButton(
        //           onPressed: () {
        //             _showGridView.refreshData();
        //           },
        //           child: const Text("Retry"),
        //         ),
        //       ],
        //     ),
        //   );
        // }
        //
        // // No categories case
        // if (_showGridView.categoriesList.isEmpty) {
        //   return const Center(child: Text("No categories available"));
        // }
        return RefreshIndicator(
          onRefresh: _showGridView.refreshData, // Call _onRefresh from ShowGridView
          child: _showGridView.loading.value ? Center(child: CircularProgressIndicator())
              : GridView.builder(
            itemCount: _showGridView.categoriesList.length,
            padding: EdgeInsets.all(10),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.8,
            ),
            itemBuilder: (context, index) {
              var showData = _showGridView.categoriesList[index];
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Image Section - Expanded to take 50% of the card
                    Expanded(
                      flex: 5,
                      child: ClipRRect(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                        child: InkWell(
                          onTap: () {
                            // Pass the showData.id to the new page as an argument
                            Get.toNamed("${Route_App.detailCart}", arguments: showData);
                            print("Navigating to detail page with ID: ${showData.id}");
                          },
                          child: CachedNetworkImage(
                            imageUrl: "${ApiUrl.imageViewPath}${showData.image}",
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                          ),
                        ),
                      ),
                    ),
                    // Text and icon section - takes remaining 50%
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              showData.title ?? "",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4),
                            Text(
                              showData.category?.name ?? "",
                              style: TextStyle(color: Colors.blue, fontSize: 12),
                            ),
                            SizedBox(height: 4),
                            Expanded(
                              child: Row(
                                children: [
                                  Icon(Icons.star, color: Colors.amber, size: 14),
                                  SizedBox(width: 2),
                                  // Wrapping the title in an Expanded widget to limit its width and prevent overflow
                                  Expanded(
                                    child: Text(
                                      "${showData.title ?? ""}",
                                      style: TextStyle(fontSize: 12),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis, // Adds ellipsis (...) if text is too long
                                    ),
                                  ),
                                  Spacer(),
                                  Icon(Icons.visibility, size: 14, color: Colors.grey),
                                  SizedBox(width: 2),
                                  // Wrapping the status text similarly to prevent overflow
                                  Text(
                                    "${showData.id} Views",
                                    style: TextStyle(fontSize: 12, color: Colors.grey),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  //Text("${showData.description ?? ""}")
                                ],
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "by ${showData.createBy}",
                              style: TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                            SizedBox(height: 4),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      }),
      bottomNavigationBar: Footer(),
    );
  }
}

