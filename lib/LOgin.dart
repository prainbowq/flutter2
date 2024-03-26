import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:untitled24/All.dart';
import 'package:untitled24/PutPassword.dart';
import 'package:untitled24/Sign.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final username = TextEditingController();
  bool rememberMe = false;

  Future<void> data() async {
    database = await openDatabase("${await getDatabasesPath()}?Database",
        onCreate: (db, version) {
          db.execute(
              "CREATE TABLE user(id INTEGER PRIMARY KEY ,userName TEXT ,password TEXT ,give TEXT)");
        }, version: 1);
  }

  @override
  void initState() {
    data();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          width: double.infinity,
          height: 60,
          color: Color(0xFF195CD4),
          child: Padding(
            padding: const EdgeInsets.only(top: 35.0, left: 20),
            child: Text(
              "Bitwarden",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        Image.asset("assets/logo.png"),
        Text("電子郵件地址"),
        TextField(
          controller: username,
        ),
        Row(
          children: [
            Text("記住我"),
            Switch(
                value: rememberMe,
                onChanged: (onChanged) {
                  setState(() {
                    rememberMe = onChanged;
                  });
                })
          ],
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => PutPassword(userName: username.text,)));
          },
          child: Center(
            child: Container(
              width: 380,
              height: 40,
              color: Color(0xFF195CD4),
              child: Center(
                child: Text(
                  "繼續",
                  style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
        Row(
          children: [
            Text("第一次使用"),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => Sign()));
              },
              child: Text(
                "建立帳戶",
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        )
      ]),
    );
  }
}
