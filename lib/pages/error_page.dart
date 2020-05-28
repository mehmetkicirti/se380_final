import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:se380final/common/colors.dart';
import 'package:se380final/common/custom_utils.dart';

class ErrorPage extends StatelessWidget {
  String title;
  ErrorPage({@required this.title});
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => CustomUtils.onWillPop(context),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          color: bgColor,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //IconButton(icon: Icon(Icons.arrow_back_ios),color: Colors.white,onPressed: ()=>Navigator.pop(context),),
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.2),
                  child: FadeInImage.assetNetwork(image: "https://media1.giphy.com/media/xTcf0WOsgPH90JeWkw/giphy.gif",placeholder: "assets/transparent_loading.gif",fit: BoxFit.cover,)
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.05),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      title.toUpperCase(),
                      style: GoogleFonts.montserrat(
                        fontSize: 32,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            color: Colors.black45,
                            offset: Offset(-1,1),
                            blurRadius: 12
                          ),
                        ],
                        fontWeight: FontWeight.w700
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
