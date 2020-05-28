import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:se380final/common/colors.dart';
import 'package:se380final/common/custom_navigator.dart';
import 'package:se380final/common/fadeAnimation.dart';
import 'package:se380final/common/font_style.dart';
import 'package:se380final/common/my_globals.dart';
import 'package:se380final/models/Movies/Film/movie.dart';
import 'package:se380final/models/result.dart';
import 'package:se380final/pages/error_page.dart';
import 'package:se380final/pages/movie_page.dart';
import 'package:se380final/viewModels/movieViewModel.dart';
class MovieList extends StatelessWidget {
  Result movies;
  String header;
  MovieList({this.header,this.movies});
  @override
  Widget build(BuildContext context) {
    final _movieModel = Provider.of<MovieViewModel>(context);
    return Scaffold(
      key: myGlobals.scaffoldKey,
      backgroundColor: bgColor,
      resizeToAvoidBottomPadding: false,
      body: LayoutBuilder(
        builder: (context,constraints){
          final height = constraints.maxHeight;
          final width = constraints.maxWidth;
          switch(_movieModel.state){
            case MovieState.LoadedMovie:
              return Stack(
                children: <Widget>[
                  Container(
                    height: height,
                    width: width,
                    color: bgColor,
                  ),
                  Positioned(
                    top: height * 0.04,
                    child: Container(
                      height: height * 0.2,
                      width: width,
                      child: FadeAnimation(
                        delay: 1.5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            getCategoryHeader(header, 48),
                            Divider(
                              color: Colors.white70,
                              indent: width * 0.1,
                              endIndent: width * 0.1,
                              height: height * 0.04,
                              thickness: height * 0.005,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: height*0.045,
                    left: width*0.01,
                    child: BounceInRight(
                      delay: Duration(milliseconds: 1200),
                      child: Center(
                        child: IconButton(
                          icon: Icon(Icons.arrow_back_ios,size: 32,color: Colors.white,),
                          onPressed: ()=> Navigator.pop(context),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: height*0.15,
                    child: Container(
                      width: width,
                      height: height*0.86,
                      child: ListView.builder(itemBuilder: (context,index){
                        final movie = movies.results;
                        return Padding(
                          padding:EdgeInsets.only(left: width*0.02),
                          child: FadeInDownBig(
                            delay: Duration(milliseconds: 1000),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                InkWell(
                                  onTap: ()=>_getMoviePage(context, movie[index].id),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(16)),
                                    child: FadeInImage(
                                      placeholder:
                                      AssetImage("assets/loading.gif"),
                                      image: NetworkImage(
                                          "${movie[index].posterPath}"),
                                      fit: BoxFit.cover,
                                      width:
                                      MediaQuery.of(context).size.width * 0.5,
                                      height: MediaQuery.of(context).size.height *
                                          0.35,
                                    ),
                                  ),
                                ),
                                SizedBox(width: width*0.05,),
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding:EdgeInsets.symmetric(vertical:height*0.03),
                                        child: Text(
                                          movie[index].title,
                                          style: GoogleFonts.montserrat(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                              shadows: [
                                                Shadow(
                                                    color: Colors.black45,
                                                    blurRadius: 12,
                                                    offset: Offset(-1,1)
                                                )
                                              ]
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Transform.rotate(angle: 2/4,child: Icon(Icons.star,color: Colors.white,size: 32,)),
                                          SizedBox(width: width*0.02,),
                                          Text(
                                            movie[index].voteAverage.toString(),
                                            style: GoogleFonts.montserrat(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700,
                                                shadows: [
                                                  Shadow(
                                                      color: Colors.black45,
                                                      blurRadius: 12,
                                                      offset: Offset(-1,1)
                                                  )
                                                ]
                                            ),
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding:EdgeInsets.only(left:width*0.1,bottom: height*0.08,top: height*0.11),
                                        child: InkWell(
                                          onTap: () => _getMoviePage(context,movie[index].id),
                                          child: Container(
                                            width: width*0.29,
                                            height: height*0.05,
                                            child: Row(
                                              children: <Widget>[
                                                Text(
                                                  "See Details",
                                                  style: GoogleFonts.montserrat(
                                                    color: Colors.white,
                                                    shadows: [
                                                      Shadow(
                                                          color: Colors.black45,
                                                          offset: Offset(-1,1),
                                                          blurRadius: 12
                                                      )
                                                    ],
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                SizedBox(width: width*0.01,),
                                                Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: Colors.white,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },scrollDirection: Axis.vertical,itemCount: movies.results.length,),
                    ),
                  )
                ],
              );
            case MovieState.LoadingMovie:
            case MovieState.InitialMovie:
              return Center(
                child: CircularProgressIndicator(),
              );
            case MovieState.ErrorMovie:
              return ErrorPage(title: "Movies List Error",);
            default:
              return Container();
          }
        },
      ),
    );
  }
  _getMoviePage(BuildContext context,int id) async{
    final _movieModel = Provider.of<MovieViewModel>(context,listen: false);
    Movie movie=await _movieModel.getMovieById(id);
    return await NavigatorUtils.pushPage(MoviePage(movie:movie), myGlobals.scaffoldKey.currentContext, Curves.easeIn, 1000, Alignment.center);
  }
}
