import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pushit/colors.dart';
import 'package:pushit/global/global_widgets.dart';
import 'package:pushit/sql.dart';

class Mitglieder extends StatelessWidget {
  const Mitglieder({Key? key}) : super(key: key);

  Future<List> getData() async {
    List queryResult = await SQL().getMembers();
    List members = [];
    for (var member in queryResult) {
      Map map = {};
      map["name"] = member[0];
      map["bike"] = member[1];
      map["image"] = member[2];
      map["username"] = member[3];
      map["wohnort"] = member[5];
      map["geburtsjahr"] = member[6];
      map["fahrstil"] = member[7];
      map["beschreibung"] = member[8];
      map["geschlecht"] = member[9];
      map["insta"] = member[10];
      if (map["username"] == "admin") {
        members.insert(0, map);
      } else {
        members.add(map);
      }
    }
    ByteData bytes = await rootBundle.load('assets/pushit_logo.png');
    Uint8List list = bytes.buffer.asUint8List();

    return members;

    /* return [
      
      {
        "name": "Sarah",
        "bike": "Kawasaki Z400",
        "image": list,
        "username": "usernaaaame",
        "wohnort": "",
        "geburtsjahr": 0,
        "fahrstil": "Keine Angabe",
        "beschreibung": "",
        "geschlecht": "Keine Angabe",
        "insta": ""
      },
      {
        "name": "Sarah",
        "bike": "Kawasaki Z400",
        "image": list,
        "username": "usernaaaame",
        "wohnort": "Bremen Innenstadt",
        "geburtsjahr": 1998,
        "fahrstil": "Rasant",
        "beschreibung":
            "bla bla blabla bla blabla bla blabla bla blabla bla blabla bla blabla bla blabla bla bla",
        "geschlecht": "Weiblich",
        "insta": "sarah.flutter"
      },
      {
        "name": "Sarah",
        "bike": "Kawasaki Z400",
        "image": list,
        "username": "usernaaaame",
        "wohnort": "Bremen Innenstadt",
        "geburtsjahr": 2000,
        "fahrstil": "Rasant",
        "beschreibung": "",
        "geschlecht": "Keine Angabe",
        "insta": ""
      },
      {
        "name": "Sarah",
        "bike": "Kawasaki Z400",
        "image": list,
        "username": "usernaaaame",
        "wohnort": "Bremen Innenstadt",
        "geburtsjahr": 2000,
        "fahrstil": "Rasant",
        "beschreibung": "",
        "geschlecht": "Keine Angabe",
        "insta": ""
      },
      {
        "name": "Sarah",
        "bike": "Kawasaki Z400",
        "image": list,
        "username": "usernaaaame",
        "wohnort": "Bremen Innenstadt",
        "geburtsjahr": 2000,
        "fahrstil": "Rasant",
        "beschreibung": "",
        "geschlecht": "Keine Angabe",
        "insta": ""
      },
      {
        "name": "Sarah",
        "bike": "Kawasaki Z400",
        "image": list,
        "username": "usernaaaame",
        "wohnort": "Bremen Innenstadt",
        "geburtsjahr": 2000,
        "fahrstil": "Rasant",
        "beschreibung": "",
        "geschlecht": "Keine Angabe",
        "insta": ""
      },
      {
        "name": "Sarah",
        "bike": "Kawasaki Z400",
        "image": list,
        "username": "usernaaaame",
        "wohnort": "Bremen Innenstadt",
        "geburtsjahr": 2000,
        "fahrstil": "Rasant",
        "beschreibung": "",
        "geschlecht": "Keine Angabe",
        "insta": ""
      },
      {
        "name": "Sarah",
        "bike": "Kawasaki Z400",
        "image": list,
        "username": "usernaaaame",
        "wohnort": "Bremen Innenstadt",
        "geburtsjahr": 2000,
        "fahrstil": "Rasant",
        "beschreibung": "",
        "geschlecht": "Keine Angabe",
        "insta": ""
      }
    ];*/
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MySize(context).h * 0.9,
        width: MySize(context).w * 0.9,
        child: Opacity(
            opacity: 0.95,
            child: Card(
                child: FutureBuilder<List>(
                    future: getData(),
                    builder: (context, AsyncSnapshot<List> snapshot) {
                      if (snapshot.hasData) {
                        var data = snapshot.data!;
                        return SingleChildScrollView(
                            child: Column(children: [
                          SpaceH(0.02),
                          InkWell(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: MySize(context).w * 0.05,
                                  vertical: MySize(context).w * 0.025),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: MySize(context).w * 0.07,
                                    backgroundImage:
                                        MemoryImage(data[0]["image"]), //here
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
                                          data[0]["name"],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(data[0]["bike"],
                                            style: TextStyle())
                                      ])),
                                  Text(
                                    "Admin",
                                    style: TextStyle(
                                        color: grey,
                                        fontStyle: FontStyle.italic),
                                  )
                                ],
                              ),
                            ),
                            onTap: () {
                              log("show profile");
                              Navigator.pushNamed(context, "/profile",
                                  arguments: data[0]);
                            },
                          ),
                          Divider(
                              thickness: 1,
                              indent: MySize(context).w * 0.05,
                              endIndent: MySize(context).w * 0.05,
                              color: black),
                          for (var i = 0; i < data.length - 1; i++)
                            Column(children: [
                              InkWell(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: MySize(context).w * 0.05,
                                      vertical: MySize(context).w * 0.025),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: MySize(context).w * 0.07,
                                        backgroundImage: MemoryImage(
                                            data[i + 1]["image"]), //here
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
                                              data[i + 1]["name"],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(data[i + 1]["bike"],
                                                style: TextStyle())
                                          ])),
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  log("show profile");
                                  Navigator.pushNamed(context, "/profile",
                                      arguments: data[i + 1]);
                                },
                              ),
                              if (i != data.length - 2)
                                Divider(
                                  thickness: 1,
                                  indent: MySize(context).w * 0.05,
                                  endIndent: MySize(context).w * 0.05,
                                ),
                            ]),
                          SpaceH(0.01),
                        ]));
                      } else if (snapshot.hasError) {
                        return WholeScreenErrorFutureBuilder();
                      } else {
                        return WholeScreenLoadingFutureBuilder();
                      }
                    }))));
  }
}
