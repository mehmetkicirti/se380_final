import 'dart:io';
import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:se380final/common/colors.dart';
import 'package:se380final/common/custom_navigator.dart';
import 'package:se380final/common/fadeAnimation.dart';
import 'package:se380final/common/font_style.dart';
import 'package:se380final/models/Movies/Film/movie.dart';
import 'package:se380final/pages/error_page.dart';
import 'package:se380final/pages/login_page.dart';
import 'package:se380final/pages/movie_page.dart';
import 'package:se380final/viewModels/movieViewModel.dart';
import 'package:se380final/viewModels/userViewModel.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File _file;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      backgroundColor: bgColor,
      body: Container(
          width: queryData.size.width,
          height: queryData.size.height,
          child: _buildPage(queryData.size.height, queryData.size.width)),
    );
  }

  _buildPage(double height, double width) {
    final _userModel = Provider.of<UserViewModel>(context, listen: false);
    final _movieModel = Provider.of<MovieViewModel>(context, listen: false);
    return FadeAnimation(
      delay: 1.2,
      child: CustomPaint(
        painter: PaintProfile(),
        child: Container(
          height: height,
          width: width,
          child: Stack(
            children: <Widget>[
              Positioned(
                left: width * 0.04,
                right: width * 0.04,
                child: BounceInDown(
                    delay: Duration(milliseconds: 1200),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              top: height * 0.27, left: width * 0.02),
                          child: Text("Welcome...",
                              style: GoogleFonts.yeonSung(
                                color: Colors.white,
                                fontSize: 42,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                              )),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: height * 0.02, left: width * 0.02),
                          child: Text(
                             _userModel.user.email == null ? _userModel.user.userName :  _userModel.user.email.substring(
                                 0, _userModel.user.email.indexOf("@")),
                              style: GoogleFonts.yeonSung(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                              )),
                        )
                      ],
                    )),
              ),
              Positioned(
                top: height * 0.05,
                left: width * 0.1,
                right: width * 0.5,
                child: BounceInDown(
                  delay: Duration(milliseconds: 1200),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(90),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0, 2),
                              blurRadius: 2,
                              spreadRadius: 2)
                        ]),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(90),
                      child: FadeInImage(
                        image: NetworkImage(_userModel.user.profilePhotoURL),
                        placeholder: AssetImage("assets/loading.gif"),
                        fit: BoxFit.fill,
                        height: height * 0.20,
                        width: width * 0.25,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: height * 0.04,
                right: width * 0.51,
                child: BounceInDown(
                  duration: Duration(milliseconds: 1200),
                  child: ClipOval(
                    child: Container(
                      height: height * 0.07,
                      width: width * 0.14,
                      decoration:
                          BoxDecoration(color: Colors.white, boxShadow: [
                        BoxShadow(
                            spreadRadius: 4,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                            color: Colors.black)
                      ]),
                      child: IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Container(
                                  height: height * 0.15,
                                  child: Column(
                                    children: <Widget>[
                                      ListTile(
                                        leading: Icon(Icons.camera),
                                        title: Text("Take a photo from camera"),
                                        onTap: () async {
                                          await _takeAPhotoWithCamera();
                                        },
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.image),
                                        title: Text("Select from gallery"),
                                        onTap: () async {
                                          await _chooseByGallery();
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              });
                        },
                        icon: Icon(Icons.add),
                        iconSize: 32,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: height * 0.18,
                right: -width * 0.15,
                child: InkWell(
                  onTap: () async {
                    await _signOut();
                  },
                  child: FadeInUp(
                    duration: Duration(milliseconds: 1200),
                    child: Transform.rotate(
                      angle: -pi / 2,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.08,
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                            color: Colors.deepOrange,
                            borderRadius: BorderRadius.all(Radius.circular(16)),
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
                            style: GoogleFonts.notoSans(
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
                ),
              ),
              Positioned(
                top: height * 0.48,
                right: width * 0.25,
                child: getCategoryHeader("Likes", 32),
              ),
              Positioned(
                top: height * .53,
                right: 0,
                child: Container(
                  height: height * 0.4,
                  width: width * .73,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30))
                  ),
                  child: _movieModel.likedMovies.length > 0
                      ? ListView.builder(
                          itemBuilder: (context, index) {
                            final likedMovies = _movieModel.likedMovies;
                            return Padding(
                              padding:EdgeInsets.all(height*0.02),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  InkWell(
                                    onTap: () => _getMoviePage(likedMovies[index].id),
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                      child: FadeInImage(
                                        image: NetworkImage(
                                            "https://image.tmdb.org/t/p/original${likedMovies[index].posterPath}"),
                                        placeholder:
                                            AssetImage("assets/loading.gif"),
                                        fit: BoxFit.fill,
                                        height: height * 0.3,
                                        width: width * 0.35,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: width*0.02,),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          likedMovies[index].title,
                                          style: GoogleFonts.robotoSlab(
                                              fontSize: 18,
                                              color: Colors.white
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(vertical: height*0.12),
                                          child: InkWell(
                                            onTap: () async=> await _deleteFilm(likedMovies[index].id.toString()),
                                            child: Container(
                                              height: height*0.05,
                                              width: width*0.20,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(6)),
                                                color: Colors.white,
                                              ),
                                              child: Row(
                                                children: <Widget>[
                                                  SizedBox(width: width*0.01,),
                                                  Text(
                                                    "Delete",
                                                    style: GoogleFonts.robotoSlab(
                                                    ),
                                                  ),
                                                  Icon(
                                                    Icons.delete_sweep,
                                                    size: 32,
                                                    color: Colors.red,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          itemCount: _movieModel.likedMovies.length,
                        )
                      : Center(
                          child: Text(
                            "Does Not Any Liked Films",
                            style: GoogleFonts.tradeWinds(
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                      color: Colors.black45,
                                      offset: Offset(-1, 1),
                                      blurRadius: 12)
                                ],
                                fontWeight: FontWeight.w600,
                                fontSize: 24),
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _getLikes(List<String> likesId) async {
    final _movieModel = Provider.of<MovieViewModel>(context, listen: false);
    await _movieModel.getLikedMovies(likesId);
  }

  _getByStatus(double height, double width) {
    final _movieModel = Provider.of<MovieViewModel>(context, listen: false);
    if (_movieModel.state == MovieState.LoadingMovie) {
      return Center(
        child: CircularProgressIndicator(
          backgroundColor: bgColor,
        ),
      );
    } else if (_movieModel.state == MovieState.LoadedMovie) {
      return _buildPage(height, width);
    } else {
      return ErrorPage(
        title: "Error : Like Error",
      );
    }
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

  _takeAPhotoWithCamera() async {
    final userModel = Provider.of<UserViewModel>(context, listen: false);
    var _newPicture = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _file = _newPicture;
      Navigator.of(context).pop();
    });
    if (_file != null) {
      String url = await userModel.getDownloadURL(
          userModel.user.uid, "profil_photo", _file);
      if (url != null) {
        setState(() {
          userModel.user.profilePhotoURL = url;
        });
      }
    }
  }

  _chooseByGallery() async {
    final userModel = Provider.of<UserViewModel>(context, listen: false);
    var _newPicture = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _file = _newPicture;
      Navigator.of(context).pop();
    });
    if (_file != null) {
      String url = await userModel.getDownloadURL(
          userModel.user.uid, "profil_photo", _file);
      if (url != null) {
        setState(() {
          userModel.user.profilePhotoURL = url;
        });
      }
    }
  }

  _getMoviePage(int id) async{
    final _movieModel = Provider.of<MovieViewModel>(context,listen: false);
    final _userModel = Provider.of<UserViewModel>(context,listen: false);
    Movie movie=await _movieModel.getMovieById(id);
    await _userModel.getLikes(_userModel.user.uid);
    return await NavigatorUtils.pushPage(MoviePage(movie:movie), context, Curves.easeIn, 1000, Alignment.center);
  }

  _deleteFilm(String cinemaId) async{
    final _userModel = Provider.of<UserViewModel>(context,listen: false);
    bool isDeleted=await _userModel.deleteLikeFilm(_userModel.user.uid, cinemaId);
    if(isDeleted){
      List<String> likes = await _userModel.getLikes(_userModel.user.uid);
      await _getLikes(likes);
      debugPrint("Deleted");
    }else{
      debugPrint("Error");
    }
  }
}

class PaintProfile extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();

//    paint.color = Colors.cyan.withOpacity(0.45);
//
//    Offset c1 = Offset(size.width * 0.2, size.width * 0.82);
//    double radius1 = size.width * .6;
//
//    canvas.drawCircle(c1, radius1, paint);

    paint.color = Colors.blueAccent.withOpacity(.85);

    Offset c2 = Offset(size.width * 0.85, size.height * 0.82);
    double radius2 = size.width * 0.72;

    canvas.drawCircle(c2, radius2, paint);

    Offset c3 = Offset(size.width * 0.2, size.height * 0.22);
    double radius3 = size.width * 0.55;

    paint.color = Colors.deepPurple;

    canvas.drawCircle(c3, radius3, paint);
  }

  @override
  bool shouldRepaint(PaintProfile oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(PaintProfile oldDelegate) => true;
}
