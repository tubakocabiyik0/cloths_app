import 'package:bitirme_projesi/config/db.dart';
import 'package:bitirme_projesi/models/images.dart';
import 'package:postgres/postgres.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DbConnection {
  String mail = '';

  String password = '';

  String name = '';

  String location = '';

  // ignore: non_constant_identifier_names
  String image_url = '';
  String user_mail = '';
  String user_location = '';

  PostgreSQLConnection connection;
  PostgreSQLResult loginResult;
  PostgreSQLResult imageDeleted;
  PostgreSQLResult userRegisteredResult;
  PostgreSQLResult userAlreadyRegistered;
  PostgreSQLResult imageAddedResult;
  PostgreSQLResult dataFetched;
  PostgreSQLResult getId;
  PostgreSQLResult passwordUpdated;
  PostgreSQLResult imageUpdatedResult;
  static String userMailAddress;
  bool _isUserLoggedIn;

  DbConnection() {
    connection = (connection == null || connection.isClosed == true
        ? PostgreSQLConnection(
            '10.0.2.2',
            5432,
            'flutter_db',
            username: 'postgres',
            password: '123456',
            timeoutInSeconds: 30,
            queryTimeoutInSeconds: 30,
            timeZone: 'UTC',
            useSSL: false,
            isUnixSocket: false,
          )
        : connection);

    //fetchDataFuture = [];
  }

  bool newUserFuture = false;

  //User Register
  Future<bool> registerUser(
      String mail, String password, String name, String location) async {
    try {
      await connection.open();
      await connection.transaction((connection) async {
        userAlreadyRegistered = await connection.query(
            'select * from users where mail =@mail',
            substitutionValues: {'mail': mail},
            allowReuse: true,
            timeoutInSeconds: 30);
        // user mail already register control
        if (userAlreadyRegistered.affectedRowCount > 0) {
          newUserFuture = false;
        } else {
          userRegisteredResult = await connection.query(
            'insert into users (mail,password,name,location)'
            'values(@mail,@password,@name,@location)',
            substitutionValues: {
              'mail': mail,
              'password': password,
              'name': name,
              'location': location,
            },
            allowReuse: true,
            timeoutInSeconds: 30,
          );
          //saving sharedPreferences
          await SharedPreferences.getInstance()
              .then((value) => value.setBool('isLoggedIn', true));
          await SharedPreferences.getInstance()
              .then((value) => value.setString('userMail', mail));
          await SharedPreferences.getInstance()
              .then((value) => value.setString('user_location', location));
          await SharedPreferences.getInstance()
              .then((value) => value.setString('user_name', name));
          newUserFuture = true;
          // ignore: unnecessary_statements
          (userRegisteredResult.affectedRowCount > 0 ? true : false);
        }
      });
      await getUserId(mail);
      return newUserFuture;
    } catch (e) {
      print("hata" + e.toString());
    }
  }

  String userLoginFuture = '';

  Future<String> loginUser(String mail, String password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      await connection.open();
      await connection.transaction((connection) async {
        // check mail registered or not
        loginResult = await connection.query(
          'select mail,password,location,name from users where mail =@mail',
          substitutionValues: {'mail': mail},
          allowReuse: true,
          timeoutInSeconds: 30,
        );
        if (loginResult.affectedRowCount > 0) {
          userMailAddress = loginResult.first.elementAt(0);
          //controling password is true
          if (loginResult.first.elementAt(1).toString() ==
              password.toString()) {
            userLoginFuture = "logged in";

            sharedPreferences.setBool('isLoggedIn', true);
            sharedPreferences.setString('userMail', mail);
            sharedPreferences.setString(
                'user_location', loginResult.first.elementAt(2).toString());
            sharedPreferences.setString(
                'user_name', loginResult.first.elementAt(3).toString());
          } else if (loginResult.first.elementAt(1).contains(password) ==
              false) {
            userLoginFuture = "wrong password";
          }
        } else {
          userLoginFuture = "this mail address can't find";
        }
      });
      await getUserId(mail);
    } catch (e) {
      print("error is " + e.toString());
    }
    return userLoginFuture;
  }

  Future<bool> userLoggedIn() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      _isUserLoggedIn = prefs.getBool('isLoggedIn') ?? false;
      return _isUserLoggedIn;
    } catch (e) {
      print(e);
    }
  }

  bool imageSavedFuture = false;

  Future<bool> saveImages(
      String image,
      int user_id,
      String userMail,
      String selectedCategory,
      String selectedSeason,
      String selectedColor) async {
    try {
      await connection.open();
      await connection.transaction((connection) async {
        imageAddedResult = await connection.query(
          'insert into images (image_url,user_id,user_mail,category,season,color) values(@image_url,@user_id,@user_mail,@category,@season,@color)',
          substitutionValues: {
            'image_url': image,
            'user_id': user_id,
            'user_mail': userMail,
            'category': selectedCategory,
            'season': selectedSeason,
            'color': selectedColor
          },
          allowReuse: true,
          timeoutInSeconds: 30,
        );

        //controlling image added as row
        imageSavedFuture = true;
      });
      return imageSavedFuture;
    } catch (e) {
      print("error is " + e.toString());
      return false;
    }
  }

  Future<bool> deleteImage(String image_url) async {
    try {
      await connection.open();
      await connection.transaction((connection) async {
        imageDeleted = await connection.query(
          'delete from images where image_url = @image_url',
          substitutionValues: {'image_url': image_url},
          allowReuse: true,
          timeoutInSeconds: 30,
        );
      });
      if (imageDeleted.affectedRowCount > 0) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("error is " + e.toString());
    }
  }

  Future<String> getLocation() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String result = sharedPreferences.getString('location').toString();
    return result;
  }

  Future<List<ImagesTable>> getImages(int id, String category) async {
    print(id);
    try {
      await connection.open();
      await connection.transaction((connection) async {
        dataFetched = await connection.query(
          'select * from images where user_id = $id and category= @category',
          substitutionValues: {'category': category},
          allowReuse: true,
          timeoutInSeconds: 30,
        );
      });
      var map = dataFetched.asMap();
      var list = List.generate(dataFetched.length, (index) {
        return ImagesTable(map[index][0].toString(), map[index][1].toString(),
            map[index][2].toString(), map[index][3].toString());
      });
      return list;
    } catch (e) {
      print(e.toString());
    }
  }

  bool updated;

  Future<bool> updateUser(
      {String oldMail,
      String userName,
      String userMail,
      String location}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      await connection.open();
      await connection.transaction((connection) async {
        userAlreadyRegistered = await connection.query(
            'select * from users where mail =@userMail',
            substitutionValues: {'userMail': user_mail},
            allowReuse: true,
            timeoutInSeconds: 30);

        if (userAlreadyRegistered.affectedRowCount > 0) {
          updated = false;
        } else {
          imageUpdatedResult = await connection.query(
            'update users set name = @userName, mail=@userMail, location= @location where mail= @oldMail',
            substitutionValues: {
              'userName': userName,
              'userMail': userMail,
              'location': location,
              'oldMail': oldMail
            },
            allowReuse: true,
            timeoutInSeconds: 30,
          );
          sharedPreferences.clear();
          sharedPreferences.setBool('isLoggedIn', true);
          sharedPreferences.setString('userMail', userMail);
          sharedPreferences.setString('user_location', location);
          sharedPreferences.setString('user_name', userName);
          imageUpdatedResult.affectedRowCount > 0
              ? updated = true
              : updated = false;
        }
      });
      return updated;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> updatePassword(
    String password,
    String mail,
  ) async {
    try {
      await connection.open();
      await connection.transaction((connection) async {
        passwordUpdated = await connection.query(
          "update users set password = @password where mail= @oldMail",
          substitutionValues: {'password': password, 'oldMail': mail},
          allowReuse: true,
          timeoutInSeconds: 30,
        );
      });
      if (passwordUpdated.affectedRowCount > 0) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  getUserId(String mail) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      await connection.transaction((connection) async {
        getId = await connection.query(
          "select id from users where mail =@mail",
          substitutionValues: {'mail': mail},
          allowReuse: true,
          timeoutInSeconds: 30,
        );
        if (getId.affectedRowCount > 0) {
          int id = getId.first.elementAt(0);
          sharedPreferences.setInt("user_id", id);
        }
      });
    } catch (e) {
      print("errr" + e.toString());
    }
  }
}
