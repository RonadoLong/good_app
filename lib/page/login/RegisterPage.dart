import 'dart:async';

import 'package:flutter/material.dart';
import 'package:good_app/api/corp/corp.dart';
import 'package:good_app/compoent/CustomWidget.dart';
import 'package:good_app/compoent/FInputWidget.dart';
import 'package:good_app/compoent/Toast.dart';
import 'package:good_app/utils/EventBus.dart';
import 'package:good_app/utils/SpUtil.dart';
import 'package:good_app/utils/UIData.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _RegisterPageState();
  }
}

class _RegisterPageState extends State<RegisterPage> {
  var leftRightPadding = 20.0;
  var topBottomPadding = 4.0;
  var textTips = new TextStyle(fontSize: 13.0, color: Colors.black);
  var hintTips = new TextStyle(fontSize: 13.0, color: Colors.blueGrey);
  bool isLogin = false;
  bool loading = false;
  var bus = new EventBus();

  var _companyController = new TextEditingController();
  var _phoneController = new TextEditingController();
  var _pwdController = new TextEditingController();
  var _againPwdController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomWidget.buildAppBar("注册新企业", context),
      body: new Container(
        padding: EdgeInsets.only(top: 50),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 20.0, right: 25.0, bottom: 0.0),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  CustomWidget.buildLogImage(null),
                  new Padding(padding: new EdgeInsets.only(top: 30.0)),
                  new FInputWidget(
                    hintText: "请输入企业名称",
                    isNumber: true,
                    iconData: Icons.business,
                    onChanged: (String value) {
                      print(value);
                    },
                    controller: _companyController,
                  ),
                  new Padding(padding: new EdgeInsets.all(4.0)),
                  new FInputWidget(
                    hintText: "请输入手机号码",
                    iconData: Icons.phone_iphone,
                    onChanged: (String value) {
                      var ret = value.length >= 11 ? true : false;
                    },
                    controller: _phoneController,
                  ),
                  new Padding(padding: new EdgeInsets.all(4.0)),
                  new FInputWidget(
                    hintText: "请输入密码",
                    iconData: Icons.lock,
                    obscureText: true,
                    onChanged: (String value) {
                      print(value);
                    },
                    controller: _pwdController,
                  ),
                  new Padding(padding: new EdgeInsets.all(4.0)),
                  new FInputWidget(
                    hintText: "请再次输入密码",
                    iconData: Icons.lock,
                    obscureText: true,
                    onChanged: (String value) {
                      print(value);
                    },
                    controller: _againPwdController,
                  ),
                  new Padding(padding: new EdgeInsets.only(top: 40)),
                  _buildLogin(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogin() {
    return loading == false
        ? ButtonTheme(
            minWidth: 300,
            height: 40,
            child: RaisedButton(
              onPressed: () {
                var company = _companyController.text.trim();
                var phone = _phoneController.text.trim();
                var pwd = _pwdController.text.trim();
                var againPwd = _againPwdController.text.trim();
                if (company.length == 0 ||
                    pwd.length == 0 ||
                    againPwd.length == 0) {
                  ShowToast("请完善信息");
                  return;
                }

                if (phone.length != 11) {
                  ShowToast("错误的手机号码格式");
                  return;
                }

                if (pwd != againPwd) {
                  ShowToast("输入的两次密码不匹配");
                  return;
                }

                var registerCorpReq = {
                  "corpName": company,
                  "password": pwd,
                  "telephone": phone
                };

                setState(() {
                  loading = true;
                });

                corpRegister(registerCorpReq).then((res) {
                  setState(() {
                    loading = false;
                  });
                  if (res["code"] == 0 && res["data"] != null) {
                    Navigator.of(context).pop("");
                  }
                }).catchError((err) {
                  setState(() {
                    loading = false;
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
                child: const Center(child: Text('注 册')),
              ),
            ),
          )
        : Container(
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
          );
  }
}
