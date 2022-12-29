import 'dart:convert';
import 'dart:math';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';
import 'package:pushit/colors.dart';
import 'package:pushit/global/appbar.dart';
import 'package:pushit/sql.dart';
import 'package:uuid/uuid.dart';

// For the testing purposes, you should probably use https://pub.dev/packages/uuid.
String randomString() {
  final random = Random.secure();
  final values = List<int>.generate(16, (i) => random.nextInt(255));
  return base64UrlEncode(values);
}

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key, required this.chatAttributes}) : super(key: key);
  final Map chatAttributes;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<types.Message> messages = [];
  types.User user = types.User(id: Uuid().v4());
  Color inputBackgroundColor = Color.fromARGB(255, 62, 62, 62);

  @override
  void initState() {
    super.initState();
    () async {
      Map userData = await SQL().getLoggedUser();
      types.User tempUser = types.User(
        id: userData["username"],
        firstName: userData["name"],
        //imageUrl: 'https://picsum.photos/250?image=9'
      );
      final textMessage = types.TextMessage(
        author: tempUser,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: randomString(),
        text: "This text is from the user that is logged in",
      );

      setState(() {
        user = tempUser;
        messages.insert(0, textMessage);
      });
    }();
    for (var i = 0; i < 100; i++) {
      types.Message message = types.TextMessage(
        author: types.User(
          id: (i % 16).toString(),
          firstName: "Tony",
          //imageUrl: 'https://picsum.photos/250?image=9'
        ),
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: randomString(),
        text: "This is message number " +
            i.toString() +
            " from User number " +
            (i % 16).toString(),
      );
      messages.add(message);
    }
    types.Message message = types.TextMessage(
        author: types.User(
          id: "0",
          firstName: "Tony",
          //imageUrl: 'https://picsum.photos/250?image=9'
        ),
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: randomString(),
        text: "hi");
    messages.insert(0, message);
  }

  void _handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );

    if (result != null) {
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);

      final message = types.ImageMessage(
        author: user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        height: image.height.toDouble(),
        id: randomString(),
        name: result.name,
        size: bytes.length,
        uri: result.path,
        width: image.width.toDouble(),
      );

      _addMessage(message);
    }
  }

  void _handleFileSelection() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null && result.files.single.path != null) {
      final message = types.FileMessage(
        author: user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: randomString(),
        name: result.files.single.name,
        size: result.files.single.size,
        uri: result.files.single.path!,
      );

      _addMessage(message);
    }
  }

  void _handleAttachmentPressed() {
    showModalBottomSheet<void>(
        elevation: 5,
        backgroundColor: Colors.transparent,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        context: context,
        builder: (context) {
          return Container(
              decoration: BoxDecoration(
                  color: inputBackgroundColor,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              margin: EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(
                      Icons.photo,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    title: Text('Bild',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.surface)),
                    onTap: () {
                      Navigator.pop(context);
                      _handleImageSelection();
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.description,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    title: Text('Dokument',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.surface)),
                    onTap: () {
                      Navigator.pop(context);
                      _handleFileSelection();
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.close,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    title: Text('Schließen',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.surface)),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ));
        });
  }

  void _handleMessageTap(BuildContext _, types.Message message) async {
    if (message is types.FileMessage) {
      await OpenFilex.open(message.uri);
    }
  }

  void _addMessage(types.Message message) {
    setState(() {
      messages.insert(0, message);
    });
    var jsonMsg = message.toJson();
    print(jsonMsg);
    SQL().addMessage(jsonMsg, "Push It Talk");
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: message.text,
    );

    _addMessage(textMessage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        showDM: false,
        heading: widget.chatAttributes["name"],
      ),
      body: Chat(
        messages: messages,
        onSendPressed: _handleSendPressed,
        user: user,
        onMessageTap: _handleMessageTap,
        onAttachmentPressed: _handleAttachmentPressed,
        theme: myChatTheme(context, inputBackgroundColor),
        showUserAvatars: true,
        showUserNames: true,
        dateLocale: 'DE',
        timeFormat: DateFormat.Hm(),
      ),
    );
  }
}
