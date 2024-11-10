import 'package:add_card_shop/data/remote/Network_url_app.dart';
import 'package:add_card_shop/data/remote/api_url.dart';
import 'package:add_card_shop/model/postRegister/base_post_reques.dart';
import 'package:add_card_shop/model/postRegister/post_base_response.dart';

import '../../../model/postRegister/post_category.dart';
import '../../../model/postRegister/product/post_body_request.dart';
import '../../../model/products/Product_response.dart';

class RepositoriesAll{
  final NetworkUrlApp apiService = NetworkUrlApp();
  Future<PostBaseResponse> getAllPostCategory(BasePostRequest req)async{
    var response = await apiService.postApi(ApiUrl.getAllPostPath,req.toJson());
    print("Hello${response}");
    return PostBaseResponse.fromJson(response);

  }
  Future<PostBaseResponse> createPost (PostCategory req) async{
    var response  = await apiService.postApi(ApiUrl.createPostPath,req.toJson());
    return PostBaseResponse.fromJson(response);
  }

  Future<PostBaseResponse> getAllPosts(PostBodyRequest req)async{
    var response = await apiService.postApi(ApiUrl.getAllPostPath,req.toJson());
    return PostBaseResponse.fromJson(response);
  }
}