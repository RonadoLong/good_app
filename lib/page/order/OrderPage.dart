import 'package:flutter/material.dart';
import 'package:good_app/compoent/CustomWidget.dart';

class OrderPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return OrderPageState();
  }
  
}

class OrderPageState extends State<OrderPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomWidget.buildAppBar("订单", context),
      body: Text("订单"),
    );
  }

}