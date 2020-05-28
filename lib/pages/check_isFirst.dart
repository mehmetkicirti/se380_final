import 'package:flutter/material.dart';
import 'package:se380final/common/custom_navigator.dart';
import 'package:se380final/pages/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'intro_screen.dart';
class CheckPage extends StatefulWidget {
  @override
  _CheckPageState createState() => _CheckPageState();
}

class _CheckPageState extends State<CheckPage> {
  Future _checkIsFirstRun() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirst = (prefs.getBool("isFirst") ?? true);
    if (!isFirst) {
      NavigatorUtils.pushPage(
          SplashScreen(), context, Curves.easeInCirc, 1200, Alignment.center);
    } else {
      await prefs.setBool("isFirst", false);
      await NavigatorUtils.pushPage(
          IntroScreen(), context, Curves.bounceInOut, 1200, Alignment.center);
    }
  }

  @override
  void initState() {
    super.initState();
    _checkIsFirstRun();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}