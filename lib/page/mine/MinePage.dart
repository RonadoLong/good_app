import 'package:flutter/material.dart';
import 'package:good_app/compoent/CustomWidget.dart';
import 'package:good_app/utils/UIData.dart';

class MinePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MinePageState();
  }
}

class MinePageState extends State<MinePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomWidget.BuildAppBar("我的", context),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            _createHeader(),
            CustomWidget.BuildLineView(8),
            buildContent(),
            CustomWidget.BuildLineView(8),
            buildGrid(),
          ],
        ),
      ),
    );
  }

  // 头部
  Widget _createHeader() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(20, 25, 20, 15),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.personal_video),
                onPressed: () {},
              ),
              Padding(padding: EdgeInsets.only(left: 10,)),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("碉堡陈总", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: UIData.normal_font_color),),
                  Padding(
                    padding: EdgeInsets.only(top: 8),
                  ),
                  Text("17620036212", style: TextStyle(fontSize: 14, color: UIData.normal_font_color)),
                ],
              ),
            ],
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward_ios,color: UIData.normal_line_color,),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  // 统计分析
  Widget buildContent() {
    return Container();
  }

  // 九宫格
  Widget buildGrid() {
    return Container();
  }
}
