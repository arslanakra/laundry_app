import 'dart:convert';
/// success : true
/// message : "Category View successfully."
/// results : [{"id":28,"cat_name":"shirt","price":"200","status":0,"created_at":"2022-05-19T17:11:38.000000Z","updated_at":"2022-05-19T17:11:38.000000Z"},{"id":26,"cat_name":"Pant","price":"200","status":0,"created_at":"2022-05-19T16:14:02.000000Z","updated_at":"2022-05-19T16:14:02.000000Z"}]

CategoriesModel categoriesModelFromJson(String str) => CategoriesModel.fromJson(json.decode(str));
String categoriesModelToJson(CategoriesModel data) => json.encode(data.toJson());
class CategoriesModel {
  CategoriesModel({
      this.success, 
      this.message, 
      this.results,});

  CategoriesModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results?.add(Results.fromJson(v));
      });
    }
  }
  bool? success;
  String? message;
  List<Results>? results;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    if (results != null) {
      map['results'] = results?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 28
/// cat_name : "shirt"
/// price : "200"
/// status : 0
/// created_at : "2022-05-19T17:11:38.000000Z"
/// updated_at : "2022-05-19T17:11:38.000000Z"

Results resultsFromJson(String str) => Results.fromJson(json.decode(str));
String resultsToJson(Results data) => json.encode(data.toJson());
class Results {
  Results({
      this.id, 
      this.catName, 
      this.price, 
      this.status, 
      this.createdAt, 
      this.updatedAt,});

  Results.fromJson(dynamic json) {
    id = json['id'];
    catName = json['cat_name'];
    price = json['price'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  String? catName;
  String? price;
  int? status;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['cat_name'] = catName;
    map['price'] = price;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}