import 'dart:async';

import 'package:flutter/material.dart';

class NavigatorUtils{
  static Future<Widget> pushPage(Widget widget,BuildContext context, Curve curve,int milliSeconds, Alignment alignment) async{
    return await Navigator.push(context,PageRouteBuilder(
        transitionDuration:
        Duration(milliseconds: milliSeconds),
        transitionsBuilder: (context,
            animation, secAnimation, widget) {
          animation = CurvedAnimation(
              parent: animation,
              curve: curve);
          return ScaleTransition(
            child: widget,
            scale: animation,
            alignment: alignment,
          );
        },
        pageBuilder: (context, animation,
            secAnimation) {
          return widget;
        }));

  }
/*static Future<bool> backToPage(BuildContext context,int milliSeconds,Curve curve, Alignment alignment, Widget widget) async{
     return Navigator.of(context).pop(PageRouteBuilder(
        transitionDuration:
        Duration(milliseconds: milliSeconds),
        transitionsBuilder: (context,
            animation, secAnimation, widget) {
          animation = CurvedAnimation(
              parent: animation,
              curve: curve);
          return ScaleTransition(
            child: widget,
            scale: animation,
            alignment: alignment,
          );
        },
        pageBuilder: (context, animation,
            secAnimation) {
          return widget;
        }
    ));
  }
}*/
}
