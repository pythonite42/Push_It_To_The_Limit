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
    log("úsername: $username");
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
    String bike = "Suzuki fztvdfghjkl";
    log("update to username: ${values["username"]}");
    var password = await connection.query(
        'SELECT password FROM member WHERE username = @username:text',
        substitutionValues: {"username": oldusername});
    values["password"] = password.toString();
    log(values["password"].toString());

    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //GO ON HERE
    // it does not delete the old entry -> fix this, please
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

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

    /* await connection.query(
        "UPDATE member SET bike = @bike:text WHERE username=@username:text",
        substitutionValues: {"username": values["oldusername"], "bike": bike});
    

        await connection.query("""UPDATE member SET 
      name = @name:text,
      bike = @bike:text,
      image = @image:bytea,
      username = @username:text,
      wohnort = @wohnort:text,
      geburtsjahr = @geburtsjahr:int4,
      fahrstil = @fahrstil:text,
      beschreibung = @beschreibung:text,
      geschlecht = @geschlecht:text,
      insta = @insta:text
      WHERE username = @oldusername:text
      """, substitutionValues: values);*/
    List members = await connection.query('SELECT username FROM member');
    log(members.toString());
    await prefs.setString("username", values["username"]);
    await connection.close();
  }
}

/* await connection.query('DROP TABLE MEMBER;');
    await connection.query("""CREATE TABLE MEMBER(
          ID INT PRIMARY KEY NOT NULL, 
          NAME TEXT NOT NULL, 
          BIKE TEXT NOT NULL, 
          IMAGE BYTEA NOT NULL,
          USERNAME TEXT NOT NULL,
          PASSWORD TEXT NOT NULL,
          WOHNORT TEXT,
          GEBURTSJAHR INT,
          FAHRSTIL TEXT,
          BESCHREIBUNG TEXT,
          GESCHLECHT TEXT,
          INSTA TEXT);""");

           ByteData bytes = await rootBundle.load('assets/pushit_logo.png');
    Uint8List image = bytes.buffer.asUint8List();
await connection.query(
        "INSERT INTO member (ID,NAME,BIKE,IMAGE,USERNAME,PASSWORD) VALUES (1, 'Nico Hauswald', 'MT09', @a:bytea, 'nico_hauswald','np')",
        substitutionValues: {
          "a": image,
        });
        
  await connection.query(
        "INSERT INTO MEMBER (ID,NAME,BIKE,USERNAME,PASSWORD) VALUES (2, 'Nico Hauswald', 'MT09', 'nico_hauswald','np');");*/

/*
-> Möglichst wenig connections machen aber viel daten gleichzeitig abfragen

Stopwatch stopwatch = Stopwatch()..start();
    var result = await connection.query('SELECT * FROM member;');
    stopwatch.stop();
    log(result.toString());
    log("Await Dauer ${stopwatch.elapsed}");
    Stopwatch stopwatch_two = Stopwatch()..start();
    for (var i = 0; i < 21; i++) {
      var result_two = await connection
          .query('SELECT * FROM member WHERE id = ' + i.toString() + ';');
    }

    stopwatch.stop();
    //log(result_two.toString());
    log("Await Dauer 2 ${stopwatch_two.elapsed}"); */