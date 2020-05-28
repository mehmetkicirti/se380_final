import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:se380final/common/custom_circleProgress.dart';
import 'package:se380final/models/Movies/Film/movie.dart';
import 'package:se380final/pages/error_page.dart';
import 'package:se380final/viewModels/movieViewModel.dart';
import 'package:se380final/viewModels/userViewModel.dart';
import 'package:url_launcher/url_launcher.dart';

class MoviePage extends StatefulWidget {
  final Movie movie;

  const MoviePage({Key key, @required this.movie}) : super(key: key);

  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;
  var key = GlobalKey();
  bool expanded = false;
  int selectedIndex = 0;
  bool isComp = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 150),
        reverseDuration: Duration(milliseconds: 150));
    _animation = Tween<double>(begin: 0, end: 20).animate(_animationController);
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else
      throw "Could not launch " + url;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final _movieModel = Provider.of<MovieViewModel>(context);

    final Movie movie = widget.movie;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: false,
        backgroundColor: Theme.of(context).backgroundColor.withOpacity(.9),
        body: Container(
          height: height,
          width: width,
          child: Stack(
            overflow: Overflow.clip,
            children: <Widget>[
              if (_movieModel.state == MovieState.LoadedMovie) ...[
                Positioned(
                  top: 0,
                  child: Container(
                    height: height * 0.6,
                    width: width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        image: DecorationImage(
                          image: NetworkImage(
                            "https://image.tmdb.org/t/p/original${movie.posterPath}",
                          ),
                          fit: BoxFit.fill,
                        )),
                  ),
                ),
                Positioned(
                  right: 0,
                  child: Padding(
                    padding: EdgeInsets.all(width * 0.04),
                    child: Container(
                      width: width * 0.12,
                      height: height * 0.07,
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: Center(
                          child: IconButton(
                            onPressed: () async{
                              //FireStore process
                              await _likeFilm();
                            },
                            icon: _checkIsLiked(movie.id.toString()),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  child: Padding(
                    padding: EdgeInsets.all(width * 0.04),
                    child: Container(
                      width: width * 0.11,
                      height: height * 0.08,
                      child: CircleAvatar(
                        child: Center(
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: movie.productionCompanies.length > 2
                      ? height * 0.35
                      : height * 0.46,
                  width: width,
                  child: Opacity(
                    opacity: .95,
                    child: Container(
                      height: movie.productionCompanies.length > 2
                          ? height * 0.26
                          : height * 0.16,
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                            color: Colors.black87,
                            offset: Offset(1, -1),
                            blurRadius: 16,
                            spreadRadius: 16),
                      ]),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: width * 0.035),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              movie.originalTitle +
                                  " (${movie.releaseDate.toUtc().year.toString()})",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "MerriWeather",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28),
                            ),
                            Wrap(
                              spacing: width * 0.005,
                              // gap between adjacent chips
                              runSpacing: width * 0.002,
                              // gap between lines
                              direction: Axis.horizontal,
                              // main axis (rows or columns)
                              children: <Widget>[
                                for (int i = 0;
                                    i < movie.productionCompanies.length;
                                    i++) ...[
                                  if (i < 4) ...[
                                    _getCompanies(movie.productionCompanies[i]),
                                    SizedBox(width: width * 0.03)
                                  ] else ...[
                                    Container()
                                  ]
                                ]
                              ],
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  _getRunTime(movie.runtime),
                                  SizedBox(
                                    width: width * 0.03,
                                  ),
                                  for (int i = 0;
                                      i < movie.genres.length;
                                      i++) ...[
                                    if (i < 4) ...[
                                      Text(
                                        i == movie.genres.length - 1
                                            ? movie.genres[i].name
                                            : movie.genres[i].name + " | ",
                                        style: TextStyle(
                                            color: Colors.blueGrey,
                                            fontSize: movie.genres.length > 3
                                                ? 12
                                                : 14,
                                            fontFamily: "Montserrat",
                                            fontWeight: FontWeight.bold),
                                      )
                                    ] else ...[
                                      Container()
                                    ]
                                  ],
                                  SizedBox(
                                    width: width * 0.04,
                                  ),
                                  Text(
                                    "${movie.releaseDate.toUtc().year}",
                                    style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontSize: 14,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: height * 0.32,
                  height: height * 0.06,
                  width: width,
                  child: Container(
                    child: _getMenu(),
                  ),
                ),
                Positioned(
                  bottom: height * 0.06,
                  child: Container(
                    height: height * 0.25,
                    width: width,
                    child: SingleChildScrollView(
                      key: key,
                      scrollDirection: Axis.vertical,
                      physics: ScrollPhysics(),
                      child: _getMenuItems(selectedIndex),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 750),
                    curve: Curves.easeInCirc,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25)),
                      color: Colors.white,
                    ),
                    height: expanded ? height * 0.4 : height * 0.06,
                    width: width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Flexible(
                          child: IconButton(
                              icon: Icon(expanded
                                  ? Icons.keyboard_arrow_down
                                  : Icons.keyboard_arrow_up),
                              onPressed: () {
                                _isCompChange();
                                setState(() {
                                  expanded
                                      ? _animationController.forward()
                                      : _animationController.reverse();
                                  expanded = !expanded;
                                });
                              }),
                        ),
                        Text(
                          "Trailers",
                          style: GoogleFonts.robotoSlab(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                              isComp ? _buildTrailer(movie.videos.results,height,width): Container()
                      ],
                    ),
                  ),
                ),
              ] else if (_movieModel.state == MovieState.LoadingMovie) ...[
                Center(
                  child: CircularProgressIndicator(),
                )
              ] else ...[
                ErrorPage(
                  title: "Error About Film..",
                )
              ]
            ],
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  _getCompanies(ProductionCompany productionCompany) {
    return Chip(
      backgroundColor: productionCompany.id % 2 == 0
          ? Theme.of(context).accentColor
          : Theme.of(context).primaryColor,
      elevation: 16,
      avatar: CircleAvatar(
        backgroundColor: Theme.of(context).accentColor,
        child: productionCompany.logoPath != null
            ? Image.network(
                "https://image.tmdb.org/t/p/original${productionCompany.logoPath}",
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
              )
            : Text(productionCompany.name.substring(0, 1)),
      ),
      label: Text(productionCompany.name),
    );
  }

  _getRunTime(int runtime) {
    int getHour = (runtime.toDouble() / 60).floor();
    int getMinute = runtime.remainder(60);
    return Text(
      "$getHour" + "H" + " $getMinute" + "m",
      style: TextStyle(color: Colors.blueGrey, fontSize: 14),
    );
  }

  _getMenu() {
    List<String> menus = [
      "About",
      "Info",
      "Reviews",
      "Directors",
      "Characters",
      "Companies"
    ];
    return ListView.builder(
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            setState(() {
              selectedIndex = index;
            });
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.005),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInCirc,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  gradient: selectedIndex == index
                      ? LinearGradient(colors: [
                          Color.fromARGB(255, 199, 0, 57),
                          Color.fromARGB(255, 255, 87, 51),
                        ], begin: Alignment.topLeft, end: Alignment.bottomRight)
                      : LinearGradient(
                          colors: [
                              Color.fromARGB(55, 159, 100, 57),
                              Color.fromARGB(255, 255, 87, 51),
                            ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black45,
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: Offset(1, -1))
                  ]),
              child: Center(
                  child: Text(
                menus[index],
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "YeonSung",
                    fontSize: selectedIndex == index ? 20 : 16,
                    fontWeight: selectedIndex == index
                        ? FontWeight.bold
                        : FontWeight.normal),
              )),
            ),
          ),
        );
      },
      itemCount: menus.length,
      scrollDirection: Axis.horizontal,
      itemExtent: MediaQuery.of(context).size.width * 0.335,
      physics: ScrollPhysics(),
    );
  }

  _getMenuItems(int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        return BounceInLeft(
          duration: Duration(milliseconds: 500),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              setTextHeader("About : "),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Text(
                "    " + widget.movie.overview,
                style: TextStyle(
                    color: Colors.white70,
                    fontSize: 17,
                    fontFamily: "RobotoSlab",
                    wordSpacing: 2),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
            ],
          ),
        );
      case 1:
        return BounceInRight(
          duration: Duration(milliseconds: 500),
          child: Column(
            children: <Widget>[
              setTextHeader("Info"),
              setInfoDetail("Release Date : ",
                  "${widget.movie.releaseDate.day} ${getMonth(widget.movie.releaseDate.month)} ${widget.movie.releaseDate.year}"),
              setInfoDetail(
                  "Genres : ", "${widget.movie.genres.map((el) => el.name)}"),
              setInfoDetail("Vote Count : ", "${widget.movie.voteCount}"),
              setInfoDetail("Status : ", "${widget.movie.status}"),
              setInfoDetail("Budget : ", "${widget.movie.budget} \$"),
              setInfoDetail("Revenue : ", "${widget.movie.revenue} \$"),
              setInfoDetail("Runtime : ", "${widget.movie.runtime} days"),
              InkWell(
                child: setInfoDetail("Website : ",
                    "${widget.movie.homepage.length > 50 ? widget.movie.homepage.substring(0, 38) : widget.movie.homepage}"),
                onTap: () => launch(widget.movie.homepage),
              ),
              setInfoDetail("Popularity : ", "${widget.movie.popularity}"),
            ],
          ),
        );
      case 2:
        return BounceInUp(
          duration: Duration(milliseconds: 500),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              setTextHeader("Imdb"),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              CircleProgress(
                voteAverage: widget.movie.voteAverage,
              )
            ],
          ),
        );
      default:
        return Container();
    }
  }

  setTextHeader(String name) {
    return Text(
      name.toUpperCase(),
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 22,
        fontFamily: "RobotoSlab",
      ),
    );
  }

  setInfoDetail<T>(String header, T value) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.015),
      child: Row(
        children: <Widget>[
          Text(
            header,
            style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontFamily: "Merriweather",
                fontWeight: FontWeight.bold),
          ),
          Text(
            "$value",
            style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
                fontFamily: "RobotoSlab",
                fontStyle: FontStyle.italic),
          )
        ],
      ),
    );
  }

  getMonth(int month) {
    switch (month) {
      case 1:
        return "January";
      case 2:
        return "February";
      case 3:
        return "March";
      case 4:
        return "April";
      case 5:
        return "May";
      case 6:
        return "June";
      case 7:
        return "July";
      case 8:
        return "August";
      case 9:
        return "September";
      case 10:
        return "October";
      case 11:
        return "November";
      case 12:
        return "December";
      default:
        return "Does not exist!!";
    }
  }

  _isCompChange() {
      if(_animation.status == AnimationStatus.completed || _animation.status == AnimationStatus.forward){
        Future.delayed(Duration(milliseconds: 850),() => setState(() {
          isComp = true;
        }));

      }else if(_animation.status == AnimationStatus.reverse || _animation.status == AnimationStatus.dismissed){
        Future.delayed(Duration(milliseconds: 250),(){
          setState(() {
            isComp = false;
          });
        });
      }
  }

  _buildTrailer(List<Video> videos,double height,double width) {
    return Container(
      height: height*0.32,
      child: Padding(
        padding: EdgeInsets.only(left:height*0.005,right: height*0.005,top: height*0.005),
        child: ListView.builder(
          itemBuilder: (context,index){
            final trailer = videos[index];
            return trailer != null ? Padding(
              padding: EdgeInsets.only(left:height*0.005,bottom: height*0.03),
              child: Stack(
                children: <Widget>[
                  InkWell(
                    onTap: () => _launchURL("https://www.youtube.com/watch?v=${trailer.key}"),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 12,
                              spreadRadius: 6,
                              offset: Offset(-1,1),
                              color: Colors.black45
                          )
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        child: FadeInImage.assetNetwork(placeholder: "assets/loading.gif", image: "https://image.tmdb.org/t/p/original${widget.movie.backdropPath}",imageErrorBuilder: (context,object,stack){
                          return Image.asset("assets/error.gif",fit: BoxFit.cover,);
                        },
                          fit: BoxFit.cover,
                          fadeInDuration: Duration(milliseconds: 1000),
                          fadeInCurve: Curves.easeIn,),
                      ),
                      height: height*0.2,
                      width: width*0.4,
                    ),
                  ),
                  SizedBox(
                    width: width*0.02,
                  ),
                  Positioned(
                    left: width*0.11,
                    top: height*0.06,
                    child: InkWell(onTap: () => _launchURL("https://www.youtube.com/watch?v=${trailer.key}"),child: Icon(Icons.play_circle_outline,color: Colors.white,size: 64,)),
                  ),
                  Padding(
                    padding:EdgeInsets.only(top:height*0.07,left:width*0.45),
                    child: Text(
                      trailer.name,
                      style: GoogleFonts.yeonSung(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  )
                ],
              ),
            ): Center(
              child: Text(
                "Does not Have Any Trailer",
                style: GoogleFonts.robotoSlab(
                    color: Colors.black,
                    shadows: [
                      BoxShadow(
                          color: Colors.black54,
                          offset: Offset(-1,1),
                          spreadRadius: 6,
                          blurRadius: 12
                      )
                    ],
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                ),
              ),
            );
          },
          itemCount: videos.length,

        ),
      ),
    );
  }

   _likeFilm() async{
     final _userModel = Provider.of<UserViewModel>(context,listen: false);
     bool isLiked = await _userModel.likeFilm(_userModel.user.uid, widget.movie.id.toString());
     if(isLiked){
       debugPrint("Likelandı");
       await _getLikes();
     }else{
       debugPrint("Sıkıntı");
     }
   }
   _getLikes() async{
     final _userModel = Provider.of<UserViewModel>(context,listen: false);
     await _userModel.getLikes(_userModel.user.uid);
   }

  _checkIsLiked(String id){
    final _userModel = Provider.of<UserViewModel>(context);

    final likes = _userModel.likes;
    if(likes.length>0 || likes != null){
      for(int i = 0 ; i<likes.length;i++){
        if(likes[i] == id){
          return Icon(
            Icons.favorite,
            color: Colors.red,
            size: 32,
          );
        }else if(likes.length-1 == i){
          return Icon(
            Icons.favorite_border,
            color: Colors.red,
            size: 32,
          );
        }
        else{
          continue;
        }
      }
    }else{
      return Icon(
        Icons.favorite_border,
        color: Colors.red,
        size: 32,
      );
    }
  }
}
