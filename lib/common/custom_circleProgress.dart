import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CircleProgress extends StatefulWidget {
  final double voteAverage;
  CircleProgress({this.voteAverage});
  @override
  _CircleProgressState createState() => _CircleProgressState();
}

class _CircleProgressState extends State<CircleProgress> with TickerProviderStateMixin{
  AnimationController _progressController;
  Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 1500)
    );
    _animation = Tween<double>(begin: 0,end: widget.voteAverage).animate(_progressController)..addListener((){
      setState(() {
      });
    });
    _progressController.forward();
  }
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      child: Container(
        height: 150,
        width: 150,
        child: Center(child: Text(
          "${_animation.value.toStringAsFixed(1)}",
          style: TextStyle(
            fontSize: 20,
            fontFamily: "Montserrat",
            color: Colors.white
          ),
        ),),
      ),
      painter: CirclePainter(currentProgress: _animation.value),
    );
  }
}
class CirclePainter extends CustomPainter{
  double currentProgress;
  CirclePainter({this.currentProgress});
  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width/2,size.height/2);
    double radius = min(size.width/2,size.height/2) - 10;
    Paint outerCircle = Paint()
      ..strokeWidth = 10
      ..color = Colors.black
      ..style = PaintingStyle.stroke;
    Paint completeArc = Paint()
      ..strokeWidth = 10
      ..color = Colors.blue
      ..shader = LinearGradient(
        colors: [Colors.red,Colors.purple,Colors.deepPurple]
      ).createShader(Rect.fromCircle(center: center,radius: size.width/2))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, outerCircle); // this draws main outer circle
    double angle = 2* pi * (currentProgress*10/100);
    canvas.drawArc(Rect.fromCircle(center: center,radius: radius), -pi/2, angle, false, completeArc);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

}
