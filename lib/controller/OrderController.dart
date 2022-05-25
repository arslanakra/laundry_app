import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

import '../utils/api_paths.dart';

class OrderController extends GetxController{
  List<TextEditingController> controllers = [];
  int total = 0;
  Map<String,dynamic> orderBody = {};
  // List<String> catList =[];
  List<int> data =[];
  List<Map<String,String>> categoryList = [];
  Position? currentPosition;
  final Geolocator geoLocator = Geolocator();
  LocationPermission? permission;
  Client client = Client();
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
      update();

  }

  setValuesCalculate(int text,int qty,String cat){
    if(text != 0) {

      data.clear();
      data.add(text * qty);
      for(var v in data){
        total += v;
      }
      print(total);
      if(cat !=''){
        categoryList.add({
          'cat_name':cat,
          'qty':qty.toString()
        });
        print(categoryList);
      }
    }else{
      total = 0;
    }
    update(['NewOrderScreen',true]);
  }


  sendOrder(var body) async{
    final response = await client.post(Uri.parse(ApiPaths.baseURL +  ApiPaths.order),
        headers: <String,String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: body
    );

    print(response.statusCode == 200 ? 'Status: OK' : response.body.toString());
    if(response.statusCode == 200){
      Get.snackbar('Success', 'Order Placed');
      myDispose();
    }else{
      print(response.body);
      Get.snackbar('Error', 'Server Error');
    }
  }
void myDispose(){
  orderBody.clear();
  categoryList=[];
  total = 0;
  data.clear();
  controllers.clear();
  update(['NewOrderScreen',true]);
}


}