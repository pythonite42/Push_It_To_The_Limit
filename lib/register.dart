import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pushit/colors.dart';
import 'package:pushit/global/global_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formKey = GlobalKey<FormState>();
  String name = "";
  String bike = "";
  Uint8List image = Uint8List(0);
  String username = "";
  String password = "";
  String wohnort = "";
  int geburtsjahr = 0;
  String fahrstil = "Keine Angabe";
  String beschreibung = "";
  String geschlecht = "Keine Angabe";
  String insta = "";
  bool showNoPicSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: SingleChildScrollView(
                child: Container(
              padding: EdgeInsets.only(
                left: MySize(context).w * 0.08,
                right: MySize(context).w * 0.08,
                top: MySize(context).h * 0.05,
              ),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SpaceH(),
                    Heading(label: "Registrieren"),
                    SpaceH(0.08),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(children: [
                          (image.isNotEmpty)
                              ? CircleAvatar(
                                  radius: MySize(context).w * 0.15,
                                  backgroundImage: MemoryImage(image), //here
                                )
                              : CircleAvatar(
                                  backgroundColor: lightGrey,
                                  radius: MySize(context).w * 0.15,
                                  child: Icon(
                                    Icons.photo,
                                    size: MySize(context).w * 0.15,
                                    color: black,
                                  ),
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
                                  showNoPicSelected = false;
                                  image = bytes;
                                });
                              },
                              child: Text("Profilbild ändern"))
                        ]),
                        SpaceW(0.08),
                        Expanded(
                            child: Column(children: [
                          TextFormField(
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
                    if (showNoPicSelected)
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SpaceH(),
                            Text(
                              "Bitte wähle ein Profilbild aus",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                            ),
                          ]),
                    SpaceH(),
                    Divider(
                      thickness: 1,
                      color: red,
                    ),
                    SpaceH(),
                    Column(children: [
                      SpaceH(0.03),
                      RegisterRow(
                        label: "Benutzername *",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Gib deinen Benutzernamen ein';
                          }
                          if (value == "admin") {
                            return 'Der Benutzername ist ungültig';
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
                        label: "Passwort *",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Gib dein Passwort ein';
                          }
                          setState(() {
                            password = value;
                          });
                          return null;
                        },
                        onSaved: (String? value) {
                          setState(() {
                            password = value ?? "";
                          });
                        },
                      ),
                      SpaceH(0.02),
                      RegisterRow(
                        label: 'Passwort wiederholen *',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Gib dein Passwort erneut ein';
                          }

                          if (value != password) {
                            return 'Die Passwörter stimmen nicht überein';
                          }
                          return null;
                        },
                        onSaved: (String? value) {},
                      ),
                      SpaceH(0.1),
                      Divider(
                        thickness: 1,
                        color: red,
                      ),
                      SpaceH(),
                      RegisterRow(
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
                                    setState(() {
                                      try {
                                        geburtsjahr = int.parse(value ?? "0");
                                      } catch (_) {
                                        geburtsjahr = 0;
                                      }
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
                                        fahrstil = newValue!;
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
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(flex: 1, child: Text("Beschreibung")),
                          Flexible(
                            flex: 2,
                            child: Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: TextFormField(
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
                                  Expanded(child: TextFormField(
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
                            BoxConstraints(minWidth: MySize(context).w * 0.3),
                        child: ElevatedButton(
                            onPressed: () async {
                              if (image.isEmpty) {
                                formKey.currentState!.validate();
                                setState(() {
                                  showNoPicSelected = true;
                                });
                              } else {
                                if (formKey.currentState!.validate()) {
                                  formKey.currentState?.save();
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.setBool('isLoggedIn', true);
                                  prefs.setString('username', username);
                                  Navigator.pushNamedAndRemoveUntil(context,
                                      '/home', (Route<dynamic> route) => false);
                                }
                              }
                            },
                            child: Text(
                              "Registrieren",
                              style:
                                  TextStyle(color: Theme.of(context).cardColor),
                            )),
                      ),
                      SpaceH()
                    ])
                  ],
                ),
              ),
            ))));
  }
}
