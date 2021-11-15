import 'package:bitirme_projesi/controller/db_controller.dart';

class RegisterViewModel {
  bool userRegisterFuture = false;
  String userLoginFuture='';

  Future<bool> userRegister(
      String mail, String password, String name, String location) async {
      userRegisterFuture = await DbConnection().registerUser(mail, password, name, location);
      return userRegisterFuture;
  }
  Future<String> userLogIn(String mail,String password)async{
    userLoginFuture = await DbConnection().loginUser(mail, password);
    print(userLoginFuture);
    return userLoginFuture;
  }

}
