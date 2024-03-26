import 'package:flutter/material.dart';
import 'package:untitled24/Add.dart';

import 'PasswordList.dart';
import 'givepassword.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> item = [];
  int index = 0;

  @override
  void initState() {
    item = [
      PasswordList(),
      PasswordList(),
      givePassword(),
      PasswordList(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Text("1"), label: ""),
            BottomNavigationBarItem(icon: Text("2"), label: ""),
            BottomNavigationBarItem(icon: Text("3"), label: ""),
            BottomNavigationBarItem(icon: Text("4"), label: ""),
          ],
          onTap: (value) {
            setState(() {
              index = value;
            });
          },
          currentIndex: index,
        ),
        body: IndexedStack(
          index: index,
          children: item,
        ));
  }
}
