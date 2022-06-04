import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:laundry_app_ui/controller/OrderController.dart';
import 'package:laundry_app_ui/models/CancelOrder.dart';
import 'package:laundry_app_ui/models/GetOrderModel.dart';
import 'package:laundry_app_ui/ui/navigationScreen.dart';

import '../models/CategoriesModel.dart';
import '../utils/api_paths.dart';

class ApiProvider{
  Client client = Client();
  getCategories() async{
    final response = await client.get(Uri.parse(ApiPaths.baseURL +  ApiPaths.cat),
        headers: <String,String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        }
    );
    print(response.statusCode == 200 ? 'Status: OK' : response.body.toString());
    if(response.statusCode == 201){
      return categoriesModelFromJson(response.body);
    }else{

      Get.snackbar('Error', 'Server Error');
    }
  }

  getOrders(int id) async{
    final response = await client.get(Uri.parse(ApiPaths.baseURL +  ApiPaths.getOrder + id.toString()),
        headers: <String,String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        }
    );
    print(response.statusCode == 200 ? 'Status: OK' : response.body.toString());
    if(response.statusCode == 200){
      print(response.body);
      return getOrderModelFromJson(response.body);
    }else{

      Get.snackbar('Error', 'Server Error');
    }
  }

  cancelOrder(int id) async{
    final response = await client.delete(Uri.parse(ApiPaths.baseURL +  ApiPaths.cancel + id.toString()),
        headers: <String,String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        }
    );
    print(response.statusCode == 200 ? 'Status: OK' : response.body.toString());
    if(response.statusCode == 200){
      print(response.body);
      return cancelOrderFromJson(response.body);
    }else{

      Get.snackbar('Error', 'Server Error');
    }
  }
}