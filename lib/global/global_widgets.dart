import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:pushit/global/appbar.dart';
import 'package:pushit/main_layout.dart';

class MySize {
  double h = 0.0; //height
  double w = 0.0; //width
  BuildContext context;

  MySize(this.context) {
    w = MediaQuery.of(context).size.width;
    var sH = MediaQuery.of(context).size.height;
    var appBarHeight = MyAppBar().preferredSize.height;
    var navBarHeight = BottomNavBar().preferredSize.height;
    h = sH - appBarHeight - navBarHeight - MediaQuery.of(context).padding.top;
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      w = h;
      h = MediaQuery.of(context).size.width;
    }
  }
}

class SpaceH extends StatelessWidget {
  const SpaceH([this.height = 0.05]);
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(bottom: MySize(context).h * height));
  }
}

class SpaceW extends StatelessWidget {
  const SpaceW([this.width = 0.05]);
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(right: MySize(context).w * width));
  }
}

class Heading extends StatelessWidget {
  Heading({Key? key, required this.label, this.padding = 1}) : super(key: key);
  final String label;
  double padding;

  @override
  Widget build(BuildContext context) {
    if (padding == 1) {
      padding = MySize(context).w * 0.1;
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: AutoSizeText(
        label,
        style: TextStyle(fontSize: 100, fontFamily: 'MetalLord'),
        maxLines: 1,
      ),
    );
  }
}

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
        height: MySize(context).h * heightFactor,
        child: Center(
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 30),
            title: widget,
            onTap: () {
              onTap();
            },
          ),
        ));
  }
}
