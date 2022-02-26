import 'package:postgres/postgres.dart';

class DatabaseAccess{
  PostgreSQLConnection connection;

  DatabaseAccess(){
    connection = (connection == null || connection.isClosed == true
        ? PostgreSQLConnection(
      '**',
      **,
      '**',
      username: '***',
      password: '**',
      timeoutInSeconds: 30,
      queryTimeoutInSeconds: 30,
      timeZone: 'UTC',
      useSSL: false,
      isUnixSocket: false,
    )
        : connection);
  }


}
