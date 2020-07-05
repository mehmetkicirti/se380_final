import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:se380final/pages/check_isFirst.dart';
import 'package:se380final/pages/homepage.dart';
import 'package:se380final/utils/locator.dart';
import 'package:se380final/viewModels/movieViewModel.dart';
import 'package:se380final/viewModels/userViewModel.dart';

void main() {
  setupLocator();
  runApp(MyApp());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  SystemChrome.setEnabledSystemUIOverlays([]);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => MovieViewModel(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Se380 MovieProject",
        routes: {
          'homepage' : (_) => Homepage(),
        },
        home: CheckPage(),
        theme: ThemeData(
            backgroundColor: Color.fromARGB(255, 17, 24, 72),
            accentColor: Colors.white70,
            primaryColor: Colors.orangeAccent),
      ),
    );
  }
}



