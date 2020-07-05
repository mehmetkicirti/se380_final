import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:se380final/common/colors.dart';
import 'package:se380final/common/custom_utils.dart';
import 'package:se380final/viewModels/movieViewModel.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController _search;
  String searchedValue = "";

  @override
  void initState() {
    super.initState();
    _search = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final _movieModel = Provider.of<MovieViewModel>(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: false,
        body: Stack(
          children: <Widget>[
            Container(
              height: height,
              width: width,
              color: bgColor,
            ),
            Positioned(
              height: height * 0.1,
              left: width * 0.02,
              right: width * 0.02,
              top: height * 0.02,
              child: Container(
                height: height * 0.1,
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black54,
                          blurRadius: 20,
                          offset: Offset(-1, 1),
                          spreadRadius: 6)
                    ]),
                width: width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    searchedValue != ""
                        ? IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              size: 32,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              debugPrint("Tıklandı");
                              setState(() {
                                searchedValue = "";
                              });
                              Navigator.pop(context);
                            },
                          )
                        : Container(),
                    Container(
                      width: width * 0.75,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        color: Colors.white,
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.search,
                              color: Colors.black54,
                              size: 28,
                            ),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16)))),
                        cursorColor: Colors.blue,
                        controller: _search,
                        keyboardType: TextInputType.text,
                        maxLines: 1,
                        onChanged: (value) async {
                          setState(() {
                            searchedValue = value;
                          });
                          searchedValue != null
                              ? await _movieModel
                                  .searchByName(searchedValue.split("=")[0])
                              : print(searchedValue.split("=")[0]);
                        },
                        showCursor: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if(_movieModel.state == MovieState.LoadingMovie)...[
              Center(
                child: Image(image: AssetImage("assets/transparent_loading.gif"),fit:BoxFit.cover ,),
              )
            ],
            if(_movieModel.state == MovieState.ErrorMovie)...[
              Center(
                  child: FadeInImage.assetNetwork(image: "https://media1.giphy.com/media/xTcf0WOsgPH90JeWkw/giphy.gif",placeholder: "assets/loading.gif",fit: BoxFit.cover,)
              )
            ],
            if (_movieModel.state == MovieState.LoadedMovie && _movieModel.resultSearch != null)...[
              Positioned(
                bottom: 0,
                child: Container(
                    width: width,
                    height: height*0.86,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: SingleChildScrollView(
                      child:searchedValue == "" ? Container() : CustomUtils.listSearchElements(height, width, context, Colors.transparent, 12,Colors.red,10,50, Axis.vertical, "movie")
                    )
                ),
              )
            ]
          ],
        ));
  }

  _getData(BuildContext context) async {
    final _movieModel = Provider.of<MovieViewModel>(context);
    await _movieModel.searchByName(searchedValue);
    setState(() {});
  }
}
