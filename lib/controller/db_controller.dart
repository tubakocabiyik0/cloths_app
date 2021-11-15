import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

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
          if (loginResult.first.elementAt(1).toString()==password.toString()) {
            userLoginFuture = "logged in";
            print("true");
          } else if (loginResult.first.elementAt(1).contains(password) == false) {
            userLoginFuture = "wrong password";
          }
        }
      });
    } catch (e) {
      print("error is " + e.toString());
    }
    print(userLoginFuture);
    return userLoginFuture;
  }
}
