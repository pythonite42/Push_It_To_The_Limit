//import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart' as chat_ui;
//import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';
import 'package:pushit/colors.dart';
import 'package:pushit/global/appbar.dart';
import 'package:pushit/sql.dart';
import 'package:uuid/uuid.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key, required this.chatAttributes}) : super(key: key);
  final Map chatAttributes;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<Message> messages = [];
  User user = User(id: Uuid().v4());
  Color inputBackgroundColor = Color.fromARGB(255, 62, 62, 62);

  @override
  void initState() {
    super.initState();
    () async {
      Map userData = await SQL().getLoggedUser();
      User tempUser = User(
        id: userData["username"],
        firstName: userData["name"],
      );
      List<Message> messagesFromSql =
          await SQL().getMessages(widget.chatAttributes["name"]);
      setState(() {
        user = tempUser;
        messages = messagesFromSql;
      });
    }();
  }

  // void _handleImageSelection() async {
  //   final result = await ImagePicker().pickImage(
  //     imageQuality: 70,
  //     maxWidth: 1440,
  //     source: ImageSource.gallery,
  //   );

  //   if (result != null) {
  //     final bytes = await result.readAsBytes();
  //     final image = await decodeImageFromList(bytes);

  //     final message = ImageMessage(
  //       author: user,
  //       createdAt: DateTime.now().millisecondsSinceEpoch,
  //       height: image.height.toDouble(),
  //       id: randomString(),
  //       name: result.name,
  //       size: bytes.length,
  //       uri: result.path,
  //       width: image.width.toDouble(),
  //     );

  //     _addMessage(message);
  //   }
  // }

  // void _handleFileSelection() async {
  //   final result = await FilePicker.platform.pickFiles(
  //     type: FileType.any,
  //   );

  //   if (result != null && result.files.single.path != null) {
  //     final message = FileMessage(
  //       author: user,
  //       createdAt: DateTime.now().millisecondsSinceEpoch,
  //       id: randomString(),
  //       name: result.files.single.name,
  //       size: result.files.single.size,
  //       uri: result.files.single.path!,
  //     );

  //     _addMessage(message);
  //   }
  // }

  // void _handleAttachmentPressed() {
  //   showModalBottomSheet<void>(
  //       elevation: 5,
  //       backgroundColor: Colors.transparent,
  //       clipBehavior: Clip.antiAliasWithSaveLayer,
  //       context: context,
  //       builder: (context) {
  //         return Container(
  //             decoration: BoxDecoration(
  //                 color: inputBackgroundColor,
  //                 borderRadius: BorderRadius.all(Radius.circular(10))),
  //             margin: EdgeInsets.all(10),
  //             child: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: <Widget>[
  //                 ListTile(
  //                   leading: Icon(
  //                     Icons.photo,
  //                     color: Theme.of(context).colorScheme.surface,
  //                   ),
  //                   title: Text('Bild',
  //                       style: TextStyle(
  //                           color: Theme.of(context).colorScheme.surface)),
  //                   onTap: () {
  //                     Navigator.pop(context);
  //                     _handleImageSelection();
  //                   },
  //                 ),
  //                 ListTile(
  //                   leading: Icon(
  //                     Icons.description,
  //                     color: Theme.of(context).colorScheme.surface,
  //                   ),
  //                   title: Text('Dokument',
  //                       style: TextStyle(
  //                           color: Theme.of(context).colorScheme.surface)),
  //                   onTap: () {
  //                     Navigator.pop(context);
  //                     _handleFileSelection();
  //                   },
  //                 ),
  //                 ListTile(
  //                   leading: Icon(
  //                     Icons.close,
  //                     color: Theme.of(context).colorScheme.surface,
  //                   ),
  //                   title: Text('Schließen',
  //                       style: TextStyle(
  //                           color: Theme.of(context).colorScheme.surface)),
  //                   onTap: () {
  //                     Navigator.pop(context);
  //                   },
  //                 ),
  //               ],
  //             ));
  //       });
  // }

  void _handleMessageTap(BuildContext _, Message message) async {
    if (message is FileMessage) {
      await OpenFilex.open(message.uri);
    }
  }

  dynamic getTypedMessage(Map<String, dynamic> json) {
    final type = MessageType.values.firstWhere(
      (e) => e.name == json['type'],
      orElse: () => MessageType.unsupported,
    );

    // if (type == MessageType.audio) tempMsg = AudioMessage.fromJson(jsonMsg);
    // if (type == MessageType.custom) tempMsg = CustomMessage.fromJson(jsonMsg);
    // if (type == MessageType.file) tempMsg = FileMessage.fromJson(jsonMsg);
    // if (type == MessageType.image) tempMsg = ImageMessage.fromJson(jsonMsg);
    // if (type == MessageType.system) tempMsg = SystemMessage.fromJson(jsonMsg);
    // if (type == MessageType.text) tempMsg = TextMessage.fromJson(jsonMsg);
    // if (type == MessageType.unsupported)
    //   tempMsg = UnsupportedMessage.fromJson(jsonMsg);
    // if (type == MessageType.video) tempMsg = VideoMessage.fromJson(jsonMsg);

    switch (type) {
      case MessageType.audio:
        return AudioMessage.fromJson(json);
      case MessageType.custom:
        return CustomMessage.fromJson(json);
      case MessageType.file:
        return FileMessage.fromJson(json);
      case MessageType.image:
        return ImageMessage.fromJson(json);
      case MessageType.system:
        return SystemMessage.fromJson(json);
      case MessageType.text:
        return TextMessage.fromJson(json);
      case MessageType.unsupported:
        return UnsupportedMessage.fromJson(json);
      case MessageType.video:
        return VideoMessage.fromJson(json);
    }
  }

  // void _addMessage(Message message) {
  //   setState(() {
  //     messages.insert(0, message);
  //   });
  //   SQL().addMessage(message, widget.chatAttributes["name"]);
  // }

  void _handleSendPressed(PartialText message) async {
    String tempID = "tempID";
    TextMessage textMessage = TextMessage(
      author: user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: tempID,
      text: message.text,
    );
    String? id =
        await SQL().addMessage(textMessage, widget.chatAttributes["name"]);
    if (id != null) {
      TextMessage msg = textMessage.copyWith(id: id) as TextMessage;
      print("MSG $msg");
      setState(() {
        messages.insert(0, msg);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        showDM: false,
        heading: widget.chatAttributes["name"],
      ),
      body: chat_ui.Chat(
        messages: messages,
        onSendPressed: _handleSendPressed,
        user: user,
        onMessageTap: _handleMessageTap,
        //onAttachmentPressed: _handleAttachmentPressed,  // uncomment to enable image and file
        theme: myChatTheme(context, inputBackgroundColor),
        showUserAvatars: true,
        showUserNames: true,
        dateLocale: 'DE',
        timeFormat: DateFormat.Hm(),
      ),
    );
  }
}
