import 'package:flutter/material.dart';
import 'package:good_app/utils/UIData.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flustars/flustars.dart';

class CustomWidget {
  // BuildAppBar 构建导航栏
  static AppBar buildAppBar(String title, BuildContext context) {
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
  static Widget buildLoadMoreView() {
    Widget bottomWidget =
        new Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      new SpinKitThreeBounce(
        color: UIData.refresh_color,
        size: 20,
      ),
      // new Container(
      //   width: 5.0,
      // ),
    ]);
    return new Padding(
      padding: const EdgeInsets.all(5.0),
      child: new Center(
        child: bottomWidget,
      ),
    );
  }

  static Container buildLogImage(String url) {
    var avatar = url == null
        ? "https://appicon.pgyer.com/image/view/app_icons/2b2c39138d11d60dc24374e77043ac59/120"
        : url;
    return Container(
      width: 80.0,
      height: 80.0,
      decoration: new BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        image: new DecorationImage(
            image: new NetworkImage(avatar), fit: BoxFit.cover),
        border: new Border.all(
          color: Colors.white,
          width: 2.0,
        ),
      ),
    );
  }

  // 构建横线的试图
  static Widget buildLineView(double height) {
    return Container(
      height: height > 0 ? height : 2,
      color: UIData.normal_line_color,
    );
  }

  // 构建加载试图
  static Widget buildLoadingView() {
    return new Center(
      child: CircularProgressIndicator(
        backgroundColor: UIData.refresh_color,
      ),
    );
  }

  // 构建图片在上文字在下的控件
  static Widget buildImageTextBtn(Widget image, String title, Function onTap) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            image,
            Padding(
              padding: EdgeInsets.only(top: 6),
            ),
            Text(
              title,
              style: TextStyle(color: UIData.normal_font_color, fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}

 