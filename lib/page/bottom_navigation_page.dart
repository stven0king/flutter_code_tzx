import 'package:flutter/material.dart';
import 'package:flutter_code_tzx/widget/gank_history_list_widget.dart';
import 'package:flutter_code_tzx/widget/gank_meizhi_list_widget.dart';
import 'package:flutter_code_tzx/widget/gank_recommend_widget.dart';

class BottomNavigationWidget extends StatefulWidget {
  final String name;
  BottomNavigationWidget({this.name});

  @override
  State<StatefulWidget> createState() => BottomNavigationWidgetState(this.name);
}

class TabRes {
  final String title;
  final Widget iconData;
  const TabRes({this.title, this.iconData});
}

const tabRes = [
  const TabRes(title: "妹纸", iconData: Icon(Icons.people, color: _bottomNavigationColor)),
  const TabRes(title: "推荐", iconData: Icon(Icons.home, color: _bottomNavigationColor)),
  const TabRes(title: "历史", iconData: Icon(Icons.pages, color: _bottomNavigationColor)),
];

const _bottomNavigationColor = Colors.blue;

class BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  final String name;

  BottomNavigationWidgetState(this.name);

  int _currentIndex = 0;
  List<Widget> list = List();

  @override
  void initState() {
    list
      ..add(new GankMeiziListPage(tabRes[0].title))
      ..add(new GankRecommendPage(tabRes[1].title))
      ..add(new GankHistoryListPage(tabRes[2].title));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _build(context);
  }

  Widget _build(BuildContext context) {
    return Scaffold(
      //indexedStack 保证了State的状态不丢失
      body: IndexedStack(
        index: _currentIndex,
        children: list,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: tabRes[0].iconData,
              title: Text(
                tabRes[0].title,
                style: TextStyle(color: _bottomNavigationColor),
              )),
          BottomNavigationBarItem(
              icon: tabRes[1].iconData,
              title: Text(
                tabRes[1].title,
                style: TextStyle(color: _bottomNavigationColor),
              )),
          BottomNavigationBarItem(
              icon: tabRes[2].iconData,
              title: Text(
                tabRes[2].title,
                style: TextStyle(color: _bottomNavigationColor),
              )),
        ],
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            print('tzx ontabClick:' + index.toString());
            _currentIndex = index;
          });
        },
      ),
    );
  }
}