import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:pushit/colors.dart';
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

class RegisterRow extends StatelessWidget {
  const RegisterRow(
      {Key? key,
      required this.label,
      this.validator,
      required this.onSaved,
      this.initialValue = ""})
      : super(key: key);
  final String label;
  final FormFieldValidator<String>? validator;
  final void Function(String?) onSaved;
  final initialValue;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(flex: 1, child: Text(label)),
        Flexible(
          flex: 2,
          child: Padding(
              padding: EdgeInsets.only(left: 15),
              child: TextFormField(
                  initialValue:
                      (initialValue == "") ? null : initialValue.toString(),
                  validator: validator,
                  onSaved: onSaved)),
        )
      ],
    );
  }
}

class WholeScreenLoadingFutureBuilder extends StatelessWidget {
  const WholeScreenLoadingFutureBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: (MediaQuery.of(context).orientation == Orientation.portrait)
            ? MySize(context).h * 0.95
            : MySize(context).h * 0.8,
        child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              SizedBox(
                width: MySize(context).h * 0.1,
                height: MySize(context).h * 0.1,
                child: CircularProgressIndicator(
                  color: red,
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: MySize(context).h * 0.04),
                  child: Text('Loading ...', textAlign: TextAlign.center)),
            ])));
  }
}

class WholeScreenErrorFutureBuilder extends StatelessWidget {
  const WholeScreenErrorFutureBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MySize(context).h * 0.95,
        child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              Icon(
                Icons.error_outline,
                color: red,
                size: MySize(context).h * 0.1,
              ),
              Padding(
                  padding: EdgeInsets.only(top: MySize(context).h * 0.04),
                  child: Text('Server-Fehler', textAlign: TextAlign.center)),
            ])));
  }
}
