import 'dart:convert';


LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));
String loginModelToJson(LoginModel data) => json.encode(data.toJson());
class LoginModel {
  LoginModel({
      this.id, 
      this.name, 
      this.email, 
      this.number, 
      this.address, 
      this.user,});

  LoginModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    number = json['number'];
    address = json['address'];
    user = json['user'];
  }
  int? id;
  String? name;
  String? email;
  String? number;
  String? address;
  String? user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['number'] = number;
    map['address'] = address;
    map['user'] = user;
    return map;
  }

}