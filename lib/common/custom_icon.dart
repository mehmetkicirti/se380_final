import 'package:flutter/material.dart';
class CustomIconCreator extends StatelessWidget{
  final BuildContext context;
  final double height;
  final double width;
  final double radius;
  final Color borderColor;
  final Color iconColor;
  final double iconSize;
  final IconData icon;

  CustomIconCreator({@required this.context, this.height : 0.07, this.width:0.13, this.radius:50,
    this.borderColor:Colors.white, this.iconColor:Colors.blueAccent, this.iconSize:38,@required this.icon});

  @override
  Widget build(context) {
    return Container(
      height: MediaQuery.of(context).size.height*height,
      width: MediaQuery.of(context).size.width*width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius)
          ,color: borderColor
      ),
      child: Icon(
        icon,
        color: iconColor,
        size: iconSize,
      ),
    );
  }
}