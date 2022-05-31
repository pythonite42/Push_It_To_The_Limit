import 'package:flutter/material.dart';
import 'package:pushit/colors.dart';
import 'package:pushit/dm.dart';
import 'package:pushit/login.dart';
import 'package:pushit/main_layout.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var status = prefs.getBool('isLoggedIn') ?? false;
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
      routes: {
        '/dm': (context) => DM(),
        '/home': (context) => HomePage(),
        '/login': (context) => Login(),
      },
    );
  }
}
