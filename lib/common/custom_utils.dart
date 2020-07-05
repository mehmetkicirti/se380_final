import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:se380final/common/custom_navigator.dart';
import 'package:se380final/models/Movies/Film/movie.dart';
import 'package:se380final/pages/error_page.dart';
import 'package:se380final/pages/movie_page.dart';
import 'package:se380final/viewModels/movieViewModel.dart';

class CustomUtils {
  static Widget getSearchTitle(
      String title, FontWeight fontWeight, Color color, EdgeInsets padding) {
    return Padding(
      padding: padding,
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
            fontWeight: fontWeight,
            fontStyle: FontStyle.italic,
            fontSize: 22,
            fontFamily: "RobotoSlab",
            shadows: [
              Shadow(color: color, offset: Offset(0, 2), blurRadius: 1)
            ],
            decoration: TextDecoration.underline),
      ),
    );
  }

  static Future<bool> onWillPop(BuildContext context) async {
    return (await showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text("Exit"),
                  content: Text("Do you want to Exit ?"),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text("No"),
                    ),
                    FlatButton(
                      onPressed: () => SystemChannels.platform
                          .invokeMethod('SystemNavigator.pop'),
                      child: Text("Yes"),
                    )
                  ],
                ))) ??
        false;
  }

  static Widget listSearchElements(
      double height,
      double width,
      BuildContext context,
      Color containerColor,
      double elevation,
      Color materialColor,
      double borderRadius,
      double materialBorderRadius,
      Axis direction,
      String mediaType) {
    final _movieModel = Provider.of<MovieViewModel>(context);
    _getMoviePage(id) async {
      Movie movie = await _movieModel.getMovieById(id);
      return NavigatorUtils.pushPage(
          movie == null ? ErrorPage(title: "Does Not Found",) : MoviePage(movie: movie,),
          context,
          Curves.easeInCirc,
          1000,
          Alignment.center);
    }

    return Container(
        width: width,
        height: height*0.86,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            color: containerColor),
        child: ListView.builder(
          itemBuilder: (context, index) {
            final movies = _movieModel.resultSearch.results
                .where((data) => data.mediaType == mediaType)
                .toList();
            return GestureDetector(
              onTap: () {
                _getMoviePage(movies[index].id);
              },
              child: Padding(
                padding:EdgeInsets.only(bottom: height*0.02),
                child: Material(
                  elevation: elevation,
                  borderRadius:
                  BorderRadius.all(Radius.circular(materialBorderRadius)),
                  color: materialColor,
                  animationDuration: Duration(milliseconds: 500),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(75),
                        child: FadeInImage(
                          placeholder: AssetImage(
                              (movies[index].profilePath != null ||
                                  movies[index].posterPath != null)
                                  ? "assets/loading.gif"
                                  : "assets/error.gif"),
                          image: NetworkImage(
                              "https://image.tmdb.org/t/p/original${mediaType == "person" ? movies[index].profilePath : movies[index].posterPath}"),
                          fit: BoxFit.fill,
                          height: height * 0.15,
                          width: width * 0.3,
                        ),
                      ),
                      SizedBox(
                        width: width*0.05,
                      ),
                      Expanded(
                        child: Text(
                          "${mediaType != "movie" ? movies[index].name : movies[index].title}",
                          style: GoogleFonts.robotoSlab(
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                  color: Colors.black,
                                  blurRadius: 12,
                                  offset: Offset(0, 2))
                            ],
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
          scrollDirection: direction,
          physics: ScrollPhysics(),
          padding: EdgeInsets.all(width * 0.02),
          itemCount: _movieModel.resultSearch.results
              .where((data) => data.mediaType == mediaType)
              .length,
        )
    );
  }
  static Widget getTitleAndViewAllButton(
    double height,
    String btnText,
    double btnSize,
    Color btnColor,
    Color textColor,
    double width,
    String textValue,
    double textSize,
    BuildContext context,
    Widget widget, {
    Color btnTextColor = Colors.white,
    String btnFamily = "RobotoSlab",
    String family = "RobotoSlab",
    Curve curve = Curves.easeIn,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          textValue.toUpperCase(),
          style: TextStyle(
              color: textColor,
              fontSize: textSize,
              fontFamily: family,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.combine([
                TextDecoration.underline,
                TextDecoration.underline,
              ]),
              shadows: [
                Shadow(
                    color: Colors.black, blurRadius: 12, offset: Offset(0, 25))
              ]),
        ),
        SizedBox(
          width: width * 0.455,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                PageRouteBuilder(
                    transitionDuration: Duration(milliseconds: 1000),
                    transitionsBuilder:
                        (context, animation, secAnimation, widget) {
                      animation =
                          CurvedAnimation(parent: animation, curve: curve);
                      return ScaleTransition(
                        child: widget,
                        scale: animation,
                        alignment: Alignment.topRight,
                      );
                    },
                    pageBuilder: (context, animation, secAnimation) {
                      return widget;
                    }));
          },
          child: Container(
            height: height * 0.05,
            width: width * 0.2,
            child: Center(
              child: Text(
                btnText,
                style: TextStyle(color: btnTextColor, fontFamily: btnFamily),
              ),
            ),
            decoration: BoxDecoration(
              color: btnColor,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 25), blurRadius: 30)
              ],
            ),
          ),
        )
      ],
    );
  }
}
