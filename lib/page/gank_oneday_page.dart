import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_code_tzx/http/http_controller.dart';
import 'package:flutter_code_tzx/model/gank_config.dart';
import 'package:flutter_code_tzx/model/gank_today_data_entity.dart';
import 'package:flutter_code_tzx/widget/gank_oneday_widget.dart';

class GankOndDayDetailPage extends StatefulWidget {
  GankOndDayDetailPage();
  @override
  State<StatefulWidget> createState() {
    return new GankOndDayDetailPageState();
  }
}


class GankOndDayDetailPageState extends State<GankOndDayDetailPage> {
  GankTodayDataEntiryEntity _currentData;
  BuildContext context;
  String time;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    this.context = context;
    dynamic obj = ModalRoute.of(context).settings.arguments;
    time = obj['time'];
    _currentData = obj['data'];
    return Scaffold(
      appBar: AppBar(
        title: Text(time),
      ),
      body: GankOneDayPage(_currentData),
    );
  }
}