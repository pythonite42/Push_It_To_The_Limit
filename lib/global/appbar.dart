import 'package:flutter/material.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MyAppBar(
      {Key? key, this.showDM = true, this.heading = "Push It To The Limit"})
      : super(key: key);
  final bool showDM;
  final String heading;

  @override
  Size get preferredSize => Size.fromHeight(56);

  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Center(child: Text(widget.heading)),
      actions: [
        Visibility(
            visible: widget.showDM,
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            child: IconButton(
                icon: Icon(
                  Icons.send,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed("/dm");
                })),
      ],
    );
  }
}
