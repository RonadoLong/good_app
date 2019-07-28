// This sample shows adding an action to an [AppBar] that opens a shopping cart.

import 'package:flutter/material.dart';
import 'package:good_app/MainPage.dart';
import 'package:good_app/utils/UIData.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final materialApp = MaterialApp(
      title: UIData.appName,
      theme: new ThemeData(
        primaryColor: UIData.primary_color,
      ),
      debugShowCheckedModeBanner: false,
      showPerformanceOverlay: false,
      home: MainPage() );
    return materialApp;
  }
}
