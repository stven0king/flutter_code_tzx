import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_code_tzx/config/config.dart';
import 'package:flutter_code_tzx/http/http_controller.dart';
import 'package:flutter_code_tzx/model/gank_history_list_entity.dart';
import 'package:quiver/strings.dart';
import 'package:flutter_code_tzx/model/gank_config.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}



class _MyHomePageState extends State<MyHomePage> {
  final _biggerFont = const TextStyle(fontSize:  18.0);

  @override
  Widget build(BuildContext context) {
    _getGankHistoryList();
    return new Scaffold(
      appBar: AppBar(
        title: Text('Flutter Demo')
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: pageList.length,
      itemBuilder: (context, i) {
        return _buildRow(i);
      },
    );
  }

  Widget _buildRow(int i) {
    return Column(
        children: <Widget>[
          ListTile(
            title: new Text(
              pageList[i],
              style: _biggerFont,
            ),
            onTap: (){
              Navigator.of(context).pushNamed(pageList[i]);
            },
          ),
          Divider(),
        ]
    );
  }


  void _getGankHistoryList() {
    HttpController.get(Gank.gankHistoryApi, (data) {
      if (data != null) {
        final Map<String, dynamic> body = jsonDecode(data.toString());
        GankHistoryListEntity entity = GankHistoryListEntity.fromJson(body);
        if (!entity.error) {
          GankHistoryListEntity.gankHistoryListEntity = entity;
        }
      }
    });
  }
}