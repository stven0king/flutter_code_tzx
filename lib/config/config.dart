import 'package:flutter/material.dart';
import 'package:flutter_code_tzx/page/big_image_preview.dart';
import 'package:flutter_code_tzx/page/bottom_navigation_page.dart';
import 'package:flutter_code_tzx/page/main_page.dart';
import 'package:flutter_code_tzx/page/test_page.dart';
import 'package:flutter_code_tzx/page/gank_oneday_page.dart';

const pageList = [
  '/testpage',
  '/router',
  '/bottom_Navigation',
  '/big_image_preview',
  '/gank_oneday_detail'
];

Map<String, WidgetBuilder> routers = {
  pageList[0]: (_) => Page(),
  pageList[1]: (BuildContext buildContext) => new MyHomePage(),
  pageList[2]: (BuildContext buildContext) => new BottomNavigationWidget(),
  pageList[3]: (_) => BigImagePreView(),
  pageList[4]: (_) => GankOndDayDetailPage(),
};