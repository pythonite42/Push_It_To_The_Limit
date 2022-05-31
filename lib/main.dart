import 'package:flutter/material.dart';
import 'package:pushit/colors.dart';
import 'package:pushit/dm.dart';
import 'package:pushit/main_layout.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Push It',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: blackMaterial,
        onPrimary: beige,
        secondary: brightRed,
        onSecondary: beige,
        surface: greyMaterial[200],
        background: black,
        onSurface: black,
        onBackground: beige,
      )),
      home: const HomePage(),
      routes: {
        '/dm': (context) => DM(),
      },
    );
  }
}
