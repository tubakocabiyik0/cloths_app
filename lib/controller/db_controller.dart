import 'package:bitirme_projesi/models/images.dart';
import 'package:flutter/material.dart';
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

  PostgreSQLConnection connection;
  PostgreSQLResult loginResult;
  PostgreSQLResult imageDeleted;
  PostgreSQLResult userRegisteredResult;
  PostgreSQLResult userAlreadyRegistered;
  PostgreSQLResult imageAddedResult;
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
              .then((value) => value.setString('location', location));
          newUserFuture = true;
          // ignore: unnecessary_statements
          (userRegisteredResult.affectedRowCount > 0 ? true : false);
        }
      });
      return newUserFuture;
    } catch (e) {
      print("hata" + e.toString());
    }
  }

  String userLoginFuture = '';

  Future<String> loginUser(String mail, String password) async {
    String location;
    try {
      await connection.open();
      await connection.transaction((connection) async {
        // check mail registered or not
        loginResult = await connection.query(
          'select mail,password,location from users where mail =@mail',
          substitutionValues: {'mail': mail,
            'location': location},
          allowReuse: true,
          timeoutInSeconds: 30,
        );
        if (loginResult.affectedRowCount > 0) {
          userMailAddress = loginResult.first.elementAt(0);
          //controling password is true
          if (loginResult.first.elementAt(1).toString() ==
              password.toString()) {
            userLoginFuture = "logged in";
            await SharedPreferences.getInstance()
                .then((value) => value.setBool('isLoggedIn', true));
            await SharedPreferences.getInstance()
                .then((value) => value.setString('userMail', mail));
            await SharedPreferences.getInstance()
                .then((value) => value.setString('location', location));
          } else if (loginResult.first.elementAt(1).contains(password) ==
              false) {
            userLoginFuture = "wrong password";
          }
        } else {
          userLoginFuture = "this mail address can't find";
        }
      });
    } catch (e) {
      print("error is " + e.toString());
    }
    return userLoginFuture;
  }

  Future<bool> userLoggedIn() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      _isUserLoggedIn = prefs.getBool('isLoggedIn') ?? false;
      print(_isUserLoggedIn);
      return _isUserLoggedIn;
    } catch (e) {
      print(e);
    }
  }

  bool imageSavedFuture = false;

  Future<bool> saveImages(String image, String userMail) async {
    try {
      await connection.open();
      await connection.transaction((connection) async {
          imageAddedResult = await connection.query(
            'insert into images (image_url,user_mail) values(@image_url,@user_mail)',
            substitutionValues: {'image_url': image, 'user_mail': userMail},
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
   try{
     await connection.open();
     await connection.transaction((connection) async {
       imageDeleted = await connection.query(
         'delete from images where image_url = @image_url',
         substitutionValues: {'image_url': image_url},
         allowReuse: true,
         timeoutInSeconds: 30,
       );
     });
     if(imageDeleted.affectedRowCount>0) {
       return true;
     }else{
       return false;
     }
   }catch(e){
     print("error is " + e.toString());
   }
  }
  Future<String> getLocation()async{
    SharedPreferences sharedPreferences= await SharedPreferences.getInstance();
    print("burası"+sharedPreferences.getString('location').toString());
    String result =sharedPreferences.getString('location').toString();
    return result;
  }
}
