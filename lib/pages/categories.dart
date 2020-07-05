import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:se380final/common/category_card.dart';
import 'package:se380final/common/colors.dart';
import 'package:se380final/common/fadeAnimation.dart';
import 'package:se380final/common/font_style.dart';
import 'package:se380final/pages/category_list.dart';
import 'package:se380final/pages/error_page.dart';
import 'package:se380final/viewModels/movieViewModel.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int pages = 1;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: bgColor,
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      body: Container(
        height: height,
        width: width,
        child: _buildPage(height, width),
      ),
    );
  }

  List<String> filmCategoryURL = [
    "assets/categoryImages/Action-Movies.png",
    "assets/categoryImages/Adventure-Movies.png",
    "assets/categoryImages/Animated-Movies.png",
    "assets/categoryImages/Comedy-Movies.png",
    "assets/categoryImages/Crime-Movies.png",
    "assets/categoryImages/Documentaries.png",
    "assets/categoryImages/Drama-Movies.png",
    "assets/categoryImages/Family-Movies.png",
    "assets/categoryImages/Fantasy-Movies.png",
    "assets/categoryImages/Historic-Movies.png",
    "assets/categoryImages/Horror-Movies.png",
    "assets/categoryImages/Musical-Movies.png",
    "assets/categoryImages/Mystery.png",
    "assets/categoryImages/Romantic-Movies.png",
    "assets/categoryImages/Sci-Fi-Movies.png",
    "assets/categoryImages/TV-Shows.png",
    "assets/categoryImages/Thriller-Movies.png",
    "assets/categoryImages/War-Movies.png",
    "assets/categoryImages/Western-Movies.png",
  ];

  _getFilmsByGenre(int id, int pages) async {
    final movieModel = Provider.of<MovieViewModel>(context, listen: false);
    await movieModel.getFilmsByGenreId(id, pages);
  }

  _getPagesWithGenre() {
    final movieModel = Provider.of<MovieViewModel>(context, listen: false);
    Future.delayed(Duration(milliseconds: 150), () async {
        await Navigator.pushReplacement(_scaffoldKey.currentContext,
            MaterialPageRoute(builder: (context)=>CategoryList(header: "Category List",movies: movieModel.filmsByGenre),fullscreenDialog: true));
    });
  }

  _buildPage(double height, double width) {
    final category = Provider.of<MovieViewModel>(context);
    switch (category.state) {
      case MovieState.LoadingMovie:
        return Center(
          child: CircularProgressIndicator(),
        );
      case MovieState.LoadedMovie:
      case MovieState.InitialMovie:
        if (category.filmsByGenre != null) {
          return _getPagesWithGenre();
        }
        return Padding(
          padding: EdgeInsets.only(left: width * 0.01),
          child: Stack(
            //FUTURE Builder should be in here.
            children: <Widget>[
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
                        getCategoryHeader("Categories", 48),
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
              category.state == MovieState.LoadedMovie
                  ? Positioned(
                      top: height * 0.17,
                      child: Container(
                        height: height * .85,
                        width: width,
                        child: GridView.builder(
                          itemCount: category.category.genres.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 16 / 10,
                                  crossAxisSpacing: width * 0.025,
                                  mainAxisSpacing: width * 0.025),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () async {
                                await _getFilmsByGenre(
                                    category.category.genres[index].id, pages);
                              },
                              child: CategoryCard(
                                title: category.category.genres[index].name,
                                imgUrl: filmCategoryURL[index],
                              ),
                            );
                          },
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          scrollDirection: Axis.vertical,
                        ),
                      ))
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
            ],
          ),
        );
      case MovieState.NotConnected:
      case MovieState.ErrorMovie:
      default:
        return ErrorPage(title: "Error Category Page");
    }
  }


}
