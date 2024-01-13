import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pushit/colors.dart';
import 'package:pushit/global/global_widgets.dart';
import 'package:intl/intl.dart';

class TreffenScreen extends StatefulWidget {
  const TreffenScreen({Key? key}) : super(key: key);

  @override
  State<TreffenScreen> createState() => _TreffenScreenState();
}

class _TreffenScreenState extends State<TreffenScreen> {
  Future<List> getData() async {
    await Future.delayed(Duration(seconds: 1));
    ByteData bytes = await rootBundle.load('assets/pushit_logo.png');
    Uint8List list = bytes.buffer.asUint8List();
    return [
      {
        "admin": true,
        "art": "Rideout",
        "start": "Bremen",
        "ziel": "Martfeld",
        "datetime": DateTime(2022, 05, 24, 14, 0, 0),
        "fahrstil": "Gemütlich",
        "notizen": "Alle willkommen",
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
        "ziel": "BWK",
        "datetime": DateTime(2022, 05, 24, 14, 0, 0),
        "fahrstil": "",
        "notizen": "Keine fucking 125er",
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
        "ziel": "BWK",
        "datetime": DateTime(2022, 05, 24, 14, 0, 0),
        "fahrstil": "",
        "notizen": "Alle willkommen",
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
        "ziel": "BWK",
        "datetime": DateTime(2022, 05, 24, 14, 0, 0),
        "fahrstil": "",
        "notizen": "Alle willkommen",
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
        "ziel": "BWK",
        "datetime": DateTime(2022, 05, 24, 14, 0, 0),
        "fahrstil": "",
        "notizen": "Alle willkommen",
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

  // Treffen neuesTreffen=Treffen(admin, art, start, ziel, datum, fahrstil, notizen, teilnehmer);

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
                          String art = "Fahren";
                          String fahrstil = "Flexibel";
                          showDialog(
                            useRootNavigator: false,
                            context: context,
                            builder: (_) {
                              return AlertDialog(
                                title: Text("Treffen erstellen"),
                                content: SizedBox(
                                    width: MySize(context).w * 0.8,
                                    child: SingleChildScrollView(
                                        child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text("Art des Treffens"),
                                                DropdownButton(
                                                  value: art,
                                                  icon: const Icon(
                                                      Icons.expand_more),
                                                  onChanged:
                                                      (String? newValue) {
                                                    art = newValue ?? "Fahren";
                                                  },
                                                  items: <String>[
                                                    "Fahren",
                                                    "Grillen",
                                                    "Rideout",
                                                    "Sonstiges"
                                                  ].map<
                                                          DropdownMenuItem<
                                                              String>>(
                                                      (String value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: Text(value),
                                                    );
                                                  }).toList(),
                                                )
                                              ]),
                                          Row(children: const [
                                            Icon(Icons.pin_drop),
                                            SpaceW(),
                                            Expanded(
                                                child: TextField(
                                              decoration: InputDecoration(
                                                labelText: 'Start*',
                                              ),
                                            ))
                                          ]),
                                          Row(children: const [
                                            Icon(Icons.pin_drop),
                                            SpaceW(),
                                            Expanded(
                                                child: TextField(
                                              decoration: InputDecoration(
                                                labelText: 'Ziel*',
                                              ),
                                            ))
                                          ]),
                                          Row(children: const [
                                            Icon(Icons.date_range),
                                            SpaceW(),
                                            Expanded(
                                                child: TextField(
                                              decoration: InputDecoration(
                                                labelText: 'Datum',
                                              ),
                                            ))
                                          ]),
                                          Row(children: const [
                                            Icon(Icons.schedule),
                                            SpaceW(),
                                            Expanded(
                                                child: TextField(
                                              decoration: InputDecoration(
                                                labelText: 'Uhrzeit',
                                              ),
                                            ))
                                          ]),
                                          SpaceH(0.01),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: const [
                                                    Icon(Icons.motorcycle),
                                                    SpaceW(),
                                                    Text("Fahrstil"),
                                                    SpaceW()
                                                  ],
                                                ),
                                                DropdownButton(
                                                  value: fahrstil,
                                                  icon: const Icon(
                                                      Icons.expand_more),
                                                  onChanged:
                                                      (String? newValue) {
                                                    fahrstil =
                                                        newValue ?? "Flexibel";
                                                  },
                                                  items: <String>[
                                                    "Keine Angabe",
                                                    "Rasant",
                                                    "Gemütlich",
                                                    "Flexibel"
                                                  ].map<
                                                          DropdownMenuItem<
                                                              String>>(
                                                      (String value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: (value ==
                                                              "Keine Angabe")
                                                          ? Text(value,
                                                              style: TextStyle(
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic,
                                                                  color: grey))
                                                          : Text(value),
                                                    );
                                                  }).toList(),
                                                )
                                              ]),
                                          Row(children: const [
                                            Icon(Icons.notes),
                                            SpaceW(),
                                            Expanded(
                                                child: TextField(
                                              maxLines: 3,
                                              decoration: InputDecoration(
                                                labelText: 'Notizen',
                                              ),
                                            ))
                                          ])
                                        ]))),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("Abbrechen",
                                          style: TextStyle(fontSize: 16))),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("Speichern",
                                          style: TextStyle(fontSize: 16)))
                                ],
                              );
                            },
                            barrierDismissible: true,
                          );
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
                                                style: (data[i]["admin"] ==
                                                        true)
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
                                                Text(data[i]["ziel"])
                                              ],
                                            ),
                                            SpaceH(0.02),
                                            Row(
                                              children: [
                                                Icon(Icons.date_range),
                                                SpaceW(),
                                                Text(DateFormat('dd.MM.yyyy')
                                                    .format(
                                                        data[i]["datetime"]))
                                              ],
                                            ),
                                            SpaceH(0.02),
                                            Row(
                                              children: [
                                                Icon(Icons.schedule),
                                                SpaceW(),
                                                Text(DateFormat('kk:mm').format(
                                                    data[i]["datetime"]))
                                              ],
                                            ),
                                            if (data[i]["art"] == "Fahren" ||
                                                data[i]["art"] == "Rideout")
                                              SpaceH(0.02),
                                            if (data[i]["art"] == "Fahren" ||
                                                data[i]["art"] == "Rideout")
                                              Row(
                                                children: [
                                                  Icon(Icons.motorcycle),
                                                  SpaceW(),
                                                  Text(data[i]["fahrstil"])
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
                                                        decoration:
                                                            TextDecoration
                                                                .underline,
                                                      )),
                                                      padding:
                                                          MaterialStateProperty
                                                              .all(EdgeInsets
                                                                  .all(0)),
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
                                            Text(
                                              data[i]["notizen"],
                                              style: TextStyle(
                                                  fontStyle: FontStyle.italic),
                                            ),
                                            SpaceH(0.03),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                TreffenButton(
                                                    text: "Absagen",
                                                    color: brightRed,
                                                    selectedText: "Abgesagt",
                                                    onPressed: (!data[i]
                                                            ["admin"])
                                                        ? null
                                                        : () {
                                                            print("Absagen");
                                                          }),
                                                SpaceW(0.03),
                                                TreffenButton(
                                                    text: "Vielleicht",
                                                    color: Colors.yellow,
                                                    onPressed: () {
                                                      print("Vielleicht");
                                                    }),
                                                SpaceW(0.03),
                                                TreffenButton(
                                                    text: "Zusagen",
                                                    color: Colors.green,
                                                    selectedText: "Zugesagt",
                                                    onPressed: () {
                                                      print("Zusagen");
                                                    }),
                                              ],
                                            )
                                          ]))))),
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
                mainAxisSize: MainAxisSize.min,
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

class TreffenButton extends StatelessWidget {
  const TreffenButton(
      {Key? key,
      required this.text,
      required this.color,
      required this.onPressed,
      this.selected = false,
      this.selectedText})
      : super(key: key);
  final String text;
  final Color color;
  final Function()? onPressed;
  final bool selected;
  final String? selectedText;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              foregroundColor: black,
              backgroundColor: color,
            ),
            onPressed: onPressed,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              if (selected)
                Padding(
                    padding: EdgeInsets.only(right: MySize(context).w * 0.01),
                    child: Icon(Icons.check)),
              AutoSizeText(
                (selected && selectedText != null) ? selectedText! : text,
                maxLines: 1,
              )
            ])));
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

class Treffen {
  bool admin;
  String art; //Rideout, Grillen, Fahren, Sonstiges
  String start;
  String ziel;
  String datum;
  String uhrzeit;
  String? fahrstil;
  String? notizen;
  List<Map> teilnehmer;

  Treffen(this.admin, this.art, this.start, this.ziel, this.datum, this.uhrzeit,
      this.fahrstil, this.notizen, this.teilnehmer);
}
