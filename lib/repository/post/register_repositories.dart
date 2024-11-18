import 'package:add_card_shop/data/remote/Network_url_app.dart';
import 'package:add_card_shop/data/remote/api_url.dart';
import 'package:add_card_shop/model/postRegister/registerLogin.dart';
import '../../model/postRegister/post_base_response.dart';
class RegisterRepositories {
  final _api = NetworkUrlApp();
  Future<PostBaseResponse> registerLogin (RegisterLogin req) async{
    var response  = await _api.register(ApiUrl.postAppLoginRegister, req.toJson());
    return PostBaseResponse.fromJson(response);
  }
}
