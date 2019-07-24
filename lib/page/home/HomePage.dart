import 'package:flutter/material.dart';
import 'package:good_app/compoent/CustomWidget.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
  
}

class HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomWidget.BuildAppBar("客户", context),
      body: Text("客户"),
    );
  }

}