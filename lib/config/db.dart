import 'package:postgres/postgres.dart';

class DatabaseAccess{
  PostgreSQLConnection connection;

  DatabaseAccess(){
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
  }


}
