import 'package:flutter/material.dart';

class MyTile extends StatelessWidget {
  const MyTile(
      {Key? key,
      this.text = "",
      required this.context,
      this.heightFactor = 0.13,
      this.child = const Text(""),
      required this.onTap})
      : super(key: key);
  final String text;
  final BuildContext context;
  final double heightFactor;
  final Widget child;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    var widget = child;
    if (text != "") {
      widget = Text(
        text,
        style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
      );
    }
    return SizedBox(
      height: 100, //Size(context).h * heightFactor,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 30),
        title: widget,
        onTap: () {
          onTap();
        },
      ),
    );
  }
}
