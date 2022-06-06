import 'dart:developer';
import 'package:postgres/postgres.dart';

class SQL {
  openConnection() async {
    var connection = PostgreSQLConnection("185.228.138.208", 2345, "pushit",
        username: "pushit", password: '#gZxwwavt0o4!IM7');
    await connection.open();
    log("connection done");
  }
}
