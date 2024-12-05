// import 'package:add_card_shop/model/login/user.dart';
// import 'package:add_card_shop/model/postRegister/post_category.dart';
//
// class PostResponse {
//   PostResponse({
//     this.createAt,
//     this.createBy,
//     this.updateAt,
//     this.updateBy,
//     this.id,
//     this.title,
//     this.description,
//     this.totalView,
//     this.status,
//     this.image,
//     this.category,
//     this.user,});
//
//   PostResponse.fromJson(dynamic json) {
//     createAt = json['createAt'];
//     createBy = json['createBy'];
//     updateAt = json['updateAt'];
//     updateBy = json['updateBy'];
//     id = json['id'];
//     title = json['title'];
//     description = json['description'];
//     totalView = json['totalView'];
//     status = json['status'];
//     image = json['image'];
//     category = json['category'] != null ? PostCategory.fromJson(json['category']) : null;
//     user = json['user'] != null ? User.fromJson(json['user']) : null;
//   }
//   String? createAt;
//   String? createBy;
//   dynamic updateAt;
//   dynamic updateBy;
//   int? id;
//   String? title;
//   String? description;
//   int? totalView;
//   String? status;
//   String? image;
//   PostCategory? category;
//   User? user;
//   var price;
//   get quantity => null;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['createAt'] = createAt;
//     map['createBy'] = createBy;
//     map['updateAt'] = updateAt;
//     map['updateBy'] = updateBy;
//     map['id'] = id;
//     map['title'] = title;
//     map['description'] = description;
//     map['totalView'] = totalView;
//     map['status'] = status;
//     map['image'] = image;
//     if (category != null) {
//       map['category'] = category?.toJson();
//     }
//     if (user != null) {
//       map['user'] = user?.toJson();
//     }
//     return map;
//   }
//
// }
//
// import 'package:add_card_shop/model/login/user.dart';
// import 'package:add_card_shop/model/postRegister/post_category.dart';
//
// class PostResponse {
//   PostResponse({
//     this.createAt,
//     this.createBy,
//     this.updateAt,
//     this.updateBy,
//     this.id,
//     this.title,
//     this.description,
//     this.totalView,
//     this.status,
//     this.image,
//     this.category,
//     this.user,
//     required this.quantity, // Add quantity to the constructor
//     this.totalPrice = 0.0,
//   });
//
//   PostResponse.fromJson(dynamic json) {
//     createAt = json['createAt'];
//     createBy = json['createBy'];
//     updateAt = json['updateAt'];
//     updateBy = json['updateBy'];
//     id = json['id'];
//     title = json['title'];
//     description = json['description'];
//     totalView = json['totalView'];
//     status = json['status'];
//     image = json['image'];
//     category = json['category'] != null ? PostCategory.fromJson(json['category']) : null;
//     user = json['user'] != null ? User.fromJson(json['user']) : null;
//     quantity = json['quantity'] ?? 0; // Deserialize quantity, default to 0 if not present
//
//   }
//
//   String? createAt;
//   String? createBy;
//   dynamic updateAt;
//   dynamic updateBy;
//   int? id;
//   String? title;
//   String? description;
//   int? totalView;
//   String? status;
//   String? image;
//   PostCategory? category;
//   User? user;
//   int quantity = 0;
//   get price => 20;
//   dynamic totalPrice;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['createAt'] = createAt;
//     map['createBy'] = createBy;
//     map['updateAt'] = updateAt;
//     map['updateBy'] = updateBy;
//     map['id'] = id;
//     map['title'] = title;
//     map['description'] = description;
//     map['totalView'] = totalView;
//     map['status'] = status;
//     map['image'] = image;
//     map['quantity'] = quantity; // Add quantity to the JSON serialization
//     if (category != null) {
//       map['category'] = category?.toJson();
//     }
//     if (user != null) {
//       map['user'] = user?.toJson();
//     }
//     return map;
//   }
// }
import 'package:add_card_shop/model/login/user.dart';
import 'package:add_card_shop/model/postRegister/post_category.dart';

class PostResponse {
  late int quantity;  // Using late to defer initialization
  late dynamic totalPrice;  // Using late to defer initialization
  PostResponse({
    this.createAt,
    this.createBy,
    this.updateAt,
    this.updateBy,
    this.id,
    this.title,
    this.description,
    this.totalView,
    this.status,
    this.image,
    this.category,
    this.user,
    required this.quantity,
    this.totalPrice = 0.0,
  });

  // Factory constructor for creating a PostResponse from a JSON map
  PostResponse.fromJson(Map<String, dynamic> json) {
    createAt = json['createAt'];
    createBy = json['createBy'];
    updateAt = json['updateAt'];
    updateBy = json['updateBy'];
    id = json['id'];
    title = json['title'];
    description = json['description'];
    totalView = json['totalView'];
    status = json['status'];
    image = json['image'];
    category = json['category'] != null ? PostCategory.fromJson(json['category']) : null;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    quantity = json['quantity'] ?? 0; // Default to 0 if quantity is not provided
    totalPrice = json['totalPrice'] ?? 0.0; // Default to 0 if totalPrice is not provided
  }

  // Instance variables
  String? createAt;
  String? createBy;
  dynamic updateAt;
  dynamic updateBy;
  int? id;
  String? title;
  String? description;
  int? totalView;
  String? status;
  String? image;
  PostCategory? category;
  User? user;

  // Price is dynamic, but assumed fixed for simplicity in this example
  double get price => 20.0;

  // Method to convert a PostResponse object into a JSON map
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['createAt'] = createAt;
    map['createBy'] = createBy;
    map['updateAt'] = updateAt;
    map['updateBy'] = updateBy;
    map['id'] = id;
    map['title'] = title;
    map['description'] = description;
    map['totalView'] = totalView;
    map['status'] = status;
    map['image'] = image;
    map['quantity'] = quantity; // Store quantity in JSON
    map['totalPrice'] = totalPrice; // Store totalPrice in JSON
    if (category != null) {
      map['category'] = category?.toJson();  // Ensure category is serialized
    }
    if (user != null) {
      map['user'] = user?.toJson();  // Ensure user is serialized
    }
    return map;
  }

  // Method to update totalPrice based on quantity and price
  void updateTotalPrice() {
    totalPrice = quantity * price;
  }

  // Setter for quantity that automatically updates totalPrice
  set updateQuantity(int newQuantity) {
    quantity = newQuantity;
    updateTotalPrice(); // Recalculate total price whenever quantity changes
  }
}
