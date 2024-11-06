import 'package:add_card_shop/data/remote/Network_url_app.dart';
import 'package:add_card_shop/data/remote/api_url.dart';

import 'package:add_card_shop/model/login/login_rep.dart';
import 'package:add_card_shop/model/postRegister/registerLogin.dart';
class RegisterRepositories {
  final _api = NetworkUrlApp();
  Future<LoginRep> register(RegisterLogin , rep)async{
    var response = await _api.register(ApiUrl.postAppLoginRegister, rep.tojson);
    return LoginRep.fromJson(response);
  }
}
