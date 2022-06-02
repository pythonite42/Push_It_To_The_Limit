import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pushit/global/appbar.dart';
import 'package:pushit/global/global_widgets.dart';

class Profile extends StatelessWidget {
  Profile({Key? key, required this.data}) : super(key: key);
  final Map data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(),
        body: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.only(
                  left: MySize(context).w * 0.08,
                  right: MySize(context).w * 0.08,
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SpaceH(),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: MySize(context).w * 0.15,
                            backgroundImage: MemoryImage(data["image"]), //here
                          ),
                          SpaceW(),
                          Expanded(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                Text(
                                  data["name"],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                SpaceH(0.02),
                                Text(data["bike"],
                                    style: TextStyle(fontSize: 20))
                              ])),
                        ],
                      ),
                      SpaceH(),
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        ElevatedButton(
                            onPressed: () {
                              log("Nachricht senden");
                            },
                            child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Icon(Icons.send),
                                  SpaceW(),
                                  Text("DM")
                                ])),
                      ]),
                      SpaceH(),
                      ProfileRow(
                          label: "Benutzername", value: data["username"]),
                      ProfileRow(label: "Wohnort", value: data["wohnort"]),
                      ProfileRow(
                          label: "Geburtsjahr",
                          value: data["geburtsjahr"].toString()),
                      ProfileRow(label: "Fahrstil", value: data["fahrstil"]),
                      ProfileRow(
                          label: "Beschreibung", value: data["beschreibung"]),
                      ProfileRow(
                          label: "Geschlecht", value: data["geschlecht"]),
                      ProfileRow(label: "Instagram", value: data["insta"]),
                      SpaceH(),
                    ]))));
  }
}

class ProfileRow extends StatelessWidget {
  const ProfileRow({Key? key, required this.label, required this.value})
      : super(key: key);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    if (value != "" && value != "0" && value != "Keine Angabe") {
      return Padding(
          padding: EdgeInsets.symmetric(vertical: MySize(context).h * 0.03),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                  flex: 1,
                  child: Text(
                    label,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
              Flexible(
                flex: 2,
                child: Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Text(
                      (label == "Instagram") ? "@ $value" : value,
                      textAlign: TextAlign.end,
                    )),
              )
            ],
          ));
    } else {
      return Container();
    }
  }
}
