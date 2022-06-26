import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pushit/colors.dart';
import 'package:pushit/global/appbar.dart';
import 'package:pushit/global/global_widgets.dart';
import 'package:pushit/sql.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class EditProfile extends StatelessWidget {
  EditProfile({Key? key, required this.userdata}) : super(key: key);
  final Map userdata;

  final formKey = GlobalKey<FormState>();

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
                    child: EditProfileForm(
                      name: userdata["name"],
                      bike: userdata["bike"],
                      image: userdata["image"],
                      username: userdata["username"],
                      wohnort: userdata["wohnort"],
                      geburtsjahr: userdata["geburtsjahr"],
                      fahrstil: userdata["fahrstil"],
                      beschreibung: userdata["beschreibung"],
                      geschlecht: userdata["geschlecht"],
                      insta: userdata["insta"],
                    )))));
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
    return WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          return true;
        },
        child: Form(
            key: formKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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

                              final XFile? pic = await _picker.pickImage(
                                  source: ImageSource.gallery);
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
                            child: Text("Profilbild ändern"))
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
                          return 'Der Benutzername darf nicht "admin" lauten';
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
                                initialValue: (geburtsjahr == 0)
                                    ? null
                                    : geburtsjahr.toString(),
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return null;
                                  }
                                  var valInt = int.parse(value);
                                  if (valInt > DateTime.now().year ||
                                      valInt < 1970) {
                                    return "$value ist kein gültiges Geburtsdatum";
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
                                    setState(() {
                                      fahrstil = newValue ?? "Keine Angabe";
                                    });
                                  },
                                  items: <String>[
                                    "Keine Angabe",
                                    "Rasant",
                                    "Gemütlich",
                                    "Anpassungsfähig"
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
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
                                  labelText: "Schreibe etwas über dich",
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
                                    setState(() {
                                      geschlecht = newValue!;
                                    });
                                  },
                                  items: <String>[
                                    "Keine Angabe",
                                    "Weiblich",
                                    "Männlich",
                                    "Divers"
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
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
                      constraints:
                          BoxConstraints(minWidth: MySize(context).w * 0.4),
                      child: ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState?.save();
                              loadingDialog(context);
                              bool usernameFree =
                                  await SQL().isUsernameFree(username);
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              Navigator.of(context).pop();
                              if (usernameFree ||
                                  prefs.getString('username') == username) {
                                prefs.setString('username', username);
                                await SQL().updateProfile({
                                  "name": name,
                                  "bike": bike,
                                  "image": image,
                                  "username": username,
                                  "wohnort": wohnort,
                                  "geburtsjahr": geburtsjahr,
                                  "fahrstil": fahrstil,
                                  "beschreibung": beschreibung,
                                  "geschlecht": geschlecht,
                                  "insta": insta
                                });
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text('Profil aktualisiert'),
                                ));
                              } else {
                                myDialog(
                                    context,
                                    Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(
                                            Icons.error_outline,
                                            color: red,
                                            size: MySize(context).h * 0.1,
                                          ),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  top:
                                                      MySize(context).h * 0.04),
                                              child: Text(
                                                  'Dieser Benutzername ist bereits vergeben',
                                                  textAlign: TextAlign.center)),
                                        ]));
                              }
                            }
                          },
                          child: Text(
                            "Speichern",
                            style: TextStyle(
                                color: Theme.of(context).cardColor,
                                fontSize: 18),
                          )),
                    ),
                    SpaceH(),
                    Divider(
                      thickness: 1,
                      color: red,
                    ),
                    SpaceH(),
                    ConstrainedBox(
                      constraints:
                          BoxConstraints(minWidth: MySize(context).w * 0.3),
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
                                  title: Text("Profil löschen"),
                                  content: Text(
                                      "Wenn du dein Profil löschst kann es nicht wiederhergestellt werden.\n\nMöchtest du dein Profil dennoch löschen?"),
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
                                              await SharedPreferences
                                                  .getInstance();
                                          prefs.setBool('isLoggedIn', false);
                                          prefs.setString('username', "");
                                          Navigator.pushNamedAndRemoveUntil(
                                              context,
                                              '/login',
                                              (Route<dynamic> route) => false);
                                        },
                                        child: Text(
                                          "Profil löschen",
                                          style: TextStyle(color: red),
                                        ))
                                  ],
                                );
                              },
                              barrierDismissible: true,
                            );
                          },
                          child: Text(
                            "Profil löschen",
                            style: TextStyle(color: red),
                          )),
                    ),
                    SpaceH()
                  ])
                ])));
  }
}
