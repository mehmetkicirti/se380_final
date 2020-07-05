import 'package:animate_do/animate_do.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:se380final/common/colors.dart';
import 'package:se380final/common/custom_navigator.dart';
import 'package:se380final/pages/login_page.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final titles = ["Search", "Likes", "Authentication"];

  final description = [
    "you can easily search whatever like the films.",
    "what a like the film you can like.",
    "provided multiple authorize process"
  ];

  final icons = [
    "assets/introImages/romance.png",
    "assets/introImages/love.png",
    "assets/introImages/computer.png",
  ];



  @override
  Widget build(BuildContext context) {
    int _currentIndex = 0;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      body: CarouselSlider(
        options: CarouselOptions(
            onPageChanged: (index,reason){
              setState(() {
                _currentIndex = index;
              });
              print(_currentIndex);
            },
            initialPage: _currentIndex,
            scrollDirection: Axis.horizontal,
            scrollPhysics: ScrollPhysics(),
            viewportFraction: 1.0,
            aspectRatio: 1.0,
            height: MediaQuery
                .of(context)
                .size
                .height),
        items: [0, 1, 2].map((i) {
          return Builder(
            builder: (BuildContext context) {
              final height = MediaQuery
                  .of(context)
                  .size
                  .height;
              final width = MediaQuery
                  .of(context)
                  .size
                  .width;
              return Stack(
                children: <Widget>[
                  Container(
                    color: bgColor.withOpacity(0.9),
                    width: width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: height * 0.15,
                          child: Image.asset(
                            icons[i],
                            fit: BoxFit.cover,
                            width: width * 0.4,
                          ),
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Text(titles[i],
                            style: GoogleFonts.timmana(
                                color: Colors.white,
                                fontSize: 32,
                                shadows: [
                                  Shadow(
                                      color: Colors.black45,
                                      offset: Offset(-1, 1),
                                      blurRadius: 12)
                                ],
                                fontStyle: FontStyle.italic)),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: width * 0.15),
                          child: Text(description[i],
                              style: GoogleFonts.timmana(
                                  color: Colors.white,
                                  fontSize: 19,
                                  shadows: [
                                    Shadow(
                                        color: Colors.black45,
                                        offset: Offset(-1, 1),
                                        blurRadius: 12)
                                  ],
                                  fontStyle: FontStyle.italic)),
                        ),
                        i == 2 ? Padding(
                          padding:EdgeInsets.symmetric(vertical:height*0.02),
                          child: InkWell(
                            onTap: () => NavigatorUtils.pushPage(LoginPage(), context, Curves.easeIn, 1200, Alignment.center),
                            child: BounceInUp(
                              delay: Duration(milliseconds: 1200),
                              child: Container(
                                height: height*0.08,
                                width: width*0.5,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black45,
                                      blurRadius: 12,
                                      offset: Offset(-1,1),
                                      spreadRadius: 12
                                    ),
                                  ],
                                  borderRadius: BorderRadius.all(Radius.circular(25))
                                ),
                                child: Center(
                                  child: Text(
                                    "GET STARTED!",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 22,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ):Container()
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: height*0.02,
                    left: width*0.4,
                    child: DotsIndicator(
                      dotsCount: titles.length,
                      position: i+.0,
                      decorator: DotsDecorator(
                        size: const Size.square(9.0),
                        activeSize: const Size(18.0, 9.0),
                        color: Colors.white,
                        activeColor: Colors.redAccent,
                        activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                      ),
                    ),
                  ),
                  i == 2 ?Container(): Positioned(
                    top: height*0.01,
                    right: 0,
                    child: FlatButton(
                      onPressed: () => NavigatorUtils.pushPage(LoginPage(), context, Curves.easeInCirc, 1200, Alignment.topRight),
                      child: Text(
                        "SKIP",
                        style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 19
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
