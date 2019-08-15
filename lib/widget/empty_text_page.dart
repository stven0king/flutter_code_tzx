import 'package:flutter/material.dart';
import 'package:quiver/strings.dart';

class EmptyTextPage extends StatefulWidget {
  final String name;

  EmptyTextPage(this.name);

  @override
  State<StatefulWidget> createState() {
    return EmptyTextPageState(name);
  }

}

class EmptyTextPageState extends State<EmptyTextPage> {
  final String name;

  EmptyTextPageState(this.name);


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(isNotEmpty(this.name) ? name : 'Empty')
      ),
      body: new Center(
        child: new Text(
          isNotEmpty(this.name) ? name : 'Empty',
          style: TextStyle(fontSize:  32.0),
        ),
      ),
    );
  }


}