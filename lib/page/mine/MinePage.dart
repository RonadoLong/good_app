import 'package:flutter/material.dart';
import 'package:good_app/compoent/CustomWidget.dart';

class MinePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MinePageState();
  }
  
}

class MinePageState extends State<MinePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomWidget.BuildAppBar("我的", context),
      body: Text("我的"),
    );
  }

}