import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pushit/colors.dart';
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

  @override
  void initState() {
    super.initState();
    () async {
      Map userData = await SQL().getLoggedUser();
      types.User tempUser = types.User(
          id: userData["username"],
          firstName: userData["name"],
          imageUrl: 'https://picsum.photos/250?image=9');
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
            imageUrl: 'https://picsum.photos/250?image=9'),
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
            imageUrl: 'https://picsum.photos/250?image=9'),
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

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Chat(
          messages: messages,
          onSendPressed: _handleSendPressed,
          user: user,
          onAttachmentPressed: _handleImageSelection,
          theme: DefaultChatTheme(
            inputBackgroundColor: Color.fromARGB(255, 62, 62, 62),
            primaryColor: red,
            backgroundColor: Color.fromARGB(255, 27, 27, 27),
            inputTextCursorColor: red,
            inputTextColor: Theme.of(context).colorScheme.surface,
            errorColor: brightRed,
            secondaryColor: Color.fromARGB(255, 62, 62, 62),
            sentMessageDocumentIconColor: red,
            userAvatarNameColors: const [
              Color.fromARGB(255, 223, 10, 10),
              Color.fromARGB(255, 223, 145, 10),
              Color.fromARGB(255, 251, 239, 14),
              Color.fromARGB(255, 212, 223, 10),
              Color.fromARGB(255, 170, 223, 10),
              Color.fromARGB(255, 92, 223, 10),
              Color.fromARGB(255, 26, 183, 21),
              Color.fromARGB(255, 10, 223, 181),
              Color.fromARGB(255, 10, 191, 223),
              Color.fromARGB(255, 10, 134, 223),
              Color.fromARGB(255, 144, 34, 254),
              Color.fromARGB(255, 184, 10, 223),
              Color.fromARGB(255, 223, 10, 195),
              Color.fromARGB(255, 194, 28, 106),
            ],
            receivedMessageDocumentIconColor: red,
            receivedMessageBodyTextStyle: DefaultChatTheme()
                .receivedMessageBodyTextStyle
                .copyWith(color: Theme.of(context).colorScheme.surface),
            sentMessageBodyTextStyle: DefaultChatTheme()
                .sentMessageBodyTextStyle
                .copyWith(color: Theme.of(context).colorScheme.surface),
            inputMargin: EdgeInsets.all(10),
            inputBorderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          showUserAvatars: true,
          showUserNames: true,
          dateLocale: 'DE',
          timeFormat: DateFormat.Hm(),
        ),
      );

  void _addMessage(types.Message message) {
    setState(() {
      messages.insert(0, message);
    });
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
}
