import 'package:add_card_shop/App_route/route_App.dart';
import 'package:add_card_shop/repository/post/repository_product/repositories_All.dart';
import 'package:get/get.dart';

import '../../../../model/postRegister/base_post_reques.dart';
import '../../../../model/postRegister/post_category.dart';
import '../../../../repository/post/widget/showCustomToast.dart';
import '../../../../status.dart';

class PostCategoryViewModel extends GetxController{
  final _repository = RepositoriesAll();
  var categoryList = <PostCategory>[].obs;
  var loadingRequestAllCategoryStatus = Status.loading.obs;

  void setLoadingRequestAllCategoryStatus(Status value) => loadingRequestAllCategoryStatus.value = value;

  var baseRequest = BasePostRequest().obs;

  @override
  void onInit() {
    _loadingCategoryData();
    super.onInit();
  }

  _loadingCategoryData() async{
    setLoadingRequestAllCategoryStatus(Status.loading);
    await _fetchAllCategories();
    setLoadingRequestAllCategoryStatus(Status.completed);

  }
  _fetchAllCategories() async{
    print("fetching all categories");
    try {
      var response = await _repository.getAllPostCategories(baseRequest.value);
      response.data.forEach((data) {
        categoryList.add(PostCategory.fromJson(data));
      });
    }
    // catch(e){
    //   setLoadingRequestAllCategoryStatus(Status.error);
    //   showCustomToast(message: e.toString());
    // }
    finally{
      setLoadingRequestAllCategoryStatus(Status.completed);
    }
  }

  void onCreate() {
    print("ON CREATE");
    Get.toNamed(Route_App.postManageCreateCategoryPath, parameters: {
      "id":"0"
    })?.then((onValue){
      if(onValue == true){
        print("ON VALUE TRUE");
        categoryList.value = [];
        showCustomToast(message: "Category Created Successfully");
        _fetchAllCategories();
      }
    });
  }

  void onUpdate(String id) {
    print("ON UPDATE");
    Get.toNamed(Route_App.createView, parameters: {
      "id":"${id}"
    })?.then((onValue){
      if(onValue == true){
        print("ON VALUE TRUE");
        categoryList.value = [];
        showCustomToast(message: "Category Updated Successfully");
        _fetchAllCategories();
      }
    });
  }
}
