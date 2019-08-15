import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../framework/gesture_scale.dart' as sc;
import '../framework/gestures_multitap.dart' as mu;

class DragScaleContainer extends StatefulWidget {
  Widget child;
  /// 双击内容是否一致放大，默认是true，也就是一致放大
  /// 如果为false，第一次双击放大两倍，再次双击恢复原本大小
  bool doubleTapStillScale;
  double maxScale;
  DragScaleContainer(
      {
        Widget child,
        bool doubleTapStillScale = true,
        double maxScale = double.infinity
      })
      : this.child = child,
        this.maxScale = maxScale,
        this.doubleTapStillScale = doubleTapStillScale;
  @override
  State<StatefulWidget> createState() {
    return _DragScaleContainerState();
  }
}

class _DragScaleContainerState extends State<DragScaleContainer> {
  @override
  Widget build(BuildContext context) {
    //矩形裁剪
    return ClipRect(
      child: TouchableContainer(
        doubleTapStillScale: widget.doubleTapStillScale,
        child: widget.child,
        maxScale: widget.maxScale,
      ),
    );
  }
}


class TouchableContainer extends StatefulWidget {
  final Widget child;
  final EdgeInsets margin;
  final bool doubleTapStillScale;
  final double maxScale;
  TouchableContainer(
      {this.child,
        EdgeInsets margin,
        this.doubleTapStillScale,
        this.maxScale})
      : this.margin = margin ?? EdgeInsets.all(0);
  _TouchableContainerState createState() => _TouchableContainerState();
}

class _TouchableContainerState extends State<TouchableContainer>
    with SingleTickerProviderStateMixin {
  double _kMinFlingVelocity = 800.0;
  AnimationController _controller;
  Animation<Offset> _flingAnimation;
  Offset _offset = Offset.zero;
  double _scale = 1.0;
  Offset _normalizedOffset;
  double _previousScale;
  Offset doubleDownPositon;
  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(vsync: this)
      ..addListener(_handleFlingAnimation);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // The maximum offset value is 0,0. If the size of this renderer's box is w,h
  // then the minimum offset value is w - _scale * w, h - _scale * h.
  //也就是最小值是原点0，0，点从最大值到0的区间，也就是这个图可以从最大值移动到原点
  Offset _clampOffset(Offset offset) {
    final Size size = context.size; //容器的大小
    final Offset minOffset = new Offset(size.width, size.height) * (1.0 - _scale);
    return new Offset(offset.dx.clamp(minOffset.dx, 0.0), offset.dy.clamp(minOffset.dy, 0.0));
  }

  void _handleFlingAnimation() {
    setState(() {
      _offset = _flingAnimation.value;
    });
  }

  void _handleOnScaleStart(ScaleStartDetails details) {
    setState(() {
      _previousScale = _scale;
      _normalizedOffset = (details.focalPoint - _offset) / _scale;
      _controller.stop();
    });
  }

  void _handleOnScaleUpdate(sc.ScaleUpdateDetails details) {
    print('_handleOnScaleUpdate' + (_previousScale * details.scale).toString());
    setState(() {
      _scale = (_previousScale * details.scale).clamp(1.0, widget.maxScale);
      _offset = _clampOffset(details.focalPoint - _normalizedOffset * _scale);
    });
  }

  void _handleOnScaleEnd(sc.ScaleEndDetails details) {
    final double magnitude = details.velocity.pixelsPerSecond.distance;
    print('_handleOnScaleEnd' + magnitude.toString());
    if (magnitude < _kMinFlingVelocity) return;
    final Offset direction = details.velocity.pixelsPerSecond / magnitude;
    final double distance = (Offset.zero & context.size).shortestSide;
    _flingAnimation = new Tween<Offset>(
        begin: _offset, end: _clampOffset(_offset + direction * distance))
        .animate(_controller);
    _controller
      ..value = 0.0
      ..fling(velocity: magnitude / 1000.0);
  }

  void _onDoubleTap(mu.DoubleDetails details) {
    _normalizedOffset = (details.pointerEvent.position - _offset) / _scale;
    if (!widget.doubleTapStillScale && _scale != 1.0) {
      setState(() {
        _scale = 1.0;
        _offset = Offset.zero;
      });
      return;
    }
    setState(() {
      if (widget.doubleTapStillScale) {
        _scale *= (1 + 0.2);
      } else {
        _scale *= (2);
      }
      // Ensure that image location under the focal point stays in the same place despite scaling.
      // _offset = doubleDownPositon;
      _offset = _clampOffset(details.pointerEvent.position - _normalizedOffset * _scale);
    });
  }

  @override
  Widget build(BuildContext context) {
    print('build:' + ' ' + _offset.dx.toString() + ' ' + _offset.dy.toString() + ' ' + _scale.toString());
    Map<Type, GestureRecognizerFactory> gestures = <Type, GestureRecognizerFactory>{};
    gestures[mu.DoubleTapGestureRecognizer] = GestureRecognizerFactoryWithHandlers<mu.DoubleTapGestureRecognizer>(
          () => mu.DoubleTapGestureRecognizer(debugOwner: this),
          (mu.DoubleTapGestureRecognizer instance) {
        instance
          ..onDoubleTap = _onDoubleTap;
      },
    );
    gestures[sc.ScaleGestureRecognizer] = GestureRecognizerFactoryWithHandlers<sc.ScaleGestureRecognizer>(
          () => sc.ScaleGestureRecognizer(debugOwner: this),
          (sc.ScaleGestureRecognizer instance) {
        instance
//          ..onDoubleTap = _onDoubleTap
          ..onStart = _handleOnScaleStart
          ..onUpdate = _handleOnScaleUpdate
          ..onEnd = _handleOnScaleEnd;
      },
    );
    return RawGestureDetector(
      gestures: gestures,
      child: _getChildWidget(),
    );
  }

  Widget _getChildWidget() {
    return Container(
        margin: widget.margin,
        constraints: const BoxConstraints(
          minWidth: double.maxFinite,
          minHeight: double.maxFinite,
        ),
        child: new Transform(
            transform: new Matrix4.identity()
              ..translate(_offset.dx, _offset.dy)
              ..scale(_scale, _scale, 1.0),
            child: widget.child),
      );
  }
}