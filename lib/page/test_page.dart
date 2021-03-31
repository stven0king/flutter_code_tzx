import 'package:flutter/material.dart';
import 'package:flutter_code_tzx/plugin/file_provider.dart' as FileUtils;


class MyPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    dynamic obj = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(title: Text('Reading and Writing Files')),
      body: Center(
        child: Text("this page name is ${obj != null ? obj['name'] : 'null'}"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _click,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  void _click() {
    _getCacheDir.then((path) {
      print(path);
    });
    _externalStorage.then((path) {
      print(path);
    });
    _getFilesDir.then((path) {
      print(path);
    });
    _getExternalStoragePublicDirectory(FileUtils.DIRECTORY_DCIM).then((path) {
      print(path);
    });
  }

  Future<String> get _getCacheDir async {
    final directory = await FileUtils.getCacheDir();
    return directory.path;
  }

  Future<String> get _externalStorage async {
    final directory = await FileUtils.getExternalStorageDirectory();
    return directory.path;
  }


  Future<String> get _getFilesDir async {
    final directory = await FileUtils.getFilesDir();
    return directory.path;
  }

  Future<String> _getExternalStoragePublicDirectory(String s) async {
    final directory = await FileUtils.getExternalStoragePublicDirectory(s);
    return directory.path;
  }
}