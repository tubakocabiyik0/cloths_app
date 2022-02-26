import 'package:bitirme_projesi/controller/db_controller.dart';

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
}
