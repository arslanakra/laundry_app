import 'dart:convert';
GetOrderModel getOrderModelFromJson(String str) => GetOrderModel.fromJson(json.decode(str));
String getOrderModelToJson(GetOrderModel data) => json.encode(data.toJson());
class GetOrderModel {
  GetOrderModel({
      this.success, 
      this.message, 
      this.data,});

  GetOrderModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }
  bool? success;
  String? message;
  List<Data>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      this.id, 
      this.userId, 
      this.total, 
      this.lat, 
      this.lng, 
      this.status, 
      this.createdAt, 
      this.updatedAt, 
      this.orderItems,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    total = json['total'];
    lat = json['lat'];
    lng = json['lng'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['order_items'] != null) {
      orderItems = [];
      json['order_items'].forEach((v) {
        orderItems?.add(OrderItems.fromJson(v));
      });
    }
  }
  int? id;
  String? userId;
  String? total;
  double? lat;
  double? lng;
  int? status;
  String? createdAt;
  String? updatedAt;
  List<OrderItems>? orderItems;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['total'] = total;
    map['lat'] = lat;
    map['lng'] = lng;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    if (orderItems != null) {
      map['order_items'] = orderItems?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

OrderItems orderItemsFromJson(String str) => OrderItems.fromJson(json.decode(str));
String orderItemsToJson(OrderItems data) => json.encode(data.toJson());
class OrderItems {
  OrderItems({
      this.id, 
      this.orderId, 
      this.createdAt, 
      this.updatedAt, 
      this.catName, 
      this.qty,});

  OrderItems.fromJson(dynamic json) {
    id = json['id'];
    orderId = json['order_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    catName = json['cat_name'];
    qty = json['qty'];
  }
  int? id;
  String? orderId;
  String? createdAt;
  String? updatedAt;
  String? catName;
  String? qty;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['order_id'] = orderId;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['cat_name'] = catName;
    map['qty'] = qty;
    return map;
  }

}