import 'package:add_card_shop/model/postRegister/base_post_reques.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../../model/postRegister/post_category.dart';
import '../../../../../repository/post/repository_product/repositories_All.dart';
import '../../../../../status.dart';

class PostCategoryFormViewModel extends GetxController {
  var CategoryNameController = TextEditingController().obs;
  var repositoriesAll = RepositoriesAll();
  var onCreateLoading = false.obs;
  var requestCategoryLoadingStatus = Status.loading.obs;
  void setRequestCategoryLoadingStatus(Status value) =>
      requestCategoryLoadingStatus.value = value;

  var categoryRequest = PostCategory().obs;

  @override
  void onInit() {
    // _getCategoryById();
    super.onInit();
  }
  onCreateCategory() async {
    try {
      onCreateLoading(true);
      if (CategoryNameController.value.text.isEmpty) {
        Get.snackbar("Error", "please Enter CategoryName");
        return;
      }

      categoryRequest.value.name = CategoryNameController.value.text;
      categoryRequest.value.status = ("ACT");
      var response = await repositoriesAll.createPost(categoryRequest.value);
      if (response.code == "SUC-000") {
        Get.back(result: true);
      } else {
        Get.snackbar("Error", response.message ?? "");
      }
    } finally {
      onCreateLoading(false);
    }
  }
}
