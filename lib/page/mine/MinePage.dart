import 'dart:async';

import 'package:flutter/cupertino.dart';
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

  Future<void> _handleRefresh() {
    final Completer<void> completer = Completer<void>();
    Timer(const Duration(seconds: 1), () {
      completer.complete();
    });
    return completer.future.then<void>((_) {
      print("REFRESH_REQIEST");
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> rows = [
      _createHeader(),
      CustomWidget.buildLineView(2),
      buildContent(),
      CustomWidget.buildLineView(2),
      buildGrid(),
    ];
    var listView = RefreshIndicator(
      onRefresh: (() => _handleRefresh()),
      color: UIData.refresh_color, //刷新控件的颜色
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        separatorBuilder: (context, idx) {
          return CustomWidget.buildLineView(4);
        },
        itemCount: 5,
        itemBuilder: (context, i) => rows[i],
      ),
    );

    return Scaffold(
      appBar: CustomWidget.buildAppBar("我的", context),
      body: listView,
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
              Padding(padding: EdgeInsets.only(left: 15)),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "碉堡陈总",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: UIData.normal_font_color),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8),
                  ),
                  Text("17620036212",
                      style: TextStyle(
                          fontSize: 15, color: UIData.normal_font_color)),
                ],
              ),
            ],
          ),
          IconButton(
            icon: Icon(
              Icons.arrow_forward_ios,
              color: UIData.normal_line_color,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  // 统计分析
  Widget buildContent() {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          buildHeaderTitleView("统计分析"),
          CustomWidget.buildLineView(2),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              CustomWidget.buildImageTextBtn(
                  buildIconFromIconData(Icons.trending_up, 28), "营业概况", () {
                print("1");
              }),
              CustomWidget.buildImageTextBtn(
                  buildIconFromIconData(Icons.settings, 28), "系统设置", () {
                print("2");
              }),
              CustomWidget.buildImageTextBtn(
                  buildIconFromIconData(Icons.supervisor_account, 28), "员工管理",
                  () {
                print("3");
              }),
            ],
          )
        ],
      ),
    );
  }

  // 九宫格
  Widget buildGrid() {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          buildHeaderTitleView("货品管理"),
          CustomWidget.buildLineView(2),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              CustomWidget.buildImageTextBtn(
                  buildIconFromIconData(Icons.list, 28), "列表", () {
                print("1");
              }),
              CustomWidget.buildImageTextBtn(
                  buildIconFromIconData(Icons.add_alarm, 28), "添加", () {
                print("2");
              }),
              CustomWidget.buildImageTextBtn(
                  buildIconFromIconData(Icons.category, 28), "分类", () {
                print("3");
              }),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              CustomWidget.buildImageTextBtn(
                  buildIconFromIconData(Icons.format_color_fill, 28), "规格", () {
                print("4");
              }),
              CustomWidget.buildImageTextBtn(
                  buildIconFromIconData(Icons.vibration, 28), "属性", () {
                print("5");
              }),
              CustomWidget.buildImageTextBtn(
                  buildIconFromIconData(Icons.attach_money, 28), "价格", () {
                print("6");
              }),
            ],
          )
        ],
      ),
    );
  }

  Widget buildHeaderTitleView(String text) {
    return Container(
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(15, 10, 10, 10),
        child: Text(
          text,
          style: TextStyle(color: UIData.normal_font_color, fontSize: 16),
        ));
  }

  Widget buildIconFromIconData(IconData iconData, double size) {
    return Icon(iconData, color: UIData.normal_image_color,size: size);
  }
}
