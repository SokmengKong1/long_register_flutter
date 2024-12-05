import 'dart:io';

import 'package:add_card_shop/data/remote/Network_url_app.dart';
import 'package:add_card_shop/data/remote/api_url.dart';
import 'package:add_card_shop/model/postRegister/base_post_reques.dart';

import 'package:add_card_shop/model/postRegister/post_base_response.dart';

import 'package:add_card_shop/model/postRegister/product/post_response.dart';

import '../../../model/postRegister/product/create/post_create.dart';
import '../../../model/postRegister/product/post_body_request.dart';


class RepositoriesAll {
   final NetworkUrlApp apiService = NetworkUrlApp();
   Future<PostBaseResponse> getCategoryById (BasePostRequest req) async{
     var response  = await apiService.postApi(ApiUrl.getAllPostPath+req.id.toString(), req.toJson());
     return PostBaseResponse.fromJson(response);
   }

   // Future<PostBaseResponse> getPostById(BasePostRequest req) async{
   //   var response = await apiService.postApi(ApiUrl.getAllPostPath+req.id.toString(), req.toJson());
   //   return PostBaseResponse.fromJson(response);
   // }
   // Future<PostResponse> addCard(PostResponse req) async {
   //   var response = await apiService.postApi(ApiUrl.getAllPostPath, req.toJson());
   //   return PostResponse.fromJson(response);
   // }


   Future<PostBaseResponse> getAllPostCategories(BasePostRequest req) async{
     var response = await apiService.postApi(ApiUrl.postCategory, req.toJson());
     return PostBaseResponse.fromJson(response);
   }

  Future<PostBaseResponse> createPost(PostCreate req) async {
    var response = await apiService.postApi(ApiUrl.createPostPath, req.toJson());
    return PostBaseResponse.fromJson(response);
  }

  Future<PostBaseResponse> getAllPosts(PostBodyRequest req) async {
    var response =
        await apiService.postApi(ApiUrl.getAllPostPath, req.toJson());
    return PostBaseResponse.fromJson(response);
  }

  Future<PostResponse> getById(int id) async {
    var response = await apiService.getApi("${ApiUrl.getAllPostPath}/${id}");
    return PostResponse.fromJson(response);
  }
   Future<PostBaseResponse> uploadImage(File imageFile) async {
     var response = await apiService.uploadImage(imageFile);
     return PostBaseResponse.fromJson(response);
   }

}
