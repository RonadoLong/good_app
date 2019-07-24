import 'package:flutter/material.dart';
import 'package:good_app/compoent/CustomWidget.dart';

class CardPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CardPageState();
  }
  
}

class CardPageState extends State<CardPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomWidget.BuildAppBar("出货车", context),
      body: Text("出货车"),
    );
  }

}