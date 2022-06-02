import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/LoginModel.dart';
import '../utils/api_paths.dart';


class AuthController extends GetxController{

  String success = '',isRegistered='',address='';
  Position? currentPosition;
  final Geolocator geoLocator = Geolocator();
  LocationPermission? permission;
  List<Placemark>? placemark;
  var status;
    TextEditingController emailController = TextEditingController()
                          ,regEmailController = TextEditingController()
                          ,passController = TextEditingController()
                          ,regPassController = TextEditingController()
                          ,regConfirmPassController = TextEditingController()
                          ,addressController = TextEditingController()
                          ,numberController = TextEditingController()
                          ,nameController = TextEditingController();




  Future loginRequest(String email,String pass) async {

    var body = {'email': email,'password':pass};

    final response = await http
        .post(Uri.parse(ApiPaths.baseURL + ApiPaths.login), body: body);


    if(response.statusCode == 201) {
      print(response.body);
      return loginModelFromJson(response.body);
    }else if(response.statusCode == 404){
      Get.snackbar('Error', 'Not Found', snackPosition: SnackPosition.BOTTOM);
    }else if(response.statusCode == 401){
      Map mapRes = json.decode(response.body);
      status = mapRes['Status'];
      Get.snackbar('Error', 'Invalid email or password', snackPosition: SnackPosition.BOTTOM,backgroundColor:Colors.red,colorText: Colors.white);
    }
    update();
  }
  Future signupRequest(String name,String email,String pass,String number,String address) async {

    var body = {'name': name,'email': email,'password':pass,'number':number,'address':address};
    final response = await http
        .post(Uri.parse(ApiPaths.baseURL + ApiPaths.register), body: body);
    if(response.statusCode == 201) {
      isRegistered = 'Success';
      Get.snackbar('Success', 'User Registered Successfully', snackPosition: SnackPosition.BOTTOM);
    }else if(response.statusCode == 404){
      Get.snackbar('Error', 'Not Found', snackPosition: SnackPosition.BOTTOM);
    }else if(response.statusCode == 400){
      Get.snackbar('Error', 'Invalid email or number', snackPosition: SnackPosition.BOTTOM,backgroundColor:Colors.red,colorText: Colors.white);
    }
    update();
  }

  getLocation() async {
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        return;
      }
    }
    Position position = await Geolocator.getCurrentPosition();
    currentPosition = position;

    placemark = await placemarkFromCoordinates(currentPosition!.latitude,currentPosition!.longitude);


    address = '${placemark!.first.name},${placemark!.first.subThoroughfare} ${placemark![2].subLocality}, ${placemark![3].locality},${placemark![4].country}';

    update();

  }


}
