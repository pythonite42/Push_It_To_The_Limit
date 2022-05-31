import 'package:flutter/material.dart';

class MyTile {
  MyTile(
      {this.text = "",
      required this.context,
      this.heightFactor = 0.13,
      this.child = const Text("")});
  final String text;
  final BuildContext context;
  final double heightFactor;
  final Widget child;

  Widget classic(Function onTap) {
    var widget = child;
    if (text != "") {
      widget = Text(
        text,
        style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
      );
    }

    return Container(
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
