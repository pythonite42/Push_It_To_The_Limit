import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pushit/global/global_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  late String username;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Center(
          child: Image.asset(
        "assets/pushit_logo.png",
      )),
      Scaffold(
          backgroundColor: Colors.transparent,
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Center(
                child: Opacity(
                    opacity: 0.97,
                    child: Card(
                        child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: MySize(context).w * 0.1,
                          vertical: MySize(context).h * 0.05),
                      width: MySize(context).w * 0.7,
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Login",
                              style: TextStyle(fontSize: 20),
                            ),
                            SpaceH(),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Benutzername',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Gib deinen Benutzernamen ein';
                                }
                                return null;
                              },
                              onSaved: (String? value) {
                                setState(() {
                                  username = value ?? "";
                                });
                              },
                            ),
                            SpaceH(0.02),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Passwort',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Gib dein Passwort ein';
                                }
                                return null;
                              },
                              onSaved: (String? value) {
                                setState(() {
                                  password = value ?? "";
                                });
                              },
                            ),
                            SpaceH(),
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                  minWidth: MySize(context).w * 0.3),
                              child: ElevatedButton(
                                  onPressed: () async {
                                    if (formKey.currentState!.validate()) {
                                      formKey.currentState?.save();
                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      prefs.setBool('isLoggedIn', true);
                                      prefs.setString('username', username);
                                      Navigator.pushNamed(context, '/home');
                                    }
                                  },
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                        color: Theme.of(context).cardColor),
                                  )),
                            ),
                            SpaceH(),
                            Text("ODER"),
                            SpaceH(0.03),
                            TextButton(
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(context, '/register');
                                },
                                child: Text("Neu registrieren"))
                          ],
                        ),
                      ),
                    )))),
          ))
    ]);
  }
}
