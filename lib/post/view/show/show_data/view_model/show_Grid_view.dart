import 'package:add_card_shop/repository/post/repository_product/repositories_All.dart';
import 'package:get/get.dart';

import '../../../../../model/postRegister/product/post_body_request.dart';
import '../../../../../model/postRegister/product/post_response.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../../../status.dart';

class ShowGridView extends GetxController {
  var categoriesList = <PostResponse>[].obs; // Observable list for the grid data
  var loading = false.obs;
  var LoadingRequestAllCategoryStatus = Status.loading.obs;

  void setLoadingRequestAllCategory(Status value) =>
      LoadingRequestAllCategoryStatus.value = value;



  PostResponse? postResponse;
  final _repositoriesAll = RepositoriesAll(); // Repository instance

  // Method to get all data (with optional refresh flag)
  Future<void> getAllData({bool isRefresh = false}) async {
    try {
      loading(true);
      if (isRefresh) {
        // Clear the list if refreshing
        categoriesList.clear();
      }
      var request = PostBodyRequest();
      var response = await _repositoriesAll.getAllPosts(request);
      response.data.forEach((data) {
        categoriesList.add(PostResponse.fromJson(data));
      });
    } catch (e) {
      print('Error fetching data: $e');
    } finally {
      loading(false);
    }
  }
  // Method to trigger refresh
  Future<void> refreshData() async {
    LoadingRequestAllCategoryStatus.value = Status.loading;
    await getAllData();
    //await getAllData(isRefresh: true); // Trigger refresh logic
    try{
      await getAllData();
      LoadingRequestAllCategoryStatus.value = Status.completed;
    }catch (e) {
      LoadingRequestAllCategoryStatus.value = Status.error;
      print("Error refreshing data: $e");
    }
  }

}
