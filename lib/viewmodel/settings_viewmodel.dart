import 'package:bitirme_projesi/controller/db_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsViewModel {
  bool updated;

  Future<bool> updateUser(
      {String oldMail, String mail, String name, String location}) async {
    try {
      updated = await DbConnection().updateUser(
          oldMail: oldMail, userMail: mail, userName: name, location: location);
    } finally  {

    }
    return updated;
  }
  Future<bool> updatePassword(
      {String oldMail,String password}) async {
    try {
      updated = await DbConnection().updatePassword(password,oldMail);
    } finally  {

    }

    return updated;
  }

  Future getCurrentId()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.getInt("user_id");
  }

}
