import 'package:flutter/material.dart';
import 'package:pushit/global/list_tiles.dart';

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
                      child: Image.asset(
                        "assets/pushit_logo.png",
                      ),
                    ).classic(() {
                      Navigator.pushNamed(context, '/home');
                    }),
                    SizedBox(
                      height: 20,
                    ),
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
