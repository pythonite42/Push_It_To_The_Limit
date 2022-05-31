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
