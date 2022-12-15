import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

MaterialColor blackMaterial = const MaterialColor(
  0xFF000000,
  <int, Color>{
    50: Color(0x0D000000),
    100: Color(0x1A000000),
    200: Color(0x33000000),
    300: Color(0x4D000000),
    400: Color(0x66000000),
    500: Color(0x80000000),
    600: Color(0x99000000),
    700: Color(0xB3000000),
    800: Color(0xCC000000),
    900: Color(0xE6000000),
  },
);
Color black = const Color(0xFF000000);

MaterialColor beigeMaterial = const MaterialColor(
  0xFFDBCEA2,
  <int, Color>{
    50: Color(0x0DDBCEA2),
    100: Color(0x1ADBCEA2),
    200: Color(0x33DBCEA2),
    300: Color(0x4DDBCEA2),
    400: Color(0x66DBCEA2),
    500: Color(0x80DBCEA2),
    600: Color(0x99DBCEA2),
    700: Color(0xB3DBCEA2),
    800: Color(0xCCDBCEA2),
    900: Color(0xE6DBCEA2),
  },
);
Color beige = const Color(0xFFDBCEA2);

MaterialColor redMaterial = const MaterialColor(
  0xFFA8281F,
  <int, Color>{
    50: Color(0x0DA8281F),
    100: Color(0x1AA8281F),
    200: Color(0x33A8281F),
    300: Color(0x4DA8281F),
    400: Color(0x66A8281F),
    500: Color(0x80A8281F),
    600: Color(0x99A8281F),
    700: Color(0xB3A8281F),
    800: Color(0xCCA8281F),
    900: Color(0xE6A8281F),
  },
);
Color red = const Color(0xFFA8281F);

MaterialColor brightRedMaterial = const MaterialColor(
  0xFFd83a2f,
  <int, Color>{
    50: Color(0x0Dd83a2f),
    100: Color(0x1Ad83a2f),
    200: Color(0x33d83a2f),
    300: Color(0x4Dd83a2f),
    400: Color(0x66d83a2f),
    500: Color(0x80d83a2f),
    600: Color(0x99d83a2f),
    700: Color(0xB3d83a2f),
    800: Color(0xCCd83a2f),
    900: Color(0xE6d83a2f),
  },
);
Color brightRed = const Color(0xFFd83a2f);

MaterialColor silverMaterial = const MaterialColor(
  0xFF8C8784,
  <int, Color>{
    50: Color(0x0D8C8784),
    100: Color(0x1A8C8784),
    200: Color(0x338C8784),
    300: Color(0x4D8C8784),
    400: Color(0x668C8784),
    500: Color(0x808C8784),
    600: Color(0x998C8784),
    700: Color(0xB38C8784),
    800: Color(0xCC8C8784),
    900: Color(0xE68C8784),
  },
);
Color silver = const Color(0xFF8C8784);

MaterialColor greyMaterial = const MaterialColor(
  0xFF555651,
  <int, Color>{
    50: Color(0x0D555651),
    100: Color(0x1A555651),
    200: Color(0x33555651),
    300: Color(0x4D555651),
    400: Color(0x66555651),
    500: Color(0x80555651),
    600: Color(0x99555651),
    700: Color(0xB3555651),
    800: Color(0xCC555651),
    900: Color(0xE6555651),
  },
);
Color grey = const Color(0xFF555651);

MaterialColor lightGreyMaterial = const MaterialColor(
  0xFFdcdcda,
  <int, Color>{
    50: Color(0x0Ddcdcda),
    100: Color(0x1Adcdcda),
    200: Color(0x33dcdcda),
    300: Color(0x4Ddcdcda),
    400: Color(0x66dcdcda),
    500: Color(0x80dcdcda),
    600: Color(0x99dcdcda),
    700: Color(0xB3dcdcda),
    800: Color(0xCCdcdcda),
    900: Color(0xE6dcdcda),
  },
);
Color lightGrey = const Color(0xFFdcdcda);

ChatTheme myChatTheme(BuildContext context, Color inputBackgroundColor) {
  return DefaultChatTheme(
    inputBackgroundColor: inputBackgroundColor,
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
  );
}
