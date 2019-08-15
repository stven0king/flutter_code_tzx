import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ViewPageWidget extends StatefulWidget {
  final List<String> adPictures;
  ViewPageWidget(this.adPictures);

  @override
  State<StatefulWidget> createState() => new _ViewPageState();
}
const timeout = const Duration(seconds: 3);
class _ViewPageState extends State<ViewPageWidget> with TickerProviderStateMixin {
  List<String> _adPictures;
  TabController _tabController;
  PageController _pageController;

  Timer _timer;
  int _index = 0;
  @override
  void initState() {
    _timer = Timer.periodic(timeout, _handleTimeout);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  int _getControllerLength() {
    return _adPictures == null ? 0 : (_adPictures.length > 2 ? _adPictures.length : 0);
  }

  @override
  Widget build(BuildContext context){
    _adPictures = widget.adPictures;
    if (_adPictures == null) {
      _adPictures = [];
    }
    _pageController = new PageController();
    _tabController = TabController(length: _getControllerLength(), vsync: this);
    return Container(
      width: double.infinity,
      height: 200,
      child: Center(
        child: Stack(
            children: <Widget>[
              Container(
                child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  onPageChanged: _onPageChanged,
                  controller: _pageController,
                  itemBuilder: (context, index) {
                    return CachedNetworkImage(
                      imageUrl: _adPictures[index % _adPictures.length],
                      fit: BoxFit.cover,
                    );
                  }),
                ),
              Align(
                alignment: Alignment.bottomCenter,
                child: new TabPageSelector(
                    color: Colors.white,
                    selectedColor: Colors.blue,
                    controller: _tabController
                ),
              ),
            ]
        ),
      ),
    );
  }

  _handleTimeout(Timer timer) {
    if (_adPictures != null && _adPictures.length > 0) {
      _index++;
      _index = _index % _adPictures.length;
      _pageController.animateToPage(
        _index,
        duration: Duration(milliseconds: 16),
        curve: Curves.fastOutSlowIn,
      );
    }
  }

  void _onPageChanged(int index) {
    _tabController.animateTo(index);
    _pageController.jumpToPage(index);
    _index = index;
  }
}