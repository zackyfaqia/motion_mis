import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motion_mis/feature/home/my_home_page.dart';
import 'package:motion_mis/motion_color.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Motion MIS',
      theme: ThemeData(
        primaryColor: MotionColor.RED,
      ),
      home: MyHomePage(title: 'Motion MIS'),
    );
  }
}
