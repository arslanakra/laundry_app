
import '../repository.dart';

class LoginUser{
  final repository = Repository();
  var _userLogin;
  dynamic get userLoginModel =>_userLogin;
  getUserLogin(String email,String pass)async{
    dynamic userLoginsModel = await repository.loginRequest(email,pass);
    _userLogin = userLoginsModel;
  }
  dispose(){
    _userLogin.close();
  }
}
final userLoginBloc = LoginUser();