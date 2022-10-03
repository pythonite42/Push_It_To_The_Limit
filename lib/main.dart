import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pushit/chat/chat.dart';
import 'package:pushit/colors.dart';
import 'package:pushit/dm.dart';
import 'package:pushit/edit_profile.dart';
import 'package:pushit/login.dart';
import 'package:pushit/main_layout.dart';
import 'package:pushit/profile.dart';
import 'package:pushit/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var status = prefs.getBool('isLoggedIn') ?? false;
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  runApp(MyApp(home: status == true ? HomePage() : Login()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.home}) : super(key: key);
  final Widget home;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Push It',
      theme: ThemeData(
          cardColor: lightGrey,
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: blackMaterial,
            onPrimary: beige,
            secondary: brightRed,
            onSecondary: beige,
            surface: lightGrey,
            background: black,
            onSurface: black,
            onBackground: beige,
          )),
      home: home,
      onGenerateRoute: (settings) {
        late Widget page;
        if (settings.name == '/home') {
          page = HomePage();
        } else if (settings.name == '/dm') {
          page = DM();
        } else if (settings.name == '/login') {
          page = Login();
        } else if (settings.name == '/register') {
          page = Register();
        } else if (settings.name == '/editProfile') {
          Map args = settings.arguments as Map;
          page = EditProfile(userdata: args);
        } else if (settings.name == '/profile') {
          Map args = settings.arguments as Map;
          page = Profile(data: args);
        } else if (settings.name == '/chat') {
          Map args = settings.arguments as Map;
          page = Chat(chatAttributes: args);
        } else {
          page = HomePage();
        }
        return MaterialPageRoute(builder: (context) => page);
      },
    );
  }
}
