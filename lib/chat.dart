import 'package:flutter/material.dart';
import 'package:pushit/colors.dart';
import 'package:pushit/global/global_widgets.dart';

class Chat extends StatelessWidget {
  const Chat({Key? key}) : super(key: key);

  Future<List> getChats() async {
    await Future.delayed(Duration(seconds: 1));
    return [1, 2, 3, 4, 4, 4, 4, 4, 4];
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
                    future: getChats(),
                    builder: (context, AsyncSnapshot<List> snapshot) {
                      if (snapshot.hasData) {
                        var data = snapshot.data!;
                        return SingleChildScrollView(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              SpaceH(0.02),
                              InkWell(
                                child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: MySize(context).w * 0.05,
                                        vertical: MySize(context).w * 0.025),
                                    child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Push It TALK",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20),
                                                ),
                                                Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                MySize(context)
                                                                        .w *
                                                                    0.025,
                                                            vertical:
                                                                MySize(context)
                                                                        .w *
                                                                    0.025),
                                                    child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: const [
                                                          Text("Sarah:",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                          Text("Text Bla Bla ",
                                                              style:
                                                                  TextStyle())
                                                        ]))
                                              ]),
                                          Icon(
                                            Icons.chevron_right,
                                            size: MySize(context).h * 0.05,
                                          )
                                        ])),
                                onTap: () {},
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
                                            horizontal:
                                                MySize(context).w * 0.05,
                                            vertical:
                                                MySize(context).w * 0.025),
                                        child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Push It TALK",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20),
                                                    ),
                                                    Padding(
                                                        padding: EdgeInsets.symmetric(
                                                            horizontal:
                                                                MySize(context)
                                                                        .w *
                                                                    0.025,
                                                            vertical:
                                                                MySize(context)
                                                                        .w *
                                                                    0.025),
                                                        child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: const [
                                                              Text("Sarah:",
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold)),
                                                              Text(
                                                                  "Text Bla Bla ",
                                                                  style:
                                                                      TextStyle())
                                                            ]))
                                                  ]),
                                              Icon(
                                                Icons.chevron_right,
                                                size: MySize(context).h * 0.05,
                                              )
                                            ])),
                                    onTap: () {},
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
