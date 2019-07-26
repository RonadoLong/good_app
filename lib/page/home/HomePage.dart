import 'dart:async';

import 'package:flutter/material.dart';
import 'package:good_app/compoent/CustomWidget.dart';
import 'package:good_app/page/home/model/Consumer.dart';
import 'package:good_app/page/home/view/HomeCell.dart';
import 'package:good_app/utils/UIData.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  @protected
  final ScrollController _scrollController = new ScrollController();

  @protected
  List<Consumer> contents = [];

  @override
  void initState() {
    _loadData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print("load more");
      }
    });
    super.initState();
  }

  void _loadData() {
    setState(() {
      contents = MockContents();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("客户", style: new TextStyle(color: Colors.white)),
        centerTitle: true,
        elevation: 0,
        iconTheme: new IconThemeData(color: Colors.white),
        backgroundColor: UIData.primary_color,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add_circle),
            onPressed: () {
              print("alert");
            },
          )
        ],
      ),
      body: _createBody(context),
    );
  }

  Widget _createBody(BuildContext context) {
    if (contents == null) {
      return CustomWidget.buildLoadingView();
    }
    if (contents.length == 0 || contents.isEmpty) {
      return new Center(
        child: CustomWidget.buildEmptyView(),
      );
    }
    return _buildContent();
  }

  Widget _buildContent() {
    return new RefreshIndicator(
        onRefresh: (() => _handleRefresh()),
        color: UIData.refresh_color, //刷新控件的颜色
        child: ListView.separated(
          itemCount:
              contents.length >= 10 ? contents.length + 1 : contents.length,
          controller: _scrollController, //用于监听是否滑到最底部
          itemBuilder: (context, index) {
            if (index < contents.length) {
              Consumer consumer = contents[index];
              return GestureDetector(
                onTap: () {
                  print(consumer.id);
                },
                child: createCell(consumer),
              );
            } else {
              return CustomWidget.buildLoadMoreView(); //展示加载loading框
            }
          },
          physics: const AlwaysScrollableScrollPhysics(),
          separatorBuilder: (context, idx) {
            return Container(
              height: 2,
              color: Color.fromARGB(50, 183, 187, 197),
            );
          },
        )
    );
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
  bool get wantKeepAlive => true;
}
