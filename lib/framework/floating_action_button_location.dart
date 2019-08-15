import 'package:flutter/material.dart';

class CustomerFloatingActionButtonLocation extends FloatingActionButtonLocation {
  final bool isCenter;
  final double left;
  final double bottom;
  final double top;
  final double right;
  final double dx;
  final double dy;
  const CustomerFloatingActionButtonLocation.bottomCenter(double padding):
        dx = 0,
        dy = 0,
        bottom = padding,
        left = 0,
        right = 0,
        top = 0,
        isCenter = true;


  const CustomerFloatingActionButtonLocation.topCenter(double padding):
        dx = 0,
        dy = 0,
        top = padding,
        left = 0,
        right = 0,
        bottom = 0,
        isCenter = true;

  const CustomerFloatingActionButtonLocation.leftCenter(double padding):
        dx = 0,
        dy = 0,
        left = padding,
        bottom = 0,
        right = 0,
        top = 0,
        isCenter = true;

  const CustomerFloatingActionButtonLocation.rightCenter(double padding):
        dx = 0,
        dy = 0,
        right = padding,
        left = 0,
        bottom = 0,
        top = 0,
        isCenter = true;

  const CustomerFloatingActionButtonLocation(double dx, double dy):
        isCenter = false,
        dx = dx,
        dy = dy,
        right = 0,
        left = 0,
        bottom = 0,
        top = 0;


  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    double fabY;
    double fabX;
    if (isCenter) {
      assert(() {
        if (bottom <= 0 && top <= 0 && left <= 0 && right <= 0) {
          throw FlutterError('padding must greater than zero');
        }
        return true;
      }());
      if (left > 0) {
        fabY = (scaffoldGeometry.scaffoldSize.height - scaffoldGeometry.floatingActionButtonSize.height) / 2.0;
        fabX = left;
      } else if (right > 0) {
        fabY = (scaffoldGeometry.scaffoldSize.height - scaffoldGeometry.floatingActionButtonSize.height) / 2.0;
        fabX = scaffoldGeometry.scaffoldSize.width - right - scaffoldGeometry.floatingActionButtonSize.width;
      } else if (bottom > 0) {
        fabX = (scaffoldGeometry.scaffoldSize.width - scaffoldGeometry.floatingActionButtonSize.width) / 2.0;
        fabY = scaffoldGeometry.scaffoldSize.height - bottom - scaffoldGeometry.floatingActionButtonSize.height;
      } else {
        fabX = (scaffoldGeometry.scaffoldSize.width - scaffoldGeometry.floatingActionButtonSize.width) / 2.0;
        fabY = top;
      }
    } else {
      if (dx >= 0) {
        fabX = dx;
      } else {
        fabX = scaffoldGeometry.scaffoldSize.width + dx - scaffoldGeometry.floatingActionButtonSize.width;
      }
      if (dy >= 0) {
        fabY = dy;
      } else {
        fabY = scaffoldGeometry.scaffoldSize.height + dy - scaffoldGeometry.floatingActionButtonSize.height;
      }
    }
    return Offset(fabX, fabY);
  }

  @override
  String toString() => 'CustomerFloatingActionButtonLocation';
}
