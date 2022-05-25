import 'package:laundry_app_ui/api/api_provider.dart';

import '../api/auth_controller.dart';


class  Repository{

  final auth = AuthController();
  final apiProvider = ApiProvider();
  Future<dynamic> loginRequest(String phone,String num) => auth.loginRequest(phone, num);
  Future<dynamic> getCat() => apiProvider.getCategories();
}