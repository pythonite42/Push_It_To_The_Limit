import 'package:flutter/material.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MyAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Size get preferredSize => new Size.fromHeight(56);

  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Center(child: Text('Push It To The Limit')),
      actions: [
        IconButton(
            icon: Icon(
              Icons.send,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed("/dm");
            }),
      ],
    );
  }
}
