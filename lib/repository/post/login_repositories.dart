import 'package:add_card_shop/data/remote/Network_url_app.dart';
import 'package:add_card_shop/data/remote/api_url.dart';
import 'package:add_card_shop/model/login/login_rep.dart';
import 'package:add_card_shop/model/login/login_req.dart';
import 'package:get_storage/get_storage.dart';

class LoginRepositories{
  final _api = NetworkUrlApp();
  Future<LoginRep> login({String? username,String? password}) async {
    var requestBody = LoginReq(phoneNumber: username,password: password);
    var responseLogin = await _api.loginApi(ApiUrl.postAppLoginPath, requestBody.toJson());
    // saveUserLocal(responseLogin);
    return LoginRep.fromJson(responseLogin);
  }


  Future<void> saveUserLocal(LoginRep data) async {
    var storage = GetStorage();
    storage.write("USER_KEY", data.toJson());
  }
  Future<void> removeUserLocal() async {
    var storage = GetStorage();
    storage.remove("USER_KEY");
  }


  Future<LoginRep> getUserLocal() async {
    LoginRep response = LoginRep();
    var storage = GetStorage();
    var user = storage.read("USER_KEY");
    if (user != null) {
      response = LoginRep.fromJson(user);
    }
    return response;
  }
}