import 'package:animate_do/animate_do.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:se380final/common/custom_shape_clipper.dart';
import 'package:se380final/common/fadeAnimation.dart';
import 'package:se380final/pages/error_page.dart';
import 'package:se380final/pages/home_page_core.dart';
import 'package:se380final/pages/login_page.dart';
import 'package:se380final/viewModels/userViewModel.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  AnimationController _scaleController;
  AnimationController _scale2Controller;
  AnimationController _widthController;
  AnimationController _positionController;

  Animation<double> _scaleAnimation;
  Animation<double> _scale2Animation;
  Animation<double> _widthAnimation;
  Animation<double> _positionAnimation;

  bool hideIcon = false;
  bool hideText = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scaleController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    _scaleAnimation =
        Tween<double>(begin: 1.0, end: .8).animate(_scaleController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _widthController.forward();
            }
          });
    _widthController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    _widthAnimation =
        Tween<double>(begin: 80.0, end: 300.0).animate(_widthController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _positionController.forward();
            }
          });
    _positionController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    _positionAnimation =
        Tween<double>(begin: 0.0, end: 220.0).animate(_positionController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              setState(() {
                hideIcon = true;
              });
              _scale2Controller.forward();
            }
          });
    _scale2Controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    _scale2Animation =
        Tween<double>(begin: 1.0, end: 33.0).animate(_scale2Controller);
  }

  @override
  void dispose() {
    super.dispose();
    _positionController.dispose();
    _scale2Controller.dispose();
    _scaleController.dispose();
    _widthController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final height = constraints.maxHeight;
          final width = constraints.maxWidth;
          return Stack(
            children: <Widget>[
              Container(
                height: height,
                width: width,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Color.fromARGB(255, 150, 194, 198),
                  Color.fromARGB(255, 75, 67, 84),
                ], begin: Alignment.center, end: Alignment.bottomCenter)),
              ),
              FadeAnimation(
                  delay: 0.5,
                  child: buildClipPath(context, height * 0.45, Colors.blueGrey,
                      Colors.indigoAccent)),
              FadeAnimation(
                  delay: 0.75,
                  child: buildClipPath(context, height * 0.32, Colors.redAccent,
                      Theme.of(context).accentColor)),
              FadeAnimation(delay: 1.2, child: _buildUpperField(height)),
              SizedBox(
                height: height * 0.2,
              ),
              hideText == false
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : _buildAnimationField(width)
            ],
          );
        },
      ),
    );
  }

  _buildUpperField(double height) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50),
      child: Align(
          alignment: Alignment.topCenter,
          child: hideText == false
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "SE 380",
                      style: GoogleFonts.tradeWinds(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Prepared By : ",
                        style: GoogleFonts.tradeWinds(
                          fontSize: 28.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: TyperAnimatedTextKit(
                        onFinished: () {
                          setState(() {
                            hideText = true;
                          });
                        },
                        isRepeatingAnimation: false,
                        speed: Duration(milliseconds: 150),
                        text: ["Mehmet Aydın Kıcırtı", "Mustafa Ozan Güney"],
                        textStyle: GoogleFonts.yeonSung(
                            fontSize: 40.0,
                            color: Colors.white),
                        textAlign: TextAlign.start,
                        alignment: AlignmentDirectional.topStart,
                        // or Alignment.topLeft
                      ),
                    )
                  ],
                )
              : FadeAnimation(
                  delay: 1.2,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: height * 0.12),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "İzmir University Of Economics",
                          style: GoogleFonts.racingSansOne(
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                        SizedBox(
                          height: height * 0.2,
                        ),
                        Expanded(
                          child: FadeInImage.assetNetwork(
                            placeholder: "assets/transparent_loading.gif",
                            image:
                                "https://medya.ilan.gov.tr/upload/uploads/cust/1544162553651.png",
                            fadeInCurve: Curves.easeInOut,
                            fit: BoxFit.fitHeight,
                            height: 250,
                            fadeOutCurve: Curves.bounceIn,
                          ),
                        ),
                        Text(
                          "Cinema Project",
                          style: GoogleFonts.montserrat(color: Colors.white, fontSize: 30),
                        ),
                      ],
                    ),
                  ),
                )),
    );
  }

  ClipPath buildClipPath(BuildContext context, double height,
      Color primaryColor, Color secondaryColor) {
    return ClipPath(
      clipper: CustomShapeClipper(),
      child: Container(
        height: height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [primaryColor, secondaryColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight)),
      ),
    );
  }

  _buildAnimationField(double width) {
    final _userModel = Provider.of<UserViewModel>(context);
    return Padding(
      padding: EdgeInsets.only(bottom: width * 0.15),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: BounceInUp(
          child: AnimatedBuilder(
            animation: _scaleController,
            builder: (context, child) => Transform.scale(
              scale: _scaleAnimation.value,
              child: AnimatedBuilder(
                animation: _widthController,
                builder: (context, child) => Container(
                  width: _widthAnimation.value,
                  height: 80,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.blue.withOpacity(0.4)),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _scaleController.forward().then((_) {
                          _scale2Controller
                            ..addStatusListener((status) async {
                              if (status == AnimationStatus.completed) {
                                switch (_userModel.state) {
                                  case UserState.LoadingUser:
                                    return CircularProgressIndicator();
                                  case UserState.LoadedUser:
                                    if (_userModel.user == null) {
                                      return Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginPage()));
                                    } else {
                                      debugPrint(_userModel.user.email);
                                      return Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomepageCore()));
                                    }
                                    break;
                                  case UserState.ErrorUser:
                                    return Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ErrorPage(title: "Error User",)));
                                  case UserState.IdleUser:
                                    return null;
                                }
                              }
                            });
                        });
                      });
                    },
                    child: Stack(
                      children: <Widget>[
                        AnimatedBuilder(
                          animation: _positionController,
                          builder: (context, child) => Positioned(
                            left: _positionAnimation.value,
                            child: AnimatedBuilder(
                              builder: (context, child) => Transform.scale(
                                scale: _scale2Animation.value,
                                child: Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    shape: BoxShape.circle,
                                  ),
                                  child: hideIcon == false
                                      ? Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.white,
                                        )
                                      : Container(),
                                ),
                              ),
                              animation: _scale2Controller,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
