import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_code_tzx/framework/toast.dart';
import 'package:flutter_code_tzx/http/http_controller.dart';

import '../config/config.dart';
import '../model/gank_item_data_entity.dart';
import '../model/gank_today_data_entity.dart';

class GankHistoryListPage extends StatefulWidget {
  final String name;

  GankHistoryListPage(this.name);

  @override
  State<StatefulWidget> createState() {
    return new GankHistoryListState(name);
  }
}

class GankHistoryListState extends State<GankHistoryListPage> {
  final String name;
  GankHistoryListState(this.name);
  BuildContext context;
  var _items = [];
  ScrollController _scrollController = ScrollController(); //listview的控制器
  int _listIndex = 1; //加载的页数
  bool isLoading = false; //是否正在加载数据
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

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      appBar: AppBar(
        leading: Text(''),
        centerTitle: true,
        title: Text('历史'),
      ),
      body: _getHistoryListWidget(),
    );
  }
  

  Widget _getHistoryListWidget() {
    return ListView.builder(
      itemBuilder:_getHistoryListItemWidget,
      itemCount: _items.length,
      physics: const AlwaysScrollableScrollPhysics(),
      controller: _scrollController,
    );
  }


  Widget _getHistoryListItemWidget(BuildContext context, int index) {
    GankItemDataEntity itemBean = this._items[index];
    double topPadding = 6;
    if (index == 0) {
      topPadding = 0;
    }
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.only(top: topPadding, bottom: 1, left: 6, right: 6),
        child: Stack(//指定未定位或部分定位widget的对齐方式
          alignment: FractionalOffset.centerLeft,
          children: <Widget>[
            Material(
              child: CachedNetworkImage(
                width: double.infinity,
                height: 200,
                imageUrl: itemBean.images[0],
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(10.0),
              clipBehavior: Clip.antiAlias,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12, bottom: 30),
              child: Text(
                itemBean.desc,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12, top: 55),
              child: Text(
                _getTitle(itemBean),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 23,
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

  String _getTitle(GankItemDataEntity itemBean) {
    String result = "";
    if (itemBean != null) {
      result = itemBean.who;
    }
    return result;
  }


  //单个item的点击，进入图片预览
  void _onItemClick(int index) {
    GankTodayDataEntiryEntity itemBean = this._items[index];
    Navigator.of(this.context)
        .pushNamed(
          pageList[4],
          arguments: {
            'time': itemBean.results.meizhi[0].desc,
            'data': itemBean,
          });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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

  //获取数据
  void getData() {
    String url = "https://gank.io/api/v2/data/category/Girl/type/Girl/page/$_listIndex/count/$_pageSize";
    // String url = Gank.getGankDataModelApi(Gank.gank_data_type['meizhi'], _pageSize, _pageName);
    print("tanzhenxing:url=" + url);
    HttpController.get(url, (data) {
      if (data != null) {
        print("tanzhenxing:" + data.toString());
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
              _listIndex++;
              isLoading = false;
            }
          });
        }
      }
    });
  }
}