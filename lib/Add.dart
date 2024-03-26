import 'package:flutter/material.dart';
import 'package:untitled24/Home.dart';
import 'package:untitled24/givepassword.dart';

import 'All.dart';

class Add extends StatefulWidget {
  const Add({super.key, required this.look});

  final String look;

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  final name = TextEditingController();
  final account = TextEditingController();
  final password = TextEditingController();
  bool isLove = false;
  String type = "登入";

  Future<void> insertData() async {
    database.insert(userName.substring(0, userName.length - 10), {
      "name": name.text,
      "account": account.text,
      "password": password.text,
      "isLove": isLove ? "1" : "0"
    });
  }

  Future<void> update() async {
    database.update(userName.substring(0, userName.length - 10), {
      "name": name.text,
      "account": account.text,
      "password": password.text,
      "isLove": isLove ? "1" : "0"
    });
  }

  Future<void> put() async {
    if (type != "新增") {
      name.text = item["name"];
      account.text = item["account"];
      password.text = item["password"];
      isLove = item["isLove"] == 1 ? true : false;
    }
  }

  @override
  void initState() {
    put();
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
                      widget.look == "新增" ? insertData() : update();
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => Home()));
                    },
                    child: widget.look == "新增"
                        ? Text(
                            "送出",
                            style: TextStyle(color: Colors.white),
                          )
                        : Text(
                            "編輯",
                            style: TextStyle(color: Colors.white),
                          ),
                  )
                ],
              ),
            ),
          ),
          Text(
            "類型",
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
          ),
          Text(type),
          Container(
            width: double.infinity,
            height: 1,
            color: Colors.grey,
          ),
          Text(
            "名稱",
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
          ),
          Container(
            height: 30,
            child: TextField(
              controller: name,
            ),
          ),
          Text(
            "使用者名稱",
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
          ),
          Container(
            height: 30,
            child: TextField(
              controller: account,
            ),
          ),
          Text(
            "密碼",
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              Container(
                width: 320,
                height: 30,
                child: TextField(
                  controller: password,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(
                          builder: (context) => givePassword()))
                      .then((value) => setState(() => password.text = value));
                },
                child: Container(
                  width: 30,
                  height: 30,
                  child: Image.asset("assets/refresh.png"),
                ),
              )
            ],
          ),
          Row(
            children: [
              Text("我的最愛"),
              Switch(
                  value: isLove,
                  onChanged: (value) {
                    setState(() {
                      isLove = value;
                    });
                  })
            ],
          )
        ],
      ),
    );
  }
}
