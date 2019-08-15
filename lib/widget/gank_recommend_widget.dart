import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_code_tzx/http/http_controller.dart';
import 'package:flutter_code_tzx/model/gank_config.dart';
import 'package:flutter_code_tzx/model/gank_today_data_entity.dart';
import 'package:flutter_code_tzx/widget/gank_oneday_widget.dart';

class GankRecommendPage extends StatefulWidget {
  final String name;
  GankRecommendPage(this.name);
  @override
  State<StatefulWidget> createState() {
    return new GankRecommendPageState(name);
  }
}


class GankRecommendPageState extends State<GankRecommendPage> {
  final String name;
  GankRecommendPageState(this.name);
  GankTodayDataEntiryEntity _currentData;
  BuildContext context;
  @override
  void initState() {
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    this.context = context;
    return Scaffold(
      appBar: AppBar(
        leading: Text(''),
        centerTitle: true,
        title: Text('今日'),
      ),
      body: GankOneDayPage(_currentData),
    );
  }

  //获取数据
  void getData() {
    String url = Gank.today_url;
    print('GankOneDayPageState:' + url);
    HttpController.get(url, (data) {
      if (data != null) {
        final Map<String, dynamic> body = jsonDecode(data.toString());
        GankTodayDataEntiryEntity entity = GankTodayDataEntiryEntity.fromJson(body);
        setState(() {
          _currentData = entity;
        });
      }
    });
  }
}