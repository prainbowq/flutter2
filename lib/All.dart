import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

late Database database;
late SharedPreferences sharedPreferences;
late String userName;
late Map<String, dynamic> item;
