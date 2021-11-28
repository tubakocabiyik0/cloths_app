import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DbConnection {
  String mail = '';

  String password = '';

  String name = '';

  String location = '';

  PostgreSQLConnection connection;
  PostgreSQLResult loginResult;
  PostgreSQLResult userRegisteredResult;
  PostgreSQLResult userAlreadyRegistered;
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
        // user mail already register controll
        if (userAlreadyRegistered.affectedRowCount > 0) {
          newUserFuture = false;
        } else {
          userRegisteredResult = await connection.query(
            'insert into users (mail,password,name,location)'
            'values(@mail,@password,@name,@location )',
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
    try {
      await connection.open();
      await connection.transaction((connection) async {
        // check mail registered or not
        loginResult = await connection.query(
          'select mail,password from users where mail =@mail',
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
            await SharedPreferences.getInstance()
                .then((value) => value.setBool('isLoggedIn', true));
          } else if (loginResult.first.elementAt(1).contains(password) ==
              false) {
            userLoginFuture = "wrong password";
          }
        }else{
          userLoginFuture="this mail address can't find";
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
    } catch(e){
      print(e);
    }
  }


  Future<bool> logOut() async {
    try {
       SharedPreferences sharedP = await SharedPreferences.getInstance();
      await sharedP.remove('isLoggedIn');
      return Future.value(true);
    } catch (e) {
      return Future.value(false);
    }
  }
}
