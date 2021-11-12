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
}
