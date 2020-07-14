import 'dart:math';
import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:se380final/common/colors.dart';
import 'package:se380final/common/custom_navigator.dart';
import 'package:se380final/common/fadeAnimation.dart';
import 'package:se380final/models/Movies/Film/movie.dart';
import 'package:se380final/models/User/users.dart';
import 'package:se380final/models/result.dart';
import 'package:se380final/pages/error_page.dart';
import 'package:se380final/pages/login_page.dart';
import 'package:se380final/pages/movie_list.dart';
import 'package:se380final/pages/movie_page.dart';
import 'package:se380final/pages/search.dart';
import 'package:se380final/viewModels/movieViewModel.dart';
import 'package:se380final/viewModels/userViewModel.dart';

class Homepage extends StatefulWidget {
  User user;
  Homepage({this.user});
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with TickerProviderStateMixin {
  AnimationController _animationController;
  AnimationController _opacityController;
  AnimationController _sidebarController;
  AnimationController _colorController;
  Animation<double> _sidebarAnimation;
  Animation<Color> _colorAnimation;
  Animation<double> _animation;
  Animation<double> _opacityAnimation;
  PageController _pageController;
  TextEditingController _controller;
  AnimationController _sizeController;
  double _pageControllerPage = 1;
  bool _isMenu = false;

  @override
  void initState() {
    super.initState();
    _animationStatusCheck();
    _pageController = PageController(
        viewportFraction: 0.55, initialPage: _pageControllerPage.round());
    _sizeController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _controller = new TextEditingController(
    );
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
    _sizeController.dispose();
    _pageController.dispose();
    _colorController.dispose();
    _sidebarController.dispose();
    _opacityController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery
        .of(context)
        .size
        .height;
    final width = MediaQuery
        .of(context)
        .size
        .height;
    final _movieModel = Provider.of<MovieViewModel>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: Container(
        color: bgColor,
        height: height,
        width: width,
        child: Stack(
          children: <Widget>[
            //Search
            Positioned(
                right: 0,
                child: BounceInDown(
                  duration: Duration(milliseconds: 1200),
                  child: Container(
                    height: height * 0.13,
                    width: width * 0.42,
                    decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(25)),
                        gradient: LinearGradient(colors: [
                          Color.fromARGB(255, 199, 0, 57),
                          Color.fromARGB(255, 87, 24, 69),
                        ], begin: Alignment.center, end: Alignment.bottomRight),
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 4,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                              color: Colors.black54)
                        ]),
                    child: Row(
                      children: <Widget>[
                        Image.asset(
                          "assets/movie.png",
                          fit: BoxFit.fill,
                          height: height * 0.12,
                          width: width * 0.1,
                          color: Colors.white70,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: width * 0.005),
                          child: RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: "MO",
                                  style: GoogleFonts.robotoSlab(
                                    color: Colors.white,
                                    fontSize: 34,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black54,
                                        offset: Offset(0, 8),
                                        blurRadius: 4,
                                      )
                                    ],
                                  )),
                              TextSpan(
                                  text: "vie Project",
                                  style: GoogleFonts.robotoSlab(
                                    fontSize: 24,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                    shadows: [
                                      Shadow(
                                          color: Colors.black54,
                                          offset: Offset(-1, 1),
                                          blurRadius: 2)
                                    ],
                                  ))
                            ]),
                          ),
                        ),
                        SizedBox(
                          width: width * 0.02,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: height * 0.01),
                          child: CircleAvatar(
                            radius: 24,
                            backgroundColor: Colors.white,
                            child: Transform.rotate(
                              angle: pi / 2,
                              child: IconButton(
                                icon: Icon(
                                  Icons.search,
                                  size: 24,
                                  color: Colors.black54,
                                ),
                                onPressed: () {
                                  NavigatorUtils.pushPage(
                                      Search(), context, Curves.easeIn, 1000,
                                      Alignment.topRight);
                                },
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )),
            //Upper
            Positioned(
              top: height * 0.14,
              child: Column(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(
                          bottom: width * 0.001, top: width * 0.003),
                      child: _buildHeaders(
                          "Upcoming", width, height, _movieModel.resultUpcoming)
                  ),
                  _buildUpperFilms(context)
                ],
              ),
            ),
            //Below
            Positioned(
              bottom: height * 0.02,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildHeaders("Now Playing", width * 1.01, height,
                      _movieModel.resultNowPlaying),
                  Padding(
                    padding: EdgeInsets.only(top: width * 0.005),
                    child: Container(
                      width: width * 0.5,
                      height: height * 0.31,
                      child: _buildBelowFilms(context, height, width),
                    ),
                  ),
                ],
              ),
            ),
            //SideBar
            _sidebarNavigation(height * 0.94, width)
          ],
        ),
      ),
    );
  }

  _animationStatusCheck() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _sidebarController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _colorController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 150));
    _opacityController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _colorAnimation = Tween<Color>(begin: Colors.black, end: Colors.white)
        .animate(_colorController);
    _opacityAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_opacityController);
    _sidebarAnimation =
    Tween<double>(begin: 0, end: 250).animate(_sidebarController)
      ..addStatusListener((listener) {
        if (listener == AnimationStatus.completed) {
          print("Opacity Listener tetiklendi");
          _colorController
              .forward()
              .orCancel;
          Future.delayed(Duration(milliseconds: 250), () {
            print("Future Opacity Listener tetiklendi");
            _opacityController
                .forward()
                .orCancel;
          });
        } else {
          _opacityController.reset();
          _colorController.reset();
        }
      });
    _animation = Tween<double>(begin: 0, end: pi).animate(_animationController)
      ..addStatusListener((listener) {
        if (listener == AnimationStatus.completed) {
          print("Listener tetiklendi");
          _sidebarController
              .forward()
              .orCancel;
        } else if (listener == AnimationStatus.reverse) {
          _sidebarController
              .reverse()
              .orCancel;
        }
      });
  }

  _sidebarNavigation(double height, double width) {
    final user = widget.user;
    return Stack(
      overflow: Overflow.clip,
      children: <Widget>[
        AnimatedBuilder(
          animation: _sidebarController,
          builder: (context, widget) {
            return _isMenu != false
                ? AnimatedContainer(
              height: height,
              width: _sidebarAnimation.value,
              duration: Duration(milliseconds: 750),
              curve: Curves.easeIn,
              decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(25),
                      bottomRight: Radius.circular(25)),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 2,
                        spreadRadius: 4,
                        color: Colors.black54,
                        offset: Offset(0, 2))
                  ]),
              child: AnimatedBuilder(
                animation: _opacityController,
                builder: (context, widget) {
                  return Opacity(
                    opacity: _opacityAnimation.value,
                    child: Column(
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(
                                top: height * 0.045, left: width * 0.02),
                            child: Text(
                              "MENU",
                              style: GoogleFonts.robotoSlab(
                                color: Colors.white,
                                fontStyle: FontStyle.italic,
                                fontSize: 19,
                              ),
                            )),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: height * 0.05),
                          child: FadeAnimation(
                            delay: 1.2,
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(90)),
                              child: CachedNetworkImage(
                                height: height * 0.2,
                                width: width * 0.18,
                                imageUrl: user.profilePhotoURL==
                                    null
                                    ? "https://cdn.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png"
                                    : user.profilePhotoURL,
                                placeholder: (context, _) =>
                                    Center(child: CircularProgressIndicator(),),
                                fadeInCurve: Curves.easeIn,
                                fadeInDuration: Duration(milliseconds: 1000),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: height * 0.02),
                            child: FadeInDown(
                              delay: Duration(milliseconds: 1300),
                              child: Text(
                                user.email == null ? user
                                    .userName : user.email.substring(
                                    0, user.email.indexOf("@")),
                                style: GoogleFonts.robotoSlab(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontStyle: FontStyle.italic,
                                    shadows: [
                                      Shadow(
                                          color: Colors.black45,
                                          blurRadius: 6,
                                          offset: Offset(-1, 1)
                                      )
                                    ]
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(height * 0.1),
                          child: InkWell(
                            onTap: () async {
                              await _signOut();
                            },
                            child: FadeInUp(
                              delay: Duration(milliseconds: 1600),
                              child: Container(
                                height: MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.06,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.5,
                                decoration: BoxDecoration(
                                    color: Colors.deepOrange,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(16)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(.54),
                                          offset: Offset(0, 1),
                                          blurRadius: 2,
                                          spreadRadius: 2)
                                    ]),
                                child: Center(
                                  child: Text(
                                    "Sign Out",
                                    style: GoogleFonts.robotoSlab(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        shadows: [
                                          Shadow(
                                              blurRadius: 12,
                                              offset: Offset(-1, 1),
                                              color: Colors.black45)
                                        ]),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            )
                : Container();
          },
        ),
        InkWell(
          onTap: () {
            _animationController.isCompleted
                ? _animationController
                .reverse()
                .orCancel
                : _animationController
                .forward()
                .orCancel;
            setState(() {
              _isMenu = !_isMenu;
            });
          },
          child: Padding(
              padding: EdgeInsets.only(
                  top: height * 0.03),
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) =>
                    Transform.rotate(
                      angle: _animation.value,
                      child: AnimatedBuilder(
                        animation: _colorController,
                        builder: (context, widget) {
                          return CircleAvatar(
                            radius: 24,
                            child: Icon(
                              Icons.menu,
                              size: 32,
                              color: _colorController.isCompleted != true
                                  ? Colors.black
                                  : _colorAnimation.value,
                            ),
                          );
                        },
                      ),
                    ),
              )),
        ),
      ],
    );
  }

  _getScale(int idx) {
    double scale = 1 - (_pageControllerPage - idx).abs();
    return scale < 0.9 ? 0.92 : scale;
  }

  _buildUpperFilms(BuildContext context) {
    final _movieModel = Provider.of<MovieViewModel>(context);
    return Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: MediaQuery
            .of(context)
            .size
            .height * 0.34,
        child: NotificationListener<ScrollNotification>(
          onNotification: (_) {
            setState(() {
              _pageControllerPage = _pageController.page;
            });
            return true;
          },
          child: _movieModel.state == MovieState.LoadedMovie ?
          PageView.builder(
              itemBuilder: (context, index) {
                final movie = _movieModel.resultUpcoming.results[index];
                return Transform.scale(
                  scale: _getScale(index),
                  child: Container(
                    child: Stack(children: <Widget>[
                      InkWell(
                        onTap: () async {
                          print(movie.id);
                          return await _getMoviePage(movie.id);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 5.0,
                                    offset: Offset(-1, 2.0),
                                    spreadRadius: 2.0)
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: FadeInImage(
                              placeholder:
                              AssetImage("assets/loading.gif"),
                              image: NetworkImage(
                                  "${movie.posterPath}"),
                              fit: BoxFit.cover,
                              width:
                              MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.5,
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height *
                                  0.35,
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
                );
              },
              controller: _pageController,
              itemCount: _movieModel.resultUpcoming.results
                  .sublist(
                  0,
                  (_movieModel.resultUpcoming.results.length > 5
                      ? 5
                      : _movieModel.resultUpcoming.results.length))
                  .length) : Center(child: CircularProgressIndicator(),),
        ));
  }


  _buildBelowFilms(BuildContext context, double height, double width) {
    final _movieModel = Provider.of<MovieViewModel>(context);
    return _movieModel.state == MovieState.LoadedMovie ?
    ListView.builder(
        itemBuilder: (context, index) {
          var movies = _movieModel.resultNowPlaying.results[index];
          return InkWell(
            onTap: () async => await _getMoviePage(movies.id),
            //Navigator.push(context, MaterialPageRoute(builder: (context)=>MovieDetail(movies))),
            child: Padding(
              padding: EdgeInsets.only(bottom: width * 0.03),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CachedNetworkImage(
                      imageUrl: movies.posterPath,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) =>
                          Center(child: Icon(Icons.error)),
                      placeholder: (context, url) =>
                          Center(child: CircularProgressIndicator()),
                      width:
                      MediaQuery
                          .of(context)
                          .size
                          .width * 0.4,
                      height: MediaQuery
                          .of(context)
                          .size
                          .height *
                          0.27,
                      fadeInCurve: Curves.easeIn,
                      fadeInDuration: Duration(milliseconds: 500),
                    ),
                  ),
                  SizedBox(
                    width: height * .03,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          movies.title.length > 50 ? movies.title.substring(
                              0, 30) + "..." : movies.title,
                          style: GoogleFonts.abhayaLibre(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                    color: Colors.black,
                                    offset: Offset(1, -1),
                                    blurRadius: 12
                                )
                              ]
                          ),
                        ),
                        Text(
                          "${movies.releaseDate.year}-${movies.releaseDate
                              .month}-${movies.releaseDate.day} ",
                          style: GoogleFonts.abhayaLibre(
                              fontSize: 17,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                    color: Colors.black,
                                    offset: Offset(1, -1),
                                    blurRadius: 12
                                )
                              ]
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
        scrollDirection: Axis.vertical,
        itemCount: _movieModel.resultNowPlaying.results.length
    ) : Align(alignment: Alignment.center, child: CircularProgressIndicator());
  }

  _getMoviePage(int id) async {
    final _movieModel = Provider.of<MovieViewModel>(context, listen: false);
    final _userModel = Provider.of<UserViewModel>(context, listen: false);
    Movie movie = await _movieModel.getMovieById(id);
    await _userModel.getLikes(_userModel.user.uid);
    //Trailer trailer = await _movieModel.getMoviesVideoById(id);
    return await Navigator.push(context,
        PageTransition(
            type: PageTransitionType.leftToRight, child: MoviePage(movie: movie),curve: Curves.easeIn,duration: Duration(milliseconds: 500)));
  }

  _buildHeaders(String header, double width, double height, Result movies) {
    return Container(
        width: width * 0.48,
        height: height * 0.05,
        child: Padding(
          padding: EdgeInsets.only(right: width * 0.01),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                header,
                style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              InkWell(
                onTap: () =>
                    NavigatorUtils.pushPage(
                        MovieList(header: header, movies: movies), context,
                        Curves.easeIn, 1000, Alignment.center),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      color: Colors.white
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(width * 0.01),
                    child: Center(
                      child: Text(
                        "See All".toUpperCase(),
                        style: GoogleFonts.montserrat(
                          color: textColor,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  _signOut() async {
    final userModel = Provider.of<UserViewModel>(context, listen: false);
    bool isSignOut = await userModel.signOut();
    isSignOut
        ? Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
            (route) => false)
        : ErrorPage(
      title: "Error User Signout",
    );
  }
}
