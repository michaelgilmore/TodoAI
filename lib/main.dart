import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo2023/screens/create_account.dart';
import 'package:todo2023/screens/friends.dart';
import 'package:todo2023/screens/login.dart';
import 'package:todo2023/screens/today.dart';
import 'package:todo2023/screens/you.dart';

import 'utils/colors.dart';
import 'utils/strings.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Macondo'),
      routes: {
        '/': (context) => Login(),
        '/login': (context) => Login(),
        '/create-account': (context) => CreateAccount(),
        '/friends': (context) => Friends(),
        '/today': (context) => Today(),
        '/you': (context) => You(),
      }
    );
  }
}
