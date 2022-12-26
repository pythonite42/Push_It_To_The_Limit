import 'package:flutter/material.dart';
import 'package:pushit/colors.dart';
import 'package:pushit/global/appbar.dart';
import 'package:pushit/global/global_widgets.dart';
import 'package:pushit/sql.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  Future<Map> getData() async {
    Map result = await SQL().getLoggedUser();
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
            color: Theme.of(context).colorScheme.primary,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(children: [
                    SizedBox(height: MyAppBar().preferredSize.height * 2),
                    MyTile(
                      context: context,
                      heightFactor: 0.2,
                      onTap: () {
                        Navigator.of(context).pushNamed("/home");
                      },
                      child: Image.asset(
                        "assets/pushit_logo.png",
                      ),
                    ),
                    SpaceH(),
                    FutureBuilder<Map>(
                        future: getData(),
                        builder: (context, AsyncSnapshot<Map> snapshot) {
                          if (snapshot.hasData) {
                            return ListTile(
                              contentPadding: EdgeInsets.only(left: 30),
                              title: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: MySize(context).w * 0.1,
                                    backgroundImage: MemoryImage(
                                        snapshot.data!["image"]), //here
                                  ),
                                  SpaceW(),
                                  Expanded(
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                        Text(
                                          snapshot.data!["name"],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onPrimary),
                                        ),
                                        Text(snapshot.data!["bike"],
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onPrimary))
                                      ])),
                                  IconButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, '/editProfile',
                                            arguments: snapshot.data!);
                                      },
                                      icon: Icon(Icons.settings,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary))
                                ],
                              ),
                              onTap: () {},
                            );
                          } else if (snapshot.hasError) {
                            return ListTile(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 30),
                              title: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.error_outline,
                                      color: red,
                                      size: MySize(context).h * 0.08,
                                    ),
                                    SpaceW(),
                                    Text(
                                      "Server-Fehler",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary),
                                    ),
                                  ]),
                              onTap: () {},
                            );
                          } else {
                            return ListTile(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 30),
                              title: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    SizedBox(
                                      width: MySize(context).h * 0.08,
                                      height: MySize(context).h * 0.08,
                                      child:
                                          CircularProgressIndicator(color: red),
                                    ),
                                    SpaceW(),
                                    Text(
                                      "Loading ...",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary),
                                    ),
                                  ]),
                              onTap: () {},
                            );
                          }
                        }),
                    SpaceH(0.03),
                    Divider(
                      thickness: 1,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    MyTile(
                        context: context,
                        heightFactor: 0.1,
                        onTap: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setBool('isLoggedIn', false);
                          prefs.setString('username', "");
                          Navigator.pushNamedAndRemoveUntil(context, '/login',
                              (Route<dynamic> route) => false);
                        },
                        child: Text(
                          "Ausloggen",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        )),
                    Divider(
                      thickness: 1,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    SpaceH(0.02),
                    MyTile(
                      context: context,
                      heightFactor: 0.05,
                      text: "Über Push It To The Limit",
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    SpaceH(0.02),
                    MyTile(
                      context: context,
                      heightFactor: 0.05,
                      text: "Administrator kontaktieren",
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ]),
                ])));
  }
}
