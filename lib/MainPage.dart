
import 'package:flutter/material.dart';
import 'package:good_app/page/card/CardPage.dart';
import 'package:good_app/page/login/LoginPage.dart';
import 'package:good_app/utils/EventBus.dart';
import 'package:good_app/page/home/HomePage.dart';
import 'package:good_app/page/mine/MinePage.dart';
import 'package:good_app/page/order/OrderPage.dart';
import 'package:good_app/utils/UIData.dart';
import 'package:flustars/flustars.dart';
import 'dart:async' as async;

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
       return new MaterialApp(
        debugShowCheckedModeBanner: false, home: new MainPageWidget());
  }
}

class MainPageWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MainPageState();
  }
}

class MainPageState extends State<MainPageWidget> {
  int _tabIndex = 0;
  var tabImages;
  var appBarTitles = ['客户', '出货车', '订单', '我的'];
  var bus = new EventBus();
  var isLogin;

  var _pageList;
  final blueCode = Color(0xff1296db);
  final blueCode2 = Color(0xff515151);

  /*
   * 根据选择获得对应的normal或是press的icon
   */
  Icon getTabIcon(int curIndex) {
    if (curIndex == _tabIndex) {
      return tabImages[curIndex][1];
    }
    return tabImages[curIndex][0];
  }

  /*
   * 获取bottomTab的颜色和文字
   */
  Text getTabTitle(int curIndex) {
    if (curIndex == _tabIndex) {
      return new Text(appBarTitles[curIndex],
          style: new TextStyle(fontSize: 14.0, color: UIData.primary_color));
    } else {
      return new Text(appBarTitles[curIndex],
          style: new TextStyle(fontSize: 14.0, color: blueCode2));
    }
  }

  /*
   * 根据image路径获取图片
   */
  Image getTabImage(path) {
    return new Image.asset(path, width: 24.0, height: 24.0);
  }

  void initData() {
    tabImages = [
      [Icon(Icons.home), Icon(Icons.home, color: UIData.primary_color)],
      [Icon(Icons.shopping_cart),Icon(Icons.shopping_cart, color: UIData.primary_color)],
      [Icon(Icons.message), Icon(Icons.message, color: UIData.primary_color)],
      [Icon(Icons.person_pin),Icon(Icons.person_pin, color: UIData.primary_color)],
    ];

    _pageList = [
      HomePage(),
      new CardPage(),
      new OrderPage(),
      new MinePage(),
    ];
  }

  void changeTab(int index) {
    setState(() {
      _tabIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    initData();
    _initAsync();
    bus.on("login-success", (ret){
        setState(() {
          isLogin = true;
        });
    });
  }

 void _initAsync() async {
    await SpUtil.getInstance();
    delayedfresh((){
      setState(() {
        SpUtil.clear();
        isLogin = SpUtil.haveKey("userInfo");
      });
    });
 }

Future<void> delayedfresh(Function todo) {
  final async.Completer<void> completer = async.Completer<void>();
    Future.delayed(Duration(seconds: 1), () {
      completer.complete();
    });
    return completer.future.then<void>((_) {
      todo();
    });
  }
  
    @override
    Widget build(BuildContext context) {
      return isLogin == null ? Container() : Scaffold(
          body: isLogin == false ? LoginPage(): IndexedStack(
            index: _tabIndex,
            children: _pageList,
          ),
          bottomNavigationBar: isLogin == false ? null : new BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              new BottomNavigationBarItem(
                  icon: getTabIcon(0), title: getTabTitle(0)),
              new BottomNavigationBarItem(
                  icon: getTabIcon(1), title: getTabTitle(1)),
              new BottomNavigationBarItem(
                  icon: getTabIcon(2), title: getTabTitle(2)),
              new BottomNavigationBarItem(
                  icon: getTabIcon(3), title: getTabTitle(3)),
            ],
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            currentIndex: _tabIndex,
            iconSize: 24.0,
            onTap: (index) {
              var idx = index == 2 ? true : false;
              bus.emit("changeTimeLineStatus", idx);
              setState(() {
                _tabIndex = index;
              });
            },
          ));
    }
  
}
