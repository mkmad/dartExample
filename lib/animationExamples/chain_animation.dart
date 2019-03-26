import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class ChainAnimation extends AnimatedWidget {
  // animation object
  Animation<double> animation;

  static final _opacityTween = Tween<double>(begin: 0.1, end: 0.5);
  static final _sizeTween = Tween<double>(begin: 1.0, end: 200.0);
  static final _colorTween = ColorTween(begin: Colors.red, end: Colors.blue);

  ChainAnimation({Key key, this.animation})
      : super(key: key, listenable: animation);

  // build animated widget
  Widget _buildAnimatedWidget() {
    return Center(
        child: Opacity(
      opacity: _opacityTween.evaluate(animation) > 0
          ? _opacityTween.evaluate(animation)
          : 0.0,
      child: Container(
        color: _colorTween.evaluate(animation),
        height: _sizeTween.evaluate(animation) > 0
            ? _sizeTween.evaluate(animation)
            : 0.0,
        width: _sizeTween.evaluate(animation) > 0
            ? _sizeTween.evaluate(animation)
            : 0.0,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return _buildAnimatedWidget();
  }
}
