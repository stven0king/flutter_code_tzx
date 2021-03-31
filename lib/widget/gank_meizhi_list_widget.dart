import 'dart:async';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../model/gank_config.dart';
import '../http/http_controller.dart';
import '../model/gank_item_data_entity.dart';
import '../config/config.dart';
import '../framework/toast.dart';

class GankMeiziListPage extends StatefulWidget {
  final String name;
  GankMeiziListPage(this.name);
  @override
  State<StatefulWidget> createState() {
    return new ListImagePage(name);
  }
}

class ListImagePage extends State<GankMeiziListPage> {
  BuildContext buildContext;
  final String name;
  bool _isListView = false;
  var _items = [];
  ScrollController _scrollController = ScrollController(); //listview的控制器
  ListImagePage(this.name);
  int _pageName = 1; //加载的页数
  bool isLoading = false; //是否正在加载数据
  /**
   * 页码大小
   */
  int _pageSize = 10;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        Toast.toast(context, '滑动到了最底部');
        _getMore();
      }
    });
    getData();
  }

  void getData() {
    String url = "https://gank.io/api/v2/data/category/Girl/type/Girl/page/$_pageName/count/$_pageSize";
    // String url = Gank.getGankDataModelApi(Gank.gank_data_type['meizhi'], _pageSize, _pageName);
    HttpController.get(url, (data) {
      if (data != null) {
        final Map<String, dynamic> body = jsonDecode(data.toString());
        final feeds = body["data"];
        var items = [];
        if (feeds != null) {
          feeds.forEach((item) {
            items.add(GankItemDataEntity.fromJson(item));
          });
          setState(() {
            if (items.length == 0) {
              print('到底了');
            } else {
              _items.addAll(items);
              _pageName++;
              isLoading = false;
              print(_items.length);
            }
          });
        }
      }
    });
  }

  Widget _getListItemView(BuildContext context, int index) {
    GankItemDataEntity imageBean = this._items[index];
    double topPadding = 1;
    if (index == 0) {
      topPadding = 0;
    }
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.only(top: topPadding, bottom: 1, left: 1, right: 1),
        child: Stack(//指定未定位或部分定位widget的对齐方式
          alignment: FractionalOffset.bottomRight,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: CachedNetworkImage(
                width: double.infinity,
                height: 230,
//                placeholder: CircularProgressIndicator(),
                imageUrl: imageBean.url,
                fit: BoxFit.cover,
              ),
              margin: const EdgeInsets.only(
                  top: 5,
                  bottom: 5
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: double.infinity, //宽度尽可能大
              ),
              child: Container(
                height: 32.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors:[Color(0x37BDBDBD),Color(0x37F5F5F5),Color(0x37BDBDBD)]
                  ), //背景渐变
                ),
                child: DecoratedBox(
                  decoration: BoxDecoration(color: Colors.transparent),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                imageBean.desc,
                style: TextStyle(
                    color: Colors.white
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: (){
        _onItemClick(index);
      },
    );
  }

  //单个item的点击，进入图片预览
  void _onItemClick(int index) {
    GankItemDataEntity imageBean = this._items[index];
    Navigator.of(buildContext).pushNamed(pageList[3], arguments: {'url':imageBean.url});
  }

  Icon _getFloatingActionButton() {
    return _isListView ? Icon(Icons.view_headline, size: 40,) : Icon(Icons.view_comfy, size: 40,);
  }

  @override
  Widget build(BuildContext context) {
    buildContext = context;
    return Scaffold(
      appBar: AppBar(
        leading: Text(''),
        centerTitle: true,
        title: Text('妹纸'),
      ),
      body: _getRefreshIndicator(),
      floatingActionButton: FloatingActionButton(
        child: _getFloatingActionButton(),
        onPressed: (){
          setState(() {
            _isListView = !_isListView;
          });
        },
      ),
    );
  }

  //获取下拉刷新的listview
  Widget _getRefreshIndicator() {
    return RefreshIndicator(
      child: _isListView ? _getListView() : _getGridView(),
      //下拉刷新
      onRefresh: _handleRefresh,
    );
  }

  Widget _getListView() {
    return ListView.builder(
      itemBuilder:_getListItemView,
      itemCount: _items.length,
      physics: const AlwaysScrollableScrollPhysics(),
      controller: _scrollController,
    );
  }

  Widget _getGridView() {
    return GridView.count(
      padding: EdgeInsets.only(left: 2, right: 2),
      //交叉轴之间的间距
      crossAxisSpacing: 6,
      //交叉轴上子控件的个数
      crossAxisCount: 2,
      //子控件的最大宽度，实际宽度是根据交叉轴的值进行平分，也就是说最大宽度并不一定是实际宽度，很有可能子控件的实际宽度要小于设置的最大宽度
      mainAxisSpacing: 6,
      //宽高比
      childAspectRatio: 2 / 3,
      //滚动方向
      scrollDirection: Axis.vertical,
      children: List.generate(_items.length, _getGridViewItemView),
      controller: _scrollController,
    );
  }

  Widget _getGridViewItemView(int index) {
    GankItemDataEntity imageBean = this._items[index];
    return GestureDetector(
      child: Stack(//指定未定位或部分定位widget的对齐方式
        alignment: FractionalOffset.bottomRight,
        children: <Widget>[
          CachedNetworkImage(
            width: double.infinity,
            height: double.infinity,
//          placeholder: CircularProgressIndicator(),
            imageUrl: imageBean.url,
            fit: BoxFit.fitHeight,
          ),
          ConstrainedBox(
//            bottom: 5,
            constraints: BoxConstraints(
              minWidth: double.infinity, //宽度尽可能大
            ),
            child: Container(
              height: 32.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors:[Color(0x37BDBDBD),Color(0x37F5F5F5),Color(0x37BDBDBD)]
                ), //背景渐变
              ),
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.transparent),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              imageBean.desc,
              style: TextStyle(
                  color: Colors.white
              ),
            ),
          ),
        ],
      ),
      onTap: (){
        _onItemClick(index);
      },
    );
  }

  //下拉刷新
  Future<Null> _handleRefresh() {
    print('_handleRefresh');
    return Future.delayed(Duration(seconds: 3), (){
      isLoading = true;
      _pageName = 1;
      getData();
    });
  }

  //上拉加载更多
  void _getMore() {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      getData();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }
}