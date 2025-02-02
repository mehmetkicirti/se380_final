import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class FadeAnimation extends StatelessWidget{
  final double delay;
  final Widget child;
  FadeAnimation({this.delay:1.2, this.child}):assert(child != null);

  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track("opacity").add(Duration(milliseconds: 500),Tween(begin: 0.0,end: 1.0)),
      Track("translateY").add(Duration(milliseconds: 500),Tween(begin: -130.0,end: 0.0),curve: Curves.easeInCirc),
    ]);
    return ControlledAnimation(
      delay: Duration(milliseconds: (500*delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builderWithChild: (context,child,animation){
        return Opacity(
          opacity: animation["opacity"],
          child: Transform.translate(offset: Offset(0,animation["translateY"]),child: child,),
        );
      },
    );
  }
}
