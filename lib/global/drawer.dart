import 'package:flutter/material.dart';
import 'package:pushit/global/list_tiles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
            color: Theme.of(context).colorScheme.primary,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(children: [
                    SizedBox(
                      height: 100,
                    ),
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
                    SizedBox(
                      height: 20,
                    ),
                    MyTile(
                        context: context,
                        heightFactor: 0.2,
                        onTap: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setBool('isLoggedIn', false);
                          Navigator.pushNamed(context, '/login');
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
                    ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: 100, //Size(context).h * 0.67,
                        ),
                        child: Column(children: [
                          Container(
                            height: 50, //Size(context).h * heightFactor,
                            child: ListTile(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 30),
                              title: Text(
                                "Über Push It To The Limit",
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimary),
                              ),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          Container(
                            height: 50, //Size(context).h * heightFactor,
                            child: ListTile(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 30),
                              title: Text(
                                "Administrator kontaktieren",
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimary),
                              ),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ]))
                  ]),
                ])));
  }
}
