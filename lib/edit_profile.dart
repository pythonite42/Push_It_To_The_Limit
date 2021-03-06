import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pushit/colors.dart';
import 'package:pushit/global/appbar.dart';
import 'package:pushit/global/global_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class EditProfile extends StatelessWidget {
  EditProfile({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();

  Future<Map> getData() async {
    await Future.delayed(Duration(seconds: 1));
    ByteData bytes = await rootBundle.load('assets/pushit_logo.png');
    Uint8List list = bytes.buffer.asUint8List();
    log("FutureBUilder");
    return {
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
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(),
        body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: SingleChildScrollView(
                child: Container(
              padding: EdgeInsets.only(
                left: MySize(context).w * 0.08,
                right: MySize(context).w * 0.08,
              ),
              child: FutureBuilder<Map>(
                  future: getData(),
                  builder: (context, AsyncSnapshot<Map> snapshot) {
                    if (snapshot.hasData) {
                      var data = snapshot.data!;
                      return EditProfileForm(
                        name: data["name"],
                        bike: data["bike"],
                        image: data["image"],
                        username: data["username"],
                        wohnort: data["wohnort"],
                        geburtsjahr: data["geburtsjahr"],
                        fahrstil: data["fahrstil"],
                        beschreibung: data["beschreibung"],
                        geschlecht: data["geschlecht"],
                        insta: data["insta"],
                      );
                    } else if (snapshot.hasError) {
                      return WholeScreenErrorFutureBuilder();
                    } else {
                      return WholeScreenLoadingFutureBuilder();
                    }
                  }),
            ))));
  }
}

class EditProfileForm extends StatefulWidget {
  const EditProfileForm(
      {Key? key,
      required this.name,
      required this.bike,
      required this.image,
      required this.username,
      required this.wohnort,
      required this.geburtsjahr,
      required this.fahrstil,
      required this.beschreibung,
      required this.geschlecht,
      required this.insta})
      : super(key: key);
  final String name;
  final String bike;
  final Uint8List image;
  final String username;
  final String wohnort;
  final int geburtsjahr;
  final String fahrstil;
  final String beschreibung;
  final String geschlecht;
  final String insta;

  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  final formKey = GlobalKey<FormState>();
  String name = "";
  String bike = "";
  Uint8List image = Uint8List(0);
  String username = "";
  String wohnort = "";
  int geburtsjahr = 0;
  String fahrstil = "Keine Angabe";
  String beschreibung = "";
  String geschlecht = "Keine Angabe";
  String insta = "";

  @override
  void initState() {
    name = widget.name;
    bike = widget.bike;
    image = widget.image;
    username = widget.username;
    wohnort = widget.wohnort;
    geburtsjahr = widget.geburtsjahr;
    fahrstil = widget.fahrstil;
    beschreibung = widget.beschreibung;
    geschlecht = widget.geschlecht;
    insta = widget.insta;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SpaceH(),
          Heading(label: "Profil bearbeiten"),
          SpaceH(0.08),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(children: [
                CircleAvatar(
                  radius: MySize(context).w * 0.15,
                  backgroundImage: MemoryImage(image), //here
                ),
                TextButton(
                    onPressed: () async {
                      final ImagePicker _picker = ImagePicker();

                      final XFile? pic =
                          await _picker.pickImage(source: ImageSource.gallery);
                      final path = pic?.path;
                      if (path == null) {
                        return;
                      }
                      File file = File(path);
                      Uint8List bytes = file.readAsBytesSync();
                      setState(() {
                        image = bytes;
                      });
                    },
                    child: Text("Profilbild ??ndern"))
              ]),
              SpaceW(0.08),
              Expanded(
                  child: Column(children: [
                TextFormField(
                  initialValue: name,
                  decoration: const InputDecoration(
                    labelText: 'Name *',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'z.B. Kevin';
                    }
                    return null;
                  },
                  onSaved: (String? value) {
                    setState(() {
                      name = value ?? "";
                    });
                  },
                ),
                SpaceH(0.02),
                TextFormField(
                  initialValue: bike,
                  decoration: const InputDecoration(
                    labelText: 'Bike *',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'z.B. Kawasaki Z900';
                    }
                    return null;
                  },
                  onSaved: (String? value) {
                    setState(() {
                      bike = value ?? "";
                    });
                  },
                )
              ]))
            ],
          ),
          SpaceH(),
          Column(children: [
            SpaceH(0.03),
            RegisterRow(
              initialValue: username,
              label: "Benutzername *",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Gib deinen Benutzernamen ein';
                }
                if (value == "admin") {
                  return 'Der Benutzername ist ung??ltig';
                }
                return null;
              },
              onSaved: (String? value) {
                setState(() {
                  username = value ?? "";
                });
              },
            ),
            SpaceH(0.03),
            RegisterRow(
              initialValue: wohnort,
              label: "Wohnort",
              onSaved: (String? value) {
                setState(() {
                  wohnort = value ?? "";
                });
              },
            ),
            SpaceH(0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(flex: 1, child: Text("Geburtsjahr")),
                Flexible(
                  flex: 2,
                  child: Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: TextFormField(
                        initialValue:
                            (geburtsjahr == 0) ? null : geburtsjahr.toString(),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return null;
                          }
                          var valInt = int.parse(value);
                          if (valInt > DateTime.now().year || valInt < 1970) {
                            return "$value ist kein g??ltiges Geburtsdatum";
                          }
                        },
                        onSaved: (String? value) {
                          try {
                            setState(() {
                              geburtsjahr = int.parse(value ?? "0");
                            });
                          } catch (_) {
                            setState(() {
                              geburtsjahr = 0;
                            });
                          }
                        },
                      )),
                )
              ],
            ),
            SpaceH(0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(flex: 1, child: Text("Fahrstil")),
                Flexible(
                    flex: 2,
                    child: Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: DropdownButtonFormField(
                          value: fahrstil,
                          icon: const Icon(Icons.expand_more),
                          onChanged: (String? newValue) {
                            log("changed to $newValue");
                            setState(() {
                              fahrstil = newValue ?? "Keine Angabe";
                            });
                          },
                          items: <String>[
                            "Keine Angabe",
                            "Rasant",
                            "Gem??tlich",
                            "Anpassungsf??hig"
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: (value == "Keine Angabe")
                                  ? Text(value,
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          color: grey))
                                  : Text(value),
                            );
                          }).toList(),
                        )))
              ],
            ),
            SpaceH(0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(flex: 1, child: Text("Beschreibung")),
                Flexible(
                  flex: 2,
                  child: Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: TextFormField(
                        initialValue: beschreibung,
                        maxLines: 6,
                        decoration: InputDecoration(
                          labelText: "Schreibe etwas ??ber dich",
                        ),
                        onSaved: (String? newValue) {
                          setState(() {
                            beschreibung = newValue!;
                          });
                        },
                      )),
                )
              ],
            ),
            SpaceH(0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(flex: 1, child: Text("Geschlecht")),
                Flexible(
                    flex: 2,
                    child: Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: DropdownButtonFormField(
                          value: geschlecht,
                          icon: const Icon(Icons.expand_more),
                          onChanged: (String? newValue) {
                            log("Geschlecht changed");
                            setState(() {
                              geschlecht = newValue!;
                            });
                          },
                          items: <String>[
                            "Keine Angabe",
                            "Weiblich",
                            "M??nnlich",
                            "Divers"
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: (value == "Keine Angabe")
                                  ? Text(value,
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          color: grey))
                                  : Text(value),
                            );
                          }).toList(),
                        )))
              ],
            ),
            SpaceH(0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(flex: 1, child: Text("Instagram")),
                Flexible(
                  flex: 2,
                  child: Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Row(children: [
                        Text("@ "),
                        Expanded(
                            child: TextFormField(
                          initialValue: insta,
                          onSaved: (String? newValue) {
                            setState(() {
                              insta = newValue!;
                            });
                          },
                        ))
                      ])),
                )
              ],
            ),
            SpaceH(),
            ConstrainedBox(
              constraints: BoxConstraints(minWidth: MySize(context).w * 0.4),
              child: ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState?.save();
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setString('username', username);

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Profil aktualisiert'),
                      ));
                    }
                  },
                  child: Text(
                    "Speichern",
                    style: TextStyle(
                        color: Theme.of(context).cardColor, fontSize: 18),
                  )),
            ),
            SpaceH(),
            Divider(
              thickness: 1,
              color: red,
            ),
            SpaceH(),
            ConstrainedBox(
              constraints: BoxConstraints(minWidth: MySize(context).w * 0.3),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      side: BorderSide(
                        width: 2.0,
                        color: red,
                      )),
                  onPressed: () async {
                    showDialog(
                      useRootNavigator: false,
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          //insetPadding: EdgeInsets.all(15),
                          title: Text("Profil l??schen"),
                          content: Text(
                              "Wenn du dein Profil l??schst kann es nicht wiederhergestellt werden.\n\nM??chtest du dein Profil dennoch l??schen?"),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  "Abbrechen",
                                )),
                            TextButton(
                                onPressed: () async {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.setBool('isLoggedIn', false);
                                  prefs.setString('username', "");
                                  Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      '/login',
                                      (Route<dynamic> route) => false);
                                },
                                child: Text(
                                  "Profil l??schen",
                                  style: TextStyle(color: red),
                                ))
                          ],
                        );
                      },
                      barrierDismissible: true,
                    );
                  },
                  child: Text(
                    "Profil l??schen",
                    style: TextStyle(color: red),
                  )),
            ),
            SpaceH()
          ])
        ]));
  }
}
