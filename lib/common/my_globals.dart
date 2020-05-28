import 'package:flutter/material.dart';
//When I am getting error issues solution => To safely refer to a widget's ancestor in its dispose() method, save a reference to the ancestor by calling dependOnInheritedWidgetOfExactType() in the widget's didChangeDependencies() method.
//try this with => myGlobals.scaffoldkey scaffold after that whenever you go should put => into context myGlobals.scaffoldkey.currentContext
MyGlobals myGlobals = new MyGlobals();
class MyGlobals {
  GlobalKey _scaffoldKey;
  MyGlobals() {
    _scaffoldKey = GlobalKey();
  }
  GlobalKey get scaffoldKey => _scaffoldKey;
}