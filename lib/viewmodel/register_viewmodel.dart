import 'package:bitirme_projesi/controller/db_controller.dart';

class RegisterViewModel {
  bool userFuture = false;

  Future<bool> userRegister(
      String mail, String password, String name, String location) async {
      userFuture = await DbConnection().registerUser(mail, password, name, location);
      return userFuture;
  }
}
