import 'package:flutter/material.dart';
import 'package:untitled24/All.dart';
import 'package:untitled24/Home.dart';

class PutPassword extends StatefulWidget {
  final String userName;

  const PutPassword({super.key, required this.userName});

  @override
  State<PutPassword> createState() => _PutPasswordState();
}

class _PutPasswordState extends State<PutPassword> {
  final password = TextEditingController();

  Future<void> chaeckPassword() async {
    List<Map<String, dynamic>> item = [];
    item = await database.query("user",
        whereArgs: [widget.userName], where: "username=?");
    if (item[0]["password"] == password.text) {
      userName = widget.userName;

      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Home()));
    }
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
            child: Text(
              "Bitwarden",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        Text("主密碼"),
        Container(
          height: 30,
          child: TextField(
            controller: password,
          ),
        ),
        Text(
          "獲取主密碼提示",
          style: TextStyle(color: Colors.blue),
        ),
        GestureDetector(
          onTap: () {
            chaeckPassword();
          },
          child: Center(
            child: Container(
              width: 380,
              height: 40,
              color: Color(0xFF195CD4),
              child: Center(
                child: Text(
                  "繼續",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
