import 'dart:developer';
import 'package:postgres/postgres.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SQL {
  connect() async {
    var connection = PostgreSQLConnection("185.228.138.208", 2345, "pushit",
        username: "pushit", password: '#gZxwwavt0o4!IM7');
    await connection.open();

    return connection;
  }

  registerMember(Map<String, dynamic> values) async {
    PostgreSQLConnection connection = await connect();

    await connection.query("""INSERT INTO member 
        (NAME,BIKE,IMAGE,USERNAME,PASSWORD,WOHNORT,GEBURTSJAHR,FAHRSTIL,BESCHREIBUNG,GESCHLECHT,INSTA) 
        VALUES 
        (@name:text, 
        @bike:text, 
        @image:bytea, 
        @username:text,
        @password:text,
        @wohnort:text,
        @geburtsjahr:int4,
        @fahrstil:text,
        @beschreibung:text,
        @geschlecht:text,
        @insta:text)""", substitutionValues: values);

    await connection.close();
  }

  Future<List> getMembers() async {
    PostgreSQLConnection connection = await connect();

    List result =
        await connection.query('SELECT * FROM member ORDER BY name ASC');

    await connection.close();
    return result;
  }

  Future<Map> getLoggedUser() async {
    PostgreSQLConnection connection = await connect();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.getString('username') ?? "";
    List member = await connection.query(
        'SELECT * FROM member WHERE username = @username:text',
        substitutionValues: {"username": username});
    member = member[0];
    await connection.close();
    Map result = {};
    try {
      result["name"] = member[0];
      result["bike"] = member[1];
      result["image"] = member[2];
      result["username"] = member[3];
      result["password"] = member[4];
      result["wohnort"] = member[5];
      result["geburtsjahr"] = member[6];
      result["fahrstil"] = member[7];
      result["beschreibung"] = member[8];
      result["geschlecht"] = member[9];
      result["insta"] = member[10];
    } catch (_) {}
    return result;
  }

  Future<bool> isUsernameFree(String username) async {
    PostgreSQLConnection connection = await connect();

    List result = await connection.query(
        'SELECT bike FROM member WHERE username = @username:text',
        substitutionValues: {"username": username});

    await connection.close();
    return (result.isEmpty) ? true : false;
  }

  Future<bool> login(String username, String password) async {
    PostgreSQLConnection connection = await connect();

    List result = await connection.query(
        'SELECT bike FROM member WHERE username = @username:text AND password = @password:text',
        substitutionValues: {"username": username, "password": password});

    await connection.close();
    return (result.length == 1) ? true : false;
  }

  updateProfile(Map<String, dynamic> values) async {
    PostgreSQLConnection connection = await connect();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String oldusername = prefs.getString('username') ?? "";
    var password = await connection.query(
        'SELECT password FROM member WHERE username = @username:text',
        substitutionValues: {"username": oldusername});
    values["password"] = password.toString();
    await connection.query('DELETE FROM member WHERE username = @username:text',
        substitutionValues: {"username": oldusername});
    await connection.query("""INSERT INTO member 
        (NAME,BIKE,IMAGE,USERNAME,PASSWORD,WOHNORT,GEBURTSJAHR,FAHRSTIL,BESCHREIBUNG,GESCHLECHT,INSTA) 
        VALUES 
        (@name:text, 
        @bike:text, 
        @image:bytea, 
        @username:text,
        @password:text,
        @wohnort:text,
        @geburtsjahr:int4,
        @fahrstil:text,
        @beschreibung:text,
        @geschlecht:text,
        @insta:text)""", substitutionValues: values);

    await prefs.setString("username", values["username"]);
    await connection.close();
  }
}
