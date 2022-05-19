import '../api/auth_controller.dart';


class  Repository{
  final apiProvider = AuthController();
  Future<dynamic> loginRequest(String phone,String num) => apiProvider.loginRequest(phone, num);
}