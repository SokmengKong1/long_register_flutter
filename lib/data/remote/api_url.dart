class ApiUrl{
  static const String baseUrl = "https://dummyjson.com";
  static const String getAllCategory = "$baseUrl/products/categories";
  static const String getAllProduct = "$baseUrl/products";


  static const String getAllProductByUrl = "$baseUrl/products/category";




  static const String baseUrlPostApp  = "http://194.233.91.140:20099";
  static const String postAppLoginPath  = "$baseUrlPostApp/api/oauth/token";
  static const String postAppLoginRegister  = "$baseUrlPostApp/api/oauth/register";
  static const String postCategory  = "$baseUrlPostApp/api/app/category/list";
  static const String postRefreshToken  = "$baseUrlPostApp/api/oauth/refresh";
  static const String postCreateCategory  = "$baseUrlPostApp/api/app/category/create";

}