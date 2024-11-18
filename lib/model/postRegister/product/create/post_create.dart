// import 'category.dart';
//
// class PostCreate {
//   PostCreate({
//       this.createAt,
//       this.image,
//       this.createBy,
//       this.updateAt,
//       this.updateBy,
//       this.id,
//       this.title,
//       this.description,
//       this.totalView,
//       this.status,
//       this.category,});
//
//   PostCreate.fromJson(dynamic json) {
//     createAt = json['createAt'];
//     image = json['image'];
//     createBy = json['createBy'];
//     updateAt = json['updateAt'];
//     updateBy = json['updateBy'];
//     id = json['id'];
//     title = json['title'];
//     description = json['description'];
//     totalView = json['totalView'];
//     status = json['status'];
//     category = json['category'] != null ? Category.fromJson(json['category']) : null;
//   }
//   String? createAt;
//   String? image;
//   String? createBy;
//   String? updateAt;
//   String? updateBy;
//   int? id;
//   String? title;
//   String? description;
//   int? totalView;
//   String? status;
//   Category? category;
//
//
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['createAt'] = createAt;
//     map['image'] = image;
//     map['createBy'] = createBy;
//     map['updateAt'] = updateAt;
//     map['updateBy'] = updateBy;
//     map['id'] = id;
//     map['title'] = title;
//     map['description'] = description;
//     map['totalView'] = totalView;
//     map['status'] = status;
//     if (category != null) {
//       map['category'] = category?.toJson();
//     }
//     return map;
//   }
//
//
// }
// import 'category.dart';
//
// class PostCreate {
//   PostCreate({
//     this.createAt,
//     this.image,
//     this.createBy,
//     this.updateAt,
//     this.updateBy,
//     this.id,
//     this.title,
//     this.description,
//     this.totalView,
//     this.status,
//     this.category,
//   });
//
//   PostCreate.fromJson(dynamic json) {
//     createAt = json['createAt'];
//     image = json['image'];
//     createBy = json['createBy'];
//     updateAt = json['updateAt'];
//     updateBy = json['updateBy'];
//     id = json['id'];
//     title = json['title'];
//     description = json['description'];
//     totalView = json['totalView'];
//     status = json['status'];
//     category = json['category'] != null ? Category.fromJson(json['category']) : null;
//   }
//
//   String? createAt;
//   String? image; // This will store the base64 image
//   String? createBy;
//   String? updateAt;
//   String? updateBy;
//   int? id;
//   String? title;
//   String? description;
//   int? totalView;
//   String? status;
//   Category? category;
//
//   void setBase64Image(String? base64Image) {
//     // Check if the image is null or empty
//     if (base64Image == null || base64Image.isEmpty) {
//       print("Error: Base64 image is null or empty");
//       image = "";  // Set a default empty string if null or empty
//     } else {
//       image = base64Image;  // Set the base64 string to the image field
//     }
//   }
//
//
//
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['createAt'] = createAt;
//     map['image'] = image;
//     map['createBy'] = createBy;
//     map['updateAt'] = updateAt;
//     map['updateBy'] = updateBy;
//     map['image'] = image ?? '';
//     map['title'] = title;
//     map['description'] = description;
//     map['totalView'] = totalView;
//     map['status'] = status;
//     if (category != null) {
//       map['category'] = category?.toJson();
//     }
//     return map;
//   }
// }
//
import 'category.dart';
class PostCreate {
  PostCreate({
    this.createAt,
    this.image,
    this.createBy,
    this.updateAt,
    this.updateBy,
    this.id,
    this.title,
    this.description,
    this.totalView,
    this.status,
    this.category,
  });

  PostCreate.fromJson(dynamic json) {
    createAt = json['createAt'];
    image = json['image'];
    createBy = json['createBy'];
    updateAt = json['updateAt'];
    updateBy = json['updateBy'];
    id = json['id'];
    title = json['title'];
    description = json['description'];
    totalView = json['totalView'];
    status = json['status'];
    category = json['category'] != null ? Category.fromJson(json['category']) : null;
  }

  String? createAt;
  String? image; // This can be null
  String? createBy;
  String? updateAt;
  String? updateBy;
  int? id;
  String? title;
  String? description;
  int? totalView;
  String? status;
  Category? category;

  // Method to set the base64 encoded image
  void setBase64Image(String base64Image) {
    image = base64Image; // Assign the base64 image string to the image field
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['createAt'] = createAt;
    map['image'] = image; // Ensure image can be null here
    map['createBy'] = createBy;
    map['updateAt'] = updateAt;
    map['updateBy'] = updateBy;
    map['id'] = id;
    map['title'] = title;
    map['description'] = description;
    map['totalView'] = totalView;
    map['status'] = status;
    if (category != null) {
      map['category'] = category?.toJson();
    }
    return map;
  }
}
