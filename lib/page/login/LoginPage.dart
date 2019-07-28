import 'dart:async';

import 'package:flutter/material.dart';
import 'package:good_app/MainPage.dart';
import 'package:good_app/api/corp/corp.dart';
import 'package:good_app/compoent/CustomWidget.dart';
import 'package:good_app/compoent/FInputWidget.dart';
import 'package:good_app/compoent/Toast.dart';
import 'package:good_app/page/login/RegisterPage.dart';
import 'package:good_app/utils/EventBus.dart';
import 'package:good_app/utils/SpUtil.dart';
// import 'package:good_app/api/user.dart';
// import 'package:good_app/componets/CustomAppBar.dart';
// import 'package:good_app/componets/FInputWidget.dart';
// import 'package:good_app/page/common/EventBus.dart';
// import 'package:good_app/page/login/ForgetPWDPage.dart';
// import 'package:good_app/utils/MD5Utils.dart';
// import 'package:good_app/utils/NavigatorUtils.dart';
import 'package:good_app/utils/UIData.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  var leftRightPadding = 20.0;
  var topBottomPadding = 4.0;
  var textTips = new TextStyle(fontSize: 16.0, color: Colors.black);
  var hintTips = new TextStyle(fontSize: 15.0, color: Colors.black26);
  bool isLoading = false;
  var _phoneController = new TextEditingController();
  var _pwdController = new TextEditingController();
  var bus = new EventBus();

  @override
  void initState() {
    super.initState();
    _initAsync();
  }

  void _initAsync() async {
    await SpUtil.getInstance();
 }

  @override
  Widget build(BuildContext context) {
    print(SpUtil.isInitialized());
    return Scaffold(
      appBar: CustomWidget.buildAppBar("登录", context),
      body: new Container(
        child: new Container(
          padding: EdgeInsets.only(top: 60),
          child: SafeArea(
            child: SingleChildScrollView(
              child: new Padding(
                padding: new EdgeInsets.only(
                    left: 30.0, top: 10.0, right: 30.0, bottom: 0.0),
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    CustomWidget.buildLogImage(null),
                    new Padding(padding: new EdgeInsets.all(30.0)),
                    new FInputWidget(
                      hintText: "请输入手机号",
                      isNumber: true,
                      iconData: Icons.phone_iphone,
                      onChanged: (String value) {
                        print(value);
                      },
                      controller: _phoneController,
                    ),
                    new Padding(padding: new EdgeInsets.all(10.0)),
                    new FInputWidget(
                      hintText: "请输入密码",
                      iconData: Icons.security,
                      obscureText: true,
                      onChanged: (String value) {
                        print(value);
                      },
                      controller: _pwdController,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => new MainPage()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 40, top: 16),
                            child: Text(
                              "忘记密码?",
                              textAlign: TextAlign.left,
                              style: TextStyle(color: UIData.primary_color),
                            ),
                          )
                        ],
                      ),
                    ),
                    new Padding(padding: new EdgeInsets.all(20.0)),
                    _buildLoginBtn(),
                    new Container(
                      margin: EdgeInsets.only(top: 16.0),
                      child: new Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new GestureDetector(
                            child: new Text(
                              "马上注册新企业",
                              style: TextStyle(color: UIData.normal_font_color),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) =>
                                          new RegisterPage()));
                            },
                          )
                        ],
                      ),
                    ),
                    new Padding(padding: new EdgeInsets.all(30.0)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginBtn() {
    return isLoading
        ? Container(
            margin: EdgeInsets.only(top: 18),
            width: 40.0,
            height: 40.0,
            alignment: FractionalOffset.center,
            padding: EdgeInsets.all(10),
            decoration: new BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    Color(0xff25D1D1),
                    Color(0xff3BE6AD),
                    Color(0xff20DDAA)
                  ],
                ),
                borderRadius:
                    new BorderRadius.all(const Radius.circular(20.0))),
            child: new CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          )
        : ButtonTheme(
            minWidth: 300,
            height: 40,
            child: RaisedButton(
              onPressed: () {
                var phone = _phoneController.text.trim();
                var pwd = _pwdController.text.trim();
                if (phone.length != 11) {
                  ShowToast("手机号码格式不对");
                  return;
                }
                if (pwd.length == 0) {
                  ShowToast("密码不能为空");
                  return;
                }
                setState(() {
                  isLoading = true;
                });
                var loginReq = {"password": pwd, "telephone": phone};
                accountLogin(loginReq).then((res) {
                  setState(() {
                    isLoading = false;
                  });
                  if (res["code"] == 0) {
                     var userInfo = res["data"].toString();
                      SpUtil.putObject("userInfo", userInfo).then((val){
                          print(val);
                          if (val) {
                            ShowToast("登录成功");
                            scheduleMicrotask((){
                                bus.emit("login-success");
                            });
                          }
                      }).catchError((err){
                        print(err);
                      }); 
                   
                  } else {
                    ShowToast(res["msg"]);
                  }
                }).catchError((err) {
                  setState(() {
                    isLoading = false;
                  });
                });
              },
              textColor: Colors.white,
              clipBehavior: Clip.hardEdge,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6.0))),
              padding: const EdgeInsets.all(0.0),
              child: Container(
                width: 300,
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
                child: const Center(child: Text('登 录')),
              ),
            ),
          );
  }
}
