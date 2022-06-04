import 'dart:convert';
CancelOrder cancelOrderFromJson(String str) => CancelOrder.fromJson(json.decode(str));
String cancelOrderToJson(CancelOrder data) => json.encode(data.toJson());
class CancelOrder {
  CancelOrder({
      this.success, 
      this.message,});

  CancelOrder.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
  }
  bool? success;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    return map;
  }

}