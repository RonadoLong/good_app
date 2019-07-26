import 'package:flutter/material.dart';
import 'package:good_app/page/home/model/Consumer.dart';
import 'package:good_app/utils/UIData.dart';

// CreateCell 构建cell
Container createCell(Consumer consumer) {
  return Container(
    padding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          consumer.username,
          style: TextStyle(
              color: UIData.normal_font_color,
              fontWeight: FontWeight.w600,
              fontSize: 16),
        ),
        Column(
          children: <Widget>[
            buildBottom(),
            Padding(
              padding: EdgeInsets.only(top: 6),
            ),
            Text("经办人: " + consumer.oprationName),
          ],
        )
      ],
    ),
  );
}

Widget buildBottom() {
  return RaisedButton(
    onPressed: () {
      print("开单");
    },
    textColor: Colors.white,
    clipBehavior: Clip.hardEdge,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0))),
    padding: const EdgeInsets.all(0.0),
    child: Container(
      width: 100,
      height: 40,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Color(0xff25D1D1),
            Color(0xff3BE6AD),
            Color(0xff20DDAA)
          ],
        ),
      ),
      // padding: const EdgeInsets.all(10.0),
      child: Container(alignment: Alignment.center, child: Text('开单')),
    ),
  );
}
