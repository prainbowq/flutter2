import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class givePassword extends StatefulWidget {
  const givePassword({super.key});

  @override
  State<givePassword> createState() => _givePasswordState();
}

class _givePasswordState extends State<givePassword> {
  String type = "密碼";
  int length = 5;
  int length2 = 5;
  int minCount = 0;
  int minSpecial = 0;
  bool big = true;
  bool big2 = true;
  bool small = true;
  bool count = true;
  bool count2 = true;
  bool special = true;
  String spw = "!@#\$%^&*()";
  String password = "ij";
  final sqw2 = TextEditingController();
  List<Map<String, dynamic>> jsonList123 = [];

  Future<void> loadJson() async {
    String jsonList = await DefaultAssetBundle.of(context).loadString("assets/dic.json");
    List<dynamic> jsondecode2 = jsonDecode(jsonList);
    setState(() {
      jsonList123 = jsondecode2.cast<Map<String, dynamic>>();
    });
  }

  @override
  void initState() {
    loadJson().then((value) {
      setState(() {
        password = jsonPassword();
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 60,
            color: Color(0xFF195CD4),
            child: Padding(
              padding: const EdgeInsets.only(top: 35.0, left: 20),
              child: Row(
                children: [
                  Text(
                    "Bitwarden",
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    width: 250,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop(password);
                    },
                    child: Text(
                      "儲存",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
          high(),
          Text("選項"),
          Text("密碼類型"),
          GestureDetector(
              onTap: () {
                option();
              },
              child: Text(type)),
          type == "密碼"
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("長度"),
                        Text(length.toString()),
                        Slider(
                            max: 128,
                            min: 5,
                            value: length.toDouble(),
                            onChanged: (onChanged) {
                              setState(() {
                                length = onChanged.toInt();
                                password = normalPassword();
                              });
                            })
                      ],
                    ),
                    Row(
                      children: [
                        Text("A-Z"),
                        SizedBox(
                          width: 300,
                        ),
                        Switch(
                            value: big,
                            onChanged: (onChanged) {
                              setState(() {
                                big = onChanged;
                                password = normalPassword();
                              });
                            })
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      height: 1,
                      color: Colors.grey,
                    ),
                    Row(
                      children: [
                        Text("a-z"),
                        SizedBox(
                          width: 300,
                        ),
                        Switch(
                            value: small,
                            onChanged: (onChanged) {
                              setState(() {
                                small = onChanged;
                                password = normalPassword();
                              });
                            })
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      height: 1,
                      color: Colors.grey,
                    ),
                    Row(
                      children: [
                        Text("0-9"),
                        SizedBox(
                          width: 300,
                        ),
                        Switch(
                            value: count,
                            onChanged: (onChanged) {
                              setState(() {
                                count = onChanged;
                                password = normalPassword();
                              });
                            })
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      height: 1,
                      color: Colors.grey,
                    ),
                    Row(
                      children: [
                        Text("!@#\$%^&*()"),
                        SizedBox(
                          width: 245,
                        ),
                        Switch(
                            value: special,
                            onChanged: (onChanged) {
                              setState(() {
                                special = onChanged;
                                password = normalPassword();
                              });
                            })
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      height: 1,
                      color: Colors.grey,
                    )
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("單字數量"),
                        Text(length2.toString()),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              length2++;
                              password = jsonPassword();
                            });
                          },
                          child: Container(
                            width: 50,
                            height: 30,
                            color: Colors.grey,
                            child: Center(child: Text("+")),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              length2--;
                              password = jsonPassword();
                            });
                          },
                          child: Container(
                            width: 50,
                            height: 30,
                            color: Colors.grey,
                            child: Center(child: Text("-")),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text("大寫"),
                        Switch(
                            value: big2,
                            onChanged: (onChanged) {
                              setState(() {
                                big2 = onChanged;
                                password = jsonPassword();
                              });
                            })
                      ],
                    ),
                    Row(
                      children: [
                        Text("數字"),
                        Switch(
                            value: count2,
                            onChanged: (onChanged) {
                              setState(() {
                                count2 = onChanged;
                                password = jsonPassword();
                              });
                            })
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      height: 1,
                      color: Colors.grey,
                    )
                  ],
                )
        ],
      ),
    );
  }

  String normalPassword() {
    String charset = "";
    String password = "";
    Random random = Random();
    if (big) charset = "QWERTYUIOPLKJHGFDSAZXCVBNM";
    if (small) charset = "qwertyuioplkjhgfdsazxcvbnm";
    if (count) charset += "0123456789";
    if (special) charset += "!@#\$%^&*()";
    if (charset.isEmpty) return "";
    String sp = "!@#\$%^&*()";
    for (int i = 0; i < minCount; i++) {
      int index = random.nextInt(10);
      password += index.toString();
    }
    for (int i = 0; i < minSpecial; i++) {
      int index = random.nextInt(sp.length);
      password += sp[index];
    }
    int length2 = length - minCount - minSpecial;
    for (int i = 0; i < length2; i++) {
      int index = random.nextInt(charset.length);
      password += charset[index];
    }
    List<String> paswords = password.split("");
    paswords.shuffle();
    password = paswords.join("");

    return password;
  }

  Widget high() {
    List<Widget> okWidget = [];
    RegExp regExp = RegExp(r"\d");
    for (int i = 0; i < password.length; i++) {
      if (regExp.hasMatch(password[i])) {
        okWidget.add(Text(
          password[i],
          style: TextStyle(color: Colors.blue),
        ));
      } else if (spw.contains(password[i]) ||
          sqw2.text.contains(password[i]) ||
          password[i] == "-") {
        okWidget.add(Text(
          password[i],
          style: TextStyle(color: Colors.red),
        ));
      } else {
        okWidget.add(Text(password[i]));
      }
    }
    return Wrap(
      children: okWidget,
    );
  }

  String jsonPassword() {
    List<Map<String, dynamic>> list = [];
    Random random = Random();
    for (int i = 0; i < length2; i++) {
      int index = random.nextInt(jsonList123.length);
      list.add(jsonList123[index]);
    }
    List<String> words = list.map((e) {
      String word = e["word"];
      if (big2) {
        word = word.substring(0, 1).toUpperCase() + word.substring(1);
      }
      return word;
    }).toList();
    if (count2) {
      words[random.nextInt(words.length)] += random.nextInt(10).toString();
    }
    return words.join(sqw2.text.isEmpty ? "-" : sqw2.text);
  }

  void option() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              height: 50,
              child: Column(
                children: [
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          type = "密碼";
                        });
                        Navigator.of(context).pop();
                      },
                      child: Text("密碼")),
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          type = "密語";
                        });
                        Navigator.of(context).pop();
                      },
                      child: Text("密語"))
                ],
              ),
            ),
          );
        });
  }
}
