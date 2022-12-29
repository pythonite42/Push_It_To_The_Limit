import 'package:flutter_chat_types/flutter_chat_types.dart';
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

  Future<String?> addMessage(Message message, String chatName) async {
    PostgreSQLConnection connection = await connect();
    String? messageID;

    if (message.type == MessageType.text) {
      // message always was created like this: TextMessage(
      //   author: user,
      //   createdAt: DateTime.now().millisecondsSinceEpoch,
      //   id: randomString(),
      //   text: message.text,
      // );
      message = message as TextMessage;

      await connection.query("""INSERT INTO message 
        (chat_name,username, created_at, content) 
        VALUES 
        (@chat_name:text,
        @username:text, 
        @created_at:int4, 
        @content:text)""", substitutionValues: {
        "chat_name": chatName,
        "username": message.author.id,
        "created_at": message.createdAt,
        "content": message.text
      });
      var result = await connection.query(
          'SELECT id FROM message WHERE username = @username:text ORDER BY created_at DESC',
          substitutionValues: {"username": message.author.id});
      try {
        messageID = result[0][0].toString();
        print(messageID);
      } catch (_) {}
    }

    // if (type == MessageType.audio) { await connection.query(...);}
    // if (type == MessageType.custom) { await connection.query(...);}
    // if (type == MessageType.file) { await connection.query(...);}
    // if (type == MessageType.image) { await connection.query(...);}
    // if (type == MessageType.system) { await connection.query(...);}
    // if (type == MessageType.unsupported) { await connection.query(...);}
    // if (type == MessageType.video) { await connection.query(...);}

    await connection.close();
    return messageID;
  }

  Future<List<Message>> getMessages(String chatName) async {
    PostgreSQLConnection connection = await connect();

    List result = await connection.query(
        'SELECT * FROM message WHERE chat_name = @chat_name:text ORDER BY created_at DESC',
        substitutionValues: {"chat_name": chatName});
    print(result);
    List<Message> messages = [];
    for (final msg in result) {
      List result = await connection.query(
          'SELECT username, name FROM member WHERE username = @username:text',
          substitutionValues: {"username": msg[2]});
      User tempUser = User(
        id: result[0][0],
        firstName: result[0][1],
      );
      messages.add(TextMessage(
          id: msg[0].toString(),
          author: tempUser,
          createdAt: msg[3],
          text: msg[4]));
    }
    await connection.close();
    return messages;
  }

  void query() async {
    PostgreSQLConnection connection = await connect();

    List result = await connection.query(
        //"SELECT * FROM pg_catalog.pg_tables WHERE schemaname != 'pg_catalog' AND schemaname != 'information_schema';"
        "SELECT username, password FROM member;"
        // """CREATE TABLE message(
        //   id SERIAL PRIMARY KEY,
        //   chat_name text NOT NULL,
        //   username text NOT NULL,
        //   created_at integer NOT NULL,
        //   content text
        // );"""

        );

    await connection.close();
    print("-----------------------------");
    print("Query result: $result");
    print("-----------------------------");
  }
}
