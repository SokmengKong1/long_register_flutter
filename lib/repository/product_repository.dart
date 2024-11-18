import 'package:add_card_shop/data/remote/Network_url_app.dart';
import 'package:add_card_shop/data/remote/api_url.dart';
import 'package:add_card_shop/model/postRegister/post_base_response.dart';
import 'package:add_card_shop/model/products/Product_response.dart';


class ProductRepository {
  final NetworkUrlApp _api = NetworkUrlApp();
  Future<ProductResponse> getAllProduct() async {
    var response = await _api.getApi(ApiUrl.getAllProduct);
    ProductResponse productResponse = ProductResponse.fromJson(response);
    return productResponse;
  }
}
