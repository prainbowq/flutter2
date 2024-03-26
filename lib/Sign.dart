import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:untitled24/All.dart';
import 'package:untitled24/LOgin.dart';

class Sign extends StatefulWidget {
  const Sign({super.key});

  @override
  State<Sign> createState() => _SignState();
}

class _SignState extends State<Sign> {
  final username = TextEditingController();
  final password = TextEditingController();
  final passwordAgain = TextEditingController();
  final give = TextEditingController();
  bool look = false;

  Future<void> insertData() async {
    if (username.text.contains("@") || username.text.contains(".")) {
      if (password.text.length >= 12) {
        data();
        database.insert("user", {
          "userName": username.text,
          "password": password.text,
          "give": give.text
        });
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => Login()));
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text("密碼小於１２"),
              );
            });
      }
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text("帳號格式錯誤"),
            );
          });
    }
  }

  Future<void> data() async {
    database.execute(
        "CREATE TABLE ${username.text.substring(0, username.text.length - 10)}(id INTEGER PRIMARY KEY ,name TEXT ,account TEXT ,password TEXT,isLove TEXT)");
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
                    "建立帳戶",
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    width: 250,
                  ),
                  GestureDetector(
                    onTap: () {
                      insertData();
                    },
                    child: Text(
                      "建立帳戶",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ),
          Text(
            "電子郵件地址",
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
          ),
          Container(
            height: 30,
            child: TextField(
              controller: username,
            ),
          ),
          Text(
            "主密碼",
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              Container(
                height: 30,
                width: 320,
                child: TextField(
                  obscureText: look,
                  controller: password,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    look = !look;
                  });
                },
                child: Container(
                  width: 30,
                  height: 30,
                  child: look
                      ? Image.asset("assets/look.png")
                      : Image.asset("assets/look2.png"),
                ),
              )
            ],
          ),
          Text(
            "確認主密碼",
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              Container(
                height: 30,
                width: 320,
                child: TextField(
                  obscureText: look,
                  controller: passwordAgain,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    look = !look;
                  });
                },
                child: Container(
                  width: 30,
                  height: 30,
                  child: Container(
                    width: 30,
                    height: 30,
                    child: look
                        ? Image.asset("assets/look.png")
                        : Image.asset("assets/look2.png"),
                  ),
                ),
              )
            ],
          ),
          Text(
            "主密碼提示(可省略) ",
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
          ),
          Container(
            height: 30,
            child: TextField(
              controller: give,
            ),
          )
        ],
      ),
    );
  }
}
