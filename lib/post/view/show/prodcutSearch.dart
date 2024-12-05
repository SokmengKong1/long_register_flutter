
import 'package:add_card_shop/post/view/show/show_data/view_model/show_Grid_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../App_route/route_App.dart';
import '../../../data/remote/api_url.dart';
import '../../../model/postRegister/product/post_response.dart';
import 'navbar_view.dart';
class ProductSearch extends SearchDelegate {
  final ShowGridView _showGridView = Get.put(ShowGridView()); // Get the controller instance
  final List<PostResponse> postResponse;

  // Constructor to initialize postResponse
  ProductSearch({required this.postResponse});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: const Icon(Icons.close),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    // Filtering the postResponse based on query
    List<PostResponse> filter = postResponse.where((element) {
      return element.title!.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return Scaffold(
      body: Obx(() {
        return _showGridView.loading.value
            ? const Center(child: CircularProgressIndicator())
            : GridView.builder(
          itemCount: filter.isEmpty ? postResponse.length : filter.length, // Use filtered length
          padding: const EdgeInsets.all(10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 0.8,
          ),
          itemBuilder: (context, index) {
            var showData = filter.isEmpty ? postResponse[index] : filter[index];

            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Image Section
                  Expanded(
                    flex: 5,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                      child: InkWell(
                        onTap: () {},
                        child: CachedNetworkImage(
                          imageUrl: "${ApiUrl.imageViewPath}${showData.image}",
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
                      ),
                    ),
                  ),
                  // Text Section
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            showData.title ?? "",
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            showData.category?.name ?? "",
                            style: const TextStyle(color: Colors.blue, fontSize: 12),
                          ),
                          const SizedBox(height: 4),
                          Expanded(
                            child: Row(
                              children: [
                                const Icon(Icons.star, color: Colors.amber, size: 14),
                                const SizedBox(width: 2),
                                Expanded(
                                  child: Text(
                                    showData.title ?? "",
                                    style: const TextStyle(fontSize: 12),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const Spacer(),
                                const Icon(Icons.visibility, size: 14, color: Colors.grey),
                                const SizedBox(width: 2),
                                Text(
                                  "${showData.id} Views",
                                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "by ${showData.createBy}",
                            style: const TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                          const SizedBox(height: 4),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<PostResponse> filter = postResponse.where((element) {
      return element.title!.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return Scaffold(
      body: Obx(() {
        return _showGridView.loading.value
            ? const Center(child: CircularProgressIndicator())
            : GridView.builder(
          itemCount: filter.isEmpty ? postResponse.length : filter.length, // Use filtered length
          padding: const EdgeInsets.all(10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 0.8,
          ),
          itemBuilder: (context, index) {
            var showData = filter.isEmpty ? postResponse[index] : filter[index];

            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Image Section
                  Expanded(
                    flex: 5,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                      child: InkWell(
                        onTap: () {
                          Get.toNamed("${Route_App.detailCart}", arguments: showData);
                          print("Navigating to detail page with ID: ${showData.id}");
                        },
                        child: CachedNetworkImage(
                          imageUrl: "${ApiUrl.imageViewPath}${showData.image}",
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
                      ),
                    ),
                  ),
                  // Text Section
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            showData.title ?? "",
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            showData.category?.name ?? "",
                            style: const TextStyle(color: Colors.blue, fontSize: 12),
                          ),
                          const SizedBox(height: 4),
                          Expanded(
                            child: Row(
                              children: [
                                const Icon(Icons.star, color: Colors.amber, size: 14),
                                const SizedBox(width: 2),
                                Expanded(
                                  child: Text(
                                    showData.title ?? "",
                                    style: const TextStyle(fontSize: 12),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const Spacer(),
                                const Icon(Icons.visibility, size: 14, color: Colors.grey),
                                const SizedBox(width: 2),
                                Text(
                                  "${showData.id} Views",
                                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "by ${showData.createBy}",
                            style: const TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                          const SizedBox(height: 4),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}

