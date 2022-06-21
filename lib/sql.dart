import 'dart:developer';
import 'package:postgres/postgres.dart';

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