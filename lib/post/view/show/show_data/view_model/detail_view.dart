
import 'package:add_card_shop/repository/post/repository_product/repositories_All.dart';
import 'package:get/get.dart';

import '../../../../../model/postRegister/product/post_response.dart';
class DetailView extends GetxController{
  var postResponse = PostResponse().obs;
  var loading = true.obs;
  final repositoriesAll = RepositoriesAll();
  @override
  void onInit() {
    fetchProductById();
    super.onInit();
  }
  fetchProductById()async{
    try{
      loading(true);
      var response = await repositoriesAll.getById(Get.arguments ?? 0);
      postResponse.value = response;
    }
    finally{
      loading(false);
    }

  }


}

