import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_code_tzx/model/gank_config.dart';
import 'package:flutter_code_tzx/model/gank_item_data_entity.dart';
import 'package:flutter_code_tzx/model/gank_today_data_entity.dart';
import 'package:flutter_code_tzx/widget/view_page.dart';
import 'package:quiver/strings.dart';

class GankOneDayPage extends StatefulWidget {
  final GankTodayDataEntiryEntity _currentData;
  List<String> _bannerData;
  GankOneDayPage(this._currentData, this._bannerData);
  @override
  State<StatefulWidget> createState() {
    return new GankOneDayPageState();
  }
}


class GankOneDayPageState extends State<GankOneDayPage> {
  GankTodayDataEntiryEntity _currentData;
  List<Object> _listData;
  BuildContext context;
  List<String> _bannerData;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    this.context = context;
    _getListCount();
    print('GankOneDayPageState_build');
    return _getListWidget();
  }

  Widget _getViewPage() {
    List<String> data = _getMeizhiUrls();
    if (data == null || data.isEmpty) {
      return null;
    }
    return ViewPageWidget(data);
  }


  Widget _getListWidget() {
    return ListView.builder(
      itemBuilder:_getListItemWidget,
      itemCount: _listData == null ? 1 : _listData.length + 1,
    );
  }

  Widget _getListItemWidget(BuildContext context, int index) {
    int targetIndex = index;
    if (_getViewPage() != null) {
      if(index == 0) {
        return _getViewPage();
      }
      targetIndex = index - 1;
    } else {
      if(targetIndex >= _listData.length) {
        return null;
      }
    }
    Object object = _listData[targetIndex];
    if (object is String) {
      return _getItemTitleWidget(object);
    } else {
      return _getItemBodyWidget(object);
    }
  }

  Widget _getItemTitleWidget(String title) {
    return Container(
      height: 30,
      alignment: Alignment.centerLeft,
      color: Colors.blue,
      child: Padding(
        padding: EdgeInsets.only(left: 10),
        child: Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }

  Widget _getItemBodyWidget(GankItemDataEntity e) {
    String imageUrl = "null";
    if (e.images != null && e.images.length > 0) {
      imageUrl = e.images[0];
    }
    if (isEmpty(imageUrl)) {
      print('desc=' + e.desc.trim());
      return Container(
        height: 80,
        child: Column(
          textBaseline: TextBaseline.alphabetic,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textDirection: TextDirection.ltr,
          children: <Widget>[
            Container(
              height: 0.5,
              color: Colors.grey[300],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 6, top: 8, bottom: 8, right: 6),
              child: Container(
                height: 40,
                child: Text(
                  e.desc.trim(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 6, ),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 2),
                    child: Icon(
                      Icons.perm_identity,
                      color: Colors.blue,
                      size: 16,
                    ),
                  ),
                  Text(
                    e.who,
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  )
                ],
              ),
            )
          ],
        ),
      );
    } else {
      MediaQueryData mediaQuery = MediaQuery.of(context);
      return Column(
        textDirection: TextDirection.ltr,
        children: <Widget>[
          Container(
            height: 0.5,
            color: Colors.grey[300],
          ),
          Row(
            textDirection: TextDirection.rtl,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CachedNetworkImage(
                  height: 90,
                  width: 90,
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                textDirection: TextDirection.ltr,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 6, bottom: 10, top: 8,),
                    child: Container(
                      width: mediaQuery.size.width - 115,
                      height: 60,
                      child: Text(
                        e.desc.trim(),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 6),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 2),
                          child: Icon(
                            Icons.perm_identity,
                            color: Colors.blue,
                            size: 16,
                          ),
                        ),
                        Text(
                          e.who,
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      );
    }
  }

  List<String> _getMeizhiUrls() {
    if(_bannerData == null) {
      _bannerData = [];
    }
    return _bannerData;
  }

  void _getListCount() {
    _currentData = widget._currentData;
    _bannerData = widget._bannerData;
    _listData = [];
    if (_currentData == null || _currentData.error || _currentData.results == null) {
      Gank.gank_data_type.forEach((k, v){
        if (k != 'meizhi') {
          _listData.add(v);
        }
      });
      print('_getListCount:' + '_currentData is null');
    } else {
      if (_currentData.results.android != null) {
        _listData.add(Gank.gank_data_type['android']);
        _currentData.results.android.forEach((d){_listData.add(d);});
      }
      if (_currentData.results.ios != null) {
        _listData.add(Gank.gank_data_type['ios']);
        _currentData.results.ios.forEach((d){_listData.add(d);});
      }
      if (_currentData.results.source != null) {
        _listData.add(Gank.gank_data_type['source']);
        _currentData.results.source.forEach((d){_listData.add(d);});
      }
      if (_currentData.results.app != null) {
        _listData.add(Gank.gank_data_type['app']);
        _currentData.results.app.forEach((d){_listData.add(d);});
      }
      if (_currentData.results.fe != null) {
        _listData.add(Gank.gank_data_type['fe']);
        _currentData.results.fe.forEach((d){_listData.add(d);});
      }
      if (_currentData.results.recommend != null) {
        _listData.add(Gank.gank_data_type['recommend']);
        _currentData.results.recommend.forEach((d){_listData.add(d);});
      }
      if (_currentData.results.video != null) {
        _listData.add(Gank.gank_data_type['recommend']);
        _currentData.results.video.forEach((d){_listData.add(d);});
      }
    }
    print('_getListCount:' + _listData.length.toString());
  }


}