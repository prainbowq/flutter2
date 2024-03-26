import 'package:flutter/material.dart';
import 'package:untitled24/Add.dart';

import 'All.dart';

class PasswordList extends StatefulWidget {
  const PasswordList({super.key});

  @override
  State<PasswordList> createState() => _PasswordListState();
}

class _PasswordListState extends State<PasswordList> {
  List<Map<String, dynamic>> normal = [];
  List<Map<String, dynamic>> isLove = [];

  Future<void> asSort() async {
    List<Map<String, dynamic>> normal2 = await database.query(
        userName.substring(0, userName.length - 10),
        where: "isLove = ?",
        whereArgs: ["0"]);
    List<Map<String, dynamic>> isLove2 = await database.query(
        userName.substring(0, userName.length - 10),
        where: "isLove = ?",
        whereArgs: ["1"]);
    print(normal2);
    setState(() {
      normal = normal2;
      isLove = isLove2;
    });
  }

  @override
  void initState() {
    asSort();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Column(
          children: [
            Container(
              width: double.infinity,
              height: 60,
              color: Color(0xFF195CD4),
              child: Padding(
                padding: const EdgeInsets.only(top: 35.0, left: 20),
                child: Text(
                  "我的密碼庫",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            isLove.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "我的最愛",
                        style: TextStyle(color: Colors.blue),
                      ),
                      Container(
                        height: normal.length * 50,
                        child: ListView.builder(
                            itemCount: normal.length,
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(normal[0]["name"]),
                                  Text(
                                    normal[0]["account"],
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              );
                            }),
                      ),
                    ],
                  )
                : SizedBox(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "未分類",
                  style: TextStyle(color: Colors.blue),
                ),
                Container(
                  height: normal.length * 50,
                  child: ListView.builder(
                      itemCount: normal.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            item = normal[index];
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => Add(look: "檢視")));
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(normal[0]["name"]),
                              Text(
                                normal[0]["account"],
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        );
                      }),
                ),
              ],
            )
          ],
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => Add(
                      look: "新增",
                    )));
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 328.0, top: 600),
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: Text(
                  "+",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        )
      ]),
    );
  }
}
