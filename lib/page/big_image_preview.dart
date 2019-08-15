import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_code_tzx/widget/darg_scale_widget.dart';
import 'package:quiver/strings.dart';
import '../framework/floating_action_button_location.dart';
import '../framework/toast.dart';

class BigImagePreView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BigImagePreViewState();
  }

}
class BigImagePreViewState extends State<BigImagePreView> {
  String url;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    dynamic obj = ModalRoute.of(context).settings.arguments;
    if (obj != null) {
      url = obj['url'].toString();
      print(url);
    }
//    assert(isEmpty(url), 'url is empty');
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: DragScaleContainer(
          doubleTapStillScale: true,
          maxScale: 3,
          child: CachedNetworkImage(
            width: double.infinity,
            height: double.infinity,
//          placeholder: CircularProgressIndicator(),
            imageUrl: url,
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
      floatingActionButtonLocation: CustomerFloatingActionButtonLocation(-20, -40),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save, size: 40,),
        onPressed: (){
          Toast.toast(context, 'save');
        },
      ),
    );
  }
}