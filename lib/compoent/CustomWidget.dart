import 'package:flutter/material.dart';
import 'package:good_app/utils/UIData.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomWidget {
  // BuildAppBar 构建导航栏
  static AppBar BuildAppBar(String title, BuildContext context) {
    return new AppBar(
      title: new Text(title, style: new TextStyle(color: Colors.white)),
      centerTitle: true,
      elevation: 0,
      iconTheme: new IconThemeData(color: Colors.white),
      backgroundColor: UIData.primary_color,
    );
  }

  // 创建占位图
  static Widget buildEmptyView() {
    return Container(
      height: 160,
      width: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.network_check,
            size: 50,
            color: UIData.refresh_color,
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
          ),
          Text(
            "没有更多数据",
            style: TextStyle(fontSize: 16, color: UIData.normal_font_color),
          )
        ],
      ),
    );
  }

  ///上拉加载更多
  static Widget BuildLoadMoreView() {
    Widget bottomWidget =
        new Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      new SpinKitThreeBounce(color: Color(0xFF24292E)),
      new Container(
        width: 5.0,
      ),
    ]);
    return new Padding(
      padding: const EdgeInsets.all(5.0),
      child: new Center(
        child: bottomWidget,
      ),
    );
  }

  static Container BuildLogImage(String url) {
    var avatar = url == null
        ? "http://gp.axinmama.com/public/static/home/img/moblie/default-user-img5.png"
        : url;
    return Container(
      width: 80.0,
      height: 80.0,
      decoration: new BoxDecoration(
        shape: BoxShape.circle,
        color: UIData.primary_color,
        image: new DecorationImage(
            image: new NetworkImage(avatar), fit: BoxFit.cover),
        border: new Border.all(
          color: UIData.primary_color,
          width: 2.0,
        ),
      ),
    );
  }

  static Widget BuildLineView(double height) { 
    return Container(
      height: height >= 0 ? 2 : height,
      color: Color.fromARGB(50, 183, 187, 197),
    );
  }
}
