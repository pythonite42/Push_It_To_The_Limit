import 'dart:developer';
import 'package:postgres/postgres.dart';

class SQL {
  openConnection() async {
    var connection = PostgreSQLConnection("REMOVED", 2345, "pushit",
        username: "pushit", password: 'REMOVED');
    await connection.open();
    log("connection done");
  }
}
