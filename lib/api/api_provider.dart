import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:laundry_app_ui/controller/OrderController.dart';
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
}