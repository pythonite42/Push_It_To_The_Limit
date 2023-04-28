import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pushit/colors.dart';
import 'package:pushit/global/global_widgets.dart';
import 'package:intl/intl.dart';

class Treffen extends StatelessWidget {
  const Treffen({Key? key}) : super(key: key);

  Future<List> getData() async {
    await Future.delayed(Duration(seconds: 1));
    ByteData bytes = await rootBundle.load('assets/pushit_logo.png');
    Uint8List list = bytes.buffer.asUint8List();
    return [
      {
        "admin": true,
        "art": "Rideout",
        "ort": "Martfeld",
        "datetime": DateTime(2022, 05, 24, 14, 0, 0),
        "participants": [
          {
            "name": "Sarah",
            "bike": "Kawasaki Z400",
            "image": list,
            "username": "sarah.flutter"
          },
          {
            "name": "Sarah",
            "bike": "Kawasaki Z400",
            "image": list,
            "username": "sarah.flutter"
          },
          {
            "name": "Sarah",
            "bike": "Kawasaki Z400",
            "image": list,
            "username": "sarah.flutter"
          },
          {
            "name": "Sarah",
            "bike": "Kawasaki Z400",
            "image": list,
            "username": "sarah.flutter"
          },
          {
            "name": "Sarah",
            "bike": "Kawasaki Z400",
            "image": list,
            "username": "sarah.flutter"
          },
          {
            "name": "Sarah",
            "bike": "Kawasaki Z400",
            "image": list,
            "username": "sarah.flutter"
          },
        ]
      },
      {
        "admin": true,
        "art": "Grillen",
        "ort": "BWK",
        "datetime": DateTime(2022, 05, 24, 14, 0, 0),
        "participants": [
          {
            "name": "Sarah",
            "bike": "Kawasaki Z400",
            "image": list,
            "username": "sarah.flutter"
          },
          {
            "name": "Sarah",
            "bike": "Kawasaki Z400",
            "image": list,
            "username": "sarah.flutter"
          },
          {
            "name": "Sarah",
            "bike": "Kawasaki Z400",
            "image": list,
            "username": "sarah.flutter"
          },
        ]
      },
      {
        "admin": false,
        "art": "Grillen",
        "ort": "BWK",
        "datetime": DateTime(2022, 05, 24, 14, 0, 0),
        "participants": [
          {
            "name": "Sarah",
            "bike": "Kawasaki Z400",
            "image": list,
            "username": "sarah.flutter"
          },
          {
            "name": "Sarah",
            "bike": "Kawasaki Z400",
            "image": list,
            "username": "sarah.flutter"
          },
        ]
      },
      {
        "admin": false,
        "art": "Grillen",
        "ort": "BWK",
        "datetime": DateTime(2022, 05, 24, 14, 0, 0),
        "participants": [
          {
            "name": "Sarah",
            "bike": "Kawasaki Z400",
            "image": list,
            "username": "sarah.flutter"
          },
          {
            "name": "Sarah",
            "bike": "Kawasaki Z400",
            "image": list,
            "username": "sarah.flutter"
          },
          {
            "name": "Sarah",
            "bike": "Kawasaki Z400",
            "image": list,
            "username": "sarah.flutter"
          },
        ]
      },
      {
        "admin": false,
        "art": "Grillen",
        "ort": "BWK",
        "datetime": DateTime(2022, 05, 24, 14, 0, 0),
        "participants": [
          {
            "name": "Sarah",
            "bike": "Kawasaki Z400",
            "image": list,
            "username": "sarah.flutter"
          },
        ]
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: FutureBuilder<List>(
            future: getData(),
            builder: (context, AsyncSnapshot<List> snapshot) {
              if (snapshot.hasData) {
                var data = snapshot.data!;
                return Column(children: [
                  SpaceH(0.02),
                  Container(
                      constraints:
                          BoxConstraints(maxWidth: MySize(context).w * 0.88),
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {
                        },
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.add, color: beige),
                              Text("Treffen erstellen")
                            ]),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(10),
                          backgroundColor: red,
                        ),
                      )),
                  SpaceH(0.02),
                  for (var i = 0; i < data.length; i++)
                    Column(children: [
                      SizedBox(
                          width: MySize(context).w * 0.9,
                          child: Opacity(
                              opacity: 0.95,
                              child: Card(
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: MySize(context).w * 0.05,
                                          horizontal: MySize(context).w * 0.05),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(data[i]["art"],
                                              style: (data[i]["admin"] == true)
                                                  ? TextStyle(
                                                      color: red,
                                                      fontSize:
                                                          MySize(context).h *
                                                              0.04,
                                                      fontWeight:
                                                          FontWeight.bold)
                                                  : TextStyle(
                                                      fontSize:
                                                          MySize(context).h *
                                                              0.025,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                          SpaceH(0.025),
                                          Row(
                                            children: [
                                              Icon(Icons.pin_drop),
                                              SpaceW(),
                                              Text(data[i]["ort"])
                                            ],
                                          ),
                                          SpaceH(0.02),
                                          Row(
                                            children: [
                                              Icon(Icons.date_range),
                                              SpaceW(),
                                              Text(DateFormat('dd.MM.yyyy')
                                                  .format(data[i]["datetime"]))
                                            ],
                                          ),
                                          SpaceH(0.02),
                                          Row(
                                            children: [
                                              Icon(Icons.schedule),
                                              SpaceW(),
                                              Text(DateFormat('kk:mm')
                                                  .format(data[i]["datetime"]))
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Icon(Icons.people),
                                              SpaceW(),
                                              TextButton(
                                                  style: ButtonStyle(
                                                    textStyle:
                                                        MaterialStateProperty
                                                            .all(TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      decoration: TextDecoration
                                                          .underline,
                                                    )),
                                                    padding:
                                                        MaterialStateProperty
                                                            .all(EdgeInsets.all(
                                                                0)),
                                                  ),
                                                  onPressed: () {
                                                    participantsDialog(
                                                        context,
                                                        data[i]
                                                            ["participants"]);
                                                  },
                                                  child: Text("Teilnehmer"))
                                            ],
                                          ),
                                          SpaceH(0.02),
                                          if (data[i]["admin"])
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: ElevatedButton(
                                                      style: ButtonStyle(
                                                          padding:
                                                              MaterialStateProperty
                                                                  .all(EdgeInsets
                                                                      .zero),
                                                          foregroundColor:
                                                              MaterialStateProperty
                                                                  .all(black),
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all(
                                                                      brightRed)),
                                                      onPressed: () {},
                                                      child: AutoSizeText(
                                                        "Absagen",
                                                        maxLines: 1,
                                                      )),
                                                ),
                                                SpaceW(0.03),
                                                Expanded(
                                                    child: ElevatedButton(
                                                        style: ButtonStyle(
                                                            padding:
                                                                MaterialStateProperty.all(
                                                                    EdgeInsets
                                                                        .zero),
                                                            foregroundColor:
                                                                MaterialStateProperty
                                                                    .all(black),
                                                            backgroundColor:
                                                                MaterialStateProperty
                                                                    .all(Colors
                                                                        .yellow)),
                                                        onPressed: () {},
                                                        child: AutoSizeText(
                                                          "Vielleicht",
                                                          maxLines: 1,
                                                        ))),
                                                SpaceW(0.03),
                                                Expanded(
                                                    child: ElevatedButton(
                                                        style: ButtonStyle(
                                                            padding:
                                                                MaterialStateProperty.all(
                                                                    EdgeInsets
                                                                        .zero),
                                                            foregroundColor:
                                                                MaterialStateProperty
                                                                    .all(black),
                                                            backgroundColor:
                                                                MaterialStateProperty
                                                                    .all(Colors
                                                                        .green)),
                                                        onPressed: () {},
                                                        child: AutoSizeText(
                                                          "Zusagen",
                                                          maxLines: 1,
                                                        )))
                                              ],
                                            ),
                                          if (!data[i]["admin"])
                                            Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  ElevatedButton(
                                                      style: ButtonStyle(
                                                          foregroundColor:
                                                              MaterialStateProperty
                                                                  .all(black),
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all(Colors
                                                                      .green)),
                                                      onPressed: () {},
                                                      child: AutoSizeText(
                                                        "Zusagen",
                                                        maxLines: 1,
                                                      ))
                                                ])
                                        ],
                                      ))))),
                      SpaceH(0.02),
                      if (i < data.length - 1)
                        if (data[i]["admin"] == true &&
                            data[i + 1]["admin"] == false)
                          Divider(
                            indent: MySize(context).w * 0.05,
                            endIndent: MySize(context).w * 0.05,
                            thickness: 3,
                            color: red,
                          ),
                      SpaceH(0.02),
                    ])
                ]);
              } else if (snapshot.hasError) {
                return CardErrorFutureBuilder();
              } else {
                return CardLoadingFutureBuilder();
              }
            }));
  }

  Future<dynamic> participantsDialog(
      BuildContext context, List<dynamic> participants) {
    return showDialog(
      useRootNavigator: false,
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text("Teilnehmer"),
          content: SizedBox(
              width: MySize(context).w * 0.8,
              height: MySize(context).h * 0.6,
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  for (var i = 0; i < participants.length; i++)
                    Column(children: [
                      InkWell(
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: MySize(context).w * 0.07,
                              backgroundImage:
                                  MemoryImage(participants[i]["image"]), //here
                            ),
                            SpaceW(),
                            Expanded(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                  Text(
                                    participants[i]["name"],
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(participants[i]["bike"],
                                      style: TextStyle())
                                ])),
                          ],
                        ),
                        onTap: () async {
                          var profileData = await getProfileData(
                              participants[i]["username"],
                              participants[i]["name"],
                              participants[i]["bike"],
                              participants[i]["image"]);
                          Navigator.pushNamed(context, "/profile",
                              arguments: profileData);
                        },
                      ),
                      if (i != participants.length - 1)
                        Column(children: const [
                          SpaceH(0.01),
                          Divider(
                            thickness: 1,
                          ),
                          SpaceH(0.01),
                        ])
                    ])
                ],
              ))),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Schließen",
                )),
          ],
        );
      },
      barrierDismissible: true,
    );
  }
}

Future<Map> getProfileData(username, name, bike, image) async {
  await Future.delayed(Duration(seconds: 1));
  return {
    "name": name,
    "bike": bike,
    "image": image,
    "username": username,
    "wohnort": "Bremen Innenstadt",
    "geburtsjahr": 2000,
    "fahrstil": "Rasant",
    "beschreibung": "",
    "geschlecht": "Keine Angabe",
    "insta": ""
  };
}
