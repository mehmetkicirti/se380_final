import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_brand_icons/flutter_brand_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:se380final/common/colors.dart';
import 'package:se380final/common/custom_icon.dart';
import 'package:se380final/common/custom_stepper.dart';
import 'package:se380final/common/custom_text_form_field.dart';
import 'package:se380final/common/platform_sensitive_dialog.dart';
import 'package:se380final/models/User/users.dart';
import 'package:se380final/pages/error_page.dart';
import 'package:se380final/pages/home_page_core.dart';
import 'package:se380final/utils/formOptions.dart';
import 'package:se380final/viewModels/userViewModel.dart';

//class LoginPage extends StatefulWidget {
//  @override
//  _LoginPageState createState() => _LoginPageState();
//}
//
//class _LoginPageState extends State<LoginPage> {
//  final GlobalKey<FormState> _login_formKey = GlobalKey<FormState>();
//  String _email= "";
//  String _password = "";
//  bool IsSignUp = false;
//  @override
//  void dispose() {
//    super.dispose();
//  }
//  @override
//  Widget build(BuildContext context) {
//    final height = MediaQuery.of(context).size.height;
//    final width = MediaQuery.of(context).size.width;
//    return WillPopScope(
//      onWillPop: () => Future.value(false),
//      child: Scaffold(
//        resizeToAvoidBottomPadding: false,
//        resizeToAvoidBottomInset: false,
//        body: _builder(height,width),
//      ),
//    );
//  }
//  _onSavedEmail(String value) {
//    setState(() {
//      _email = value;
//    });
//  }
//  _onSavedPassword(String value) {
//    setState(() {
//      _password = value;
//    });
//  }
//
//  _signInWithGmail(BuildContext context) async{
//    final _userModel = Provider.of<UserViewModel>(context,listen: false);
//    User user = await _userModel.signInWithGoogle();
//    print("Authorized Google User Id : "+user.uid);
//  }
//
//  _signInWithAnonymously(BuildContext context) async{
//    final _userModel = Provider.of<UserViewModel>(context,listen: false);
//    User user = await _userModel.signInWithAnonymously();
//    print("Authorized Anonymously User Id : "+user.uid);
//  }
//
//  _signInWithFacebook(BuildContext context) {}
//
//  _getNavigatorPage(){
//    final _userModel = Provider.of<UserViewModel>(context,listen: false);
//    //_userModel.getLikes(_userModel.user.uid);
//    Future.delayed(Duration(milliseconds: 150),() async{
//      await Navigator.push(context, PageTransition(
//          type: PageTransitionType.fade,
//          child: HomepageCore()
//      ));
//    });
//  }
//
//  _builder(double height, double width) {
//    final _userModel = Provider.of<UserViewModel>(context,listen: false);
//    if(_userModel.state == UserState.LoadedUser){
//      if(_userModel.user == null){
//        return Stack(
//          children: <Widget>[
//            Container(
//              height: height,
//              width: double.infinity,
//              color:  bgColor,
//            ),
//            IsSignUp!=true?Positioned(
//              child: BounceInDown(
//                duration: Duration(milliseconds: 1000),
//                child: Container(
//                  width: width,
//                  height: height*0.6,
//                  child: Form(
//                    key: _login_formKey,
//                    autovalidate: true,
//                    child: Column(
//                      crossAxisAlignment: CrossAxisAlignment.start,
//                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                      children: <Widget>[
//                        SizedBox(height: height*0.10,),
//                        CustomTextFormField(
//                          padding: 8,
//                          cursorColor: Colors.white,
//                          radius: 20,
//                          radiusCursor: 5,
//                          validator: (value)=>FormOptions.validateEmail(value),
//                          textColor: Colors.white,
//                          iconSize: 30,
//                          hintColor: Colors.white,
//                          hintText: "Please enter a valid email",
//                          iconColor: Colors.white,
//                          labelText: "Email",
//                          labelColor: Colors.white,
//                          onSaved: (value) =>_onSavedEmail(value),
//                          enabledBorderColor: Colors.white,
//                          inputType: TextInputType.emailAddress,
//                          prefixIcon: Icons.email,
//                        ),
//                        CustomTextFormField(
//                          padding: 8,
//                          cursorColor: Colors.white,
//                          radius: 20,
//                          radiusCursor: 5,
//                          textColor: Colors.white,
//                          validator: (value)=>FormOptions.validatePassword(value),
//                          iconSize: 30,
//                          hintColor: Colors.white,
//                          hintText: "Please enter a valid password",
//                          iconColor: Colors.white,
//                          labelText: "Password",
//                          suffixIcon: true,
//                          labelColor: Colors.white,
//                          onSaved: (value) =>_onSavedPassword(value),
//                          enabledBorderColor: Colors.white,
//                          inputType: TextInputType.visiblePassword,
//                          prefixIcon: Icons.vpn_key,
//                        ),
//                        InkWell(
//                          onTap: (){
//                            if(this._login_formKey.currentState.validate()){
//                              _login_formKey.currentState.save();
//                              print("$_email $_password");
//                            }
//                          },
//                          child: Container(
//                            margin: EdgeInsets.symmetric(horizontal: width*0.2),
//                            width: width*0.6,
//                            height: height*0.06,
//                            decoration: BoxDecoration(
//                                borderRadius: BorderRadius.circular(50),
//                                boxShadow: [
//                                  BoxShadow(
//                                      color: Colors.black12,
//                                      offset: Offset(-1,10),
//                                      blurRadius: 0.7,
//                                      spreadRadius: 0.4
//                                  )
//                                ],color: Colors.white
//                            ),
//                            child: Center(
//                              child: Text(
//                                "LOGIN",
//                                style: TextStyle(
//                                    color: info,
//                                    fontSize: 20
//                                ),
//                              ),
//                            ),
//                          ),
//                        )
//                      ],
//                    ),
//                  ),
//                  decoration: BoxDecoration(
//                      gradient: LinearGradient(
//                          colors: [
//                            Color.fromARGB(145, 26, 236, 235),
//                            Color.fromARGB(255, 236, 215, 235)
//                          ],begin: Alignment.topCenter,end: Alignment.bottomCenter
//                      ),
//                      boxShadow: [
//                        BoxShadow(
//                            offset: Offset(1,10),
//                            color: Colors.black54,
//                            blurRadius: 1,
//                            spreadRadius: 1
//                        )
//                      ],
//                      borderRadius: BorderRadius.only(
//                        bottomLeft: Radius.circular(25),
//                        bottomRight: Radius.circular(25),
//                      )
//                  ),
//                ),
//              ),
//            ):CustomStepper(
//              height: height,
//              width: width,
//            ),
//            ElasticIn(
//              duration: Duration(seconds: 1),
//              child: Padding(
//                padding: EdgeInsets.symmetric(vertical: height*0.05),
//                child: Align(
//                  alignment: Alignment.topCenter,
//                  child: FadeIn(
//                    duration: Duration(seconds: 1),
//                    delay: Duration(milliseconds: 500),
//                    child: Text(
//                      IsSignUp?"Sign Up":"Sign In",
//                      style: TextStyle(
//                        color: Colors.white,
//                        fontSize: 48,
//                        fontFamily: "YeonSung",
//                        fontStyle: FontStyle.italic,
//                        shadows: [
//                          Shadow(
//                            color: Colors.black,
//                            offset: Offset(1,4),
//                            blurRadius: 0.3,
//                          )
//                        ],
//                        wordSpacing: 2,
//                      ),
//                    ),
//                  ),
//                ),
//              ),
//            ),
//            IsSignUp?Positioned(
//              bottom: height*0.02,left: width*0.2,right: width*0.2,
//              child: Bounce(
//                infinite: true,
//                duration: Duration(milliseconds: 1000),
//                delay: Duration(milliseconds: 500),
//                child: InkWell(
//                  onTap: (){
//                    setState(() {
//                      IsSignUp = false;
//                    });
//                  },
//                  child: Container(
//                    margin: EdgeInsets.symmetric(horizontal: width*0.1),
//                    width: width*0.6,
//                    height: height*0.07,
//                    decoration: BoxDecoration(
//                        borderRadius: BorderRadius.circular(50),
//                        boxShadow: [
//                          BoxShadow(
//                              color: Colors.black12,
//                              offset: Offset(-1,10),
//                              blurRadius: 0.7,
//                              spreadRadius: 0.4
//                          )
//                        ],color: Colors.white
//                    ),
//                    child: Center(
//                      child: Text(
//                          "Turn Back"
//                          ,style: TextStyle(
//                          fontSize: 30,
//                          wordSpacing: 3,
//                          color: info,
//                          shadows: [
//                            Shadow(
//                              color: Colors.black,
//                              offset: Offset(0.3,1),
//                              blurRadius: 0.7,
//                            )
//                          ],
//                          fontFamily: "Merriweather",
//                          fontStyle: FontStyle.italic,
//                          fontWeight: FontWeight.bold
//                      )),
//                    ),
//                  ),
//                ),
//              ),
//            ):Positioned(bottom: height*0.02,left: width*0.15,child:Column(
//              children: <Widget>[
//                ElasticInLeft(
//                  duration: Duration(milliseconds: 1000),
//                  child: Text("- OR -",style: TextStyle(
//                    fontSize: 22,
//                    wordSpacing: 3,
//                    color: Colors.white,
//                    shadows: [
//                      Shadow(
//                        color: Colors.black,
//                        offset: Offset(1,3),
//                        blurRadius: 0.7,
//                      )
//                    ],
//                    fontStyle: FontStyle.italic,
//                    fontWeight: FontWeight.bold,
//                  ),),
//                ),
//                SizedBox(height: 20,),
//                ElasticInRight(
//                  duration: Duration(milliseconds: 1000),
//                  child: Text("Sign in with",style: TextStyle(
//                    fontSize: 18,
//                    wordSpacing: 3,
//                    color: Colors.white,
//                    shadows: [
//                      Shadow(
//                        color: Colors.black,
//                        offset: Offset(1,3),
//                        blurRadius: 0.7,
//                      )
//                    ],
//                  ),),
//                ),
//                SizedBox(height: height*0.05),
//                Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                  children: <Widget>[
//                    FadeInLeft(
//                      duration: Duration(milliseconds: 1000),
//                      delay: Duration(milliseconds: 500),
//                      child: InkWell(
//                          onTap: ()=>_signInWithFacebook(context),
//                          child:CustomIconCreator(
//                            icon: BrandIcons.facebook,
//                            context: context,
//                          )
//                      ),
//                    ),
//                    SizedBox(
//                      width: width*0.05,
//                    ),
//                    FadeInRight(
//                      duration: Duration(milliseconds: 1000),
//                      delay: Duration(milliseconds: 500),
//                      child: InkWell(
//                        onTap: ()=>_signInWithGmail(context),
//                        child: CustomIconCreator(
//                          context: context,
//                          icon: BrandIcons.gmail,
//                          iconColor: Colors.redAccent,
//                        ),
//                      ),
//                    ),
//                    SizedBox(
//                      width: width*0.05,
//                    ),
//                    FadeInRight(
//                      duration: Duration(milliseconds: 1000),
//                      delay: Duration(milliseconds: 500),
//                      child: InkWell(
//                        onTap: ()=>_signInWithAnonymously(context),
//                        child: CustomIconCreator(
//                          context: context,
//                          icon: Icons.person,
//                          iconColor: Colors.redAccent,
//                        ),
//                      ),
//                    )
//                  ],
//                ),
//                SizedBox(
//                  height: height*0.1,
//                ),
//                BounceInDown(
//                  duration: Duration(milliseconds: 1500),
//                  delay: Duration(milliseconds: 500),
//                  child: InkWell(
//                    onTap: (){
//                      setState(() {
//                        IsSignUp=true;
//                      });
//                    },
//                    child: Row(
//                      children: <Widget>[
//                        Text(
//                          "Don't have an Account?"
//                          ,style: TextStyle(
//                          fontSize: 18,
//                          wordSpacing: 3,
//                          color: Colors.white,
//                          shadows: [
//                            Shadow(
//                              color: Colors.black,
//                              offset: Offset(0.3,1),
//                              blurRadius: 0.7,
//                            )
//                          ],
//                          fontFamily: "Merriweather",
//                          fontStyle: FontStyle.italic,
//                        ),
//                        ),
//                        Text(
//                          " Sign up"
//                          ,style: TextStyle(
//                            fontSize: 20,
//                            wordSpacing: 3,
//                            color: Colors.white,
//                            shadows: [
//                              Shadow(
//                                color: Colors.black,
//                                offset: Offset(0.3,1),
//                                blurRadius: 0.7,
//                              )
//                            ],
//                            fontFamily: "Merriweather",
//                            fontStyle: FontStyle.italic,
//                            fontWeight: FontWeight.bold
//                        ),
//                        )
//                      ],
//                    ),
//                  ),
//                )
//              ],
//            ))
//          ],
//        );
//      }else{
//        return _getNavigatorPage();
//      }
//    }else if(_userModel.state == UserState.ErrorUser){
//      return ErrorPage(title:"Error User");
//    }else{
//      return Center(
//        child: CircularProgressIndicator(backgroundColor: bgColor,),
//      );
//    }
//  }
//}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _login_formKey = GlobalKey<FormState>();
  String _email = "";
  String _password = "";
  bool IsSignUp = false;
  bool _autofocus=false;
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: false,
        body: Container(
          width: width,
          height: height,
          child: _buildPage(height, width),
        ),
      ),
    );
  }

  _onSavedEmail(String value) {
    setState(() {
      _email = value;
    });
  }

  _onSavedPassword(String value) {
    setState(() {
      _password = value;
    });
  }

  _signInWithGmail(BuildContext context) async {
    final _userModel = Provider.of<UserViewModel>(context, listen: false);
    User user = await _userModel.signInWithGoogle();
    print("Authorized Google User Id : " + user.uid);
  }



  _signInWithAnonymously(BuildContext context) async {
    final _userModel = Provider.of<UserViewModel>(context, listen: false);
    User user = await _userModel.signInWithAnonymously();
    print("Authorized Anonymously User Id : " + user.uid);
  }

  _signInWithFacebook(BuildContext context) async {
    final _userModel = Provider.of<UserViewModel>(context, listen: false);
    User user = await _userModel.signInWithFacebook();

    print("Authorized Facebook User Id : " + user.uid);
  }

  _getNavigatorPage() {
    Future.delayed(Duration(milliseconds: 150), () async{
      await Navigator.pushReplacement(context,
          PageTransition(type: PageTransitionType.fade, child: HomepageCore()));
    });
  }

  _buildPage(double height, double width){
    final _userModel = Provider.of<UserViewModel>(context);
    if(_userModel.state == UserState.LoadedUser){
      if(_userModel.user == null){
        return Stack(
          children: <Widget>[
            Container(
              height: height,
              width: double.infinity,
              color:  bgColor,
            ),
            IsSignUp!=true?Positioned(
              child: BounceInDown(
                duration: Duration(milliseconds: 1000),
                child: Container(
                  width: width,
                  height: height*0.6,
                  child: Form(
                    key: _login_formKey,
                    autovalidate: true,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        SizedBox(height: height*0.10,),
                        CustomTextFormField(
                          padding: 8,
                          cursorColor: Colors.white,
                          radius: 20,
                          radiusCursor: 5,
                          validator: (value)=>FormOptions.validateEmail(value),
                          textColor: Colors.white,
                          iconSize: 30,
                          hintColor: Colors.white,
                          hintText: "Please enter a valid email",
                          iconColor: Colors.white,
                          labelText: "Email",
                          labelColor: Colors.white,
                          onSaved: (value) =>_onSavedEmail(value),
                          enabledBorderColor: Colors.white,
                          inputType: TextInputType.emailAddress,
                          prefixIcon: Icons.email,
                          autoFocus: _autofocus
                        ),
                        CustomTextFormField(
                          padding: 8,
                          cursorColor: Colors.white,
                          radius: 20,
                          radiusCursor: 5,
                          textColor: Colors.white,
                          validator: (value)=>FormOptions.validatePassword(value),
                          iconSize: 30,
                          hintColor: Colors.white,
                          hintText: "Please enter a valid password",
                          iconColor: Colors.white,
                          labelText: "Password",
                          suffixIcon: true,
                          labelColor: Colors.white,
                          onSaved: (value) =>_onSavedPassword(value),
                          enabledBorderColor: Colors.white,
                          inputType: TextInputType.visiblePassword,
                          prefixIcon: Icons.vpn_key,
                        ),
                        InkWell(
                          onTap: () async{
                            if(this._login_formKey.currentState.validate()){
                              _login_formKey.currentState.save();
                              await _signInEmail();
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: width*0.2),
                            width: width*0.6,
                            height: height*0.06,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black12,
                                      offset: Offset(-1,10),
                                      blurRadius: 0.7,
                                      spreadRadius: 0.4
                                  )
                                ],color: Colors.white
                            ),
                            child: Center(
                              child: Text(
                                "LOGIN",
                                style: GoogleFonts.yeonSung(
                                    color: info,
                                    fontSize: 20
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(145, 26, 236, 235),
                            Color.fromARGB(255, 236, 215, 235)
                          ],begin: Alignment.topCenter,end: Alignment.bottomCenter
                      ),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(1,10),
                            color: Colors.black54,
                            blurRadius: 1,
                            spreadRadius: 1
                        )
                      ],
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                      )
                  ),
                ),
              ),
            ):CustomStepper(
              height: height,
              width: width,
              isChanged: (){
                setState(() {
                  IsSignUp = false;
                });
              },
            ),
            ElasticIn(
              duration: Duration(seconds: 1),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: height*0.05),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: FadeIn(
                    duration: Duration(seconds: 1),
                    delay: Duration(milliseconds: 500),
                    child: Text(
                      IsSignUp?"Sign Up":"Sign In",
                      style: GoogleFonts.yeonSung(
                        color: Colors.white,
                        fontSize: 48,
                        fontStyle: FontStyle.italic,
                        shadows: [
                          Shadow(
                            color: Colors.black,
                            offset: Offset(1,4),
                            blurRadius: 0.3,
                          )
                        ],
                        wordSpacing: 2,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            IsSignUp?Positioned(
              bottom: height*0.02,left: width*0.2,right: width*0.2,
              child: Bounce(
                infinite: true,
                duration: Duration(milliseconds: 1000),
                delay: Duration(milliseconds: 500),
                child: InkWell(
                  onTap: (){
                    setState(() {
                      IsSignUp = false;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: width*0.1),
                    width: width*0.6,
                    height: height*0.07,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              offset: Offset(-1,10),
                              blurRadius: 0.7,
                              spreadRadius: 0.4
                          )
                        ],color: Colors.white
                    ),
                    child: Center(
                      child: Text(
                          "Turn Back"
                          ,style: TextStyle(
                          fontSize: 30,
                          wordSpacing: 3,
                          color: info,
                          shadows: [
                            Shadow(
                              color: Colors.black,
                              offset: Offset(0.3,1),
                              blurRadius: 0.7,
                            )
                          ],
                          fontFamily: "Merriweather",
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold
                      )),
                    ),
                  ),
                ),
              ),
            ):Positioned(bottom: height*0.02,left: width*0.15,child:Column(
              children: <Widget>[
                ElasticInLeft(
                  duration: Duration(milliseconds: 1000),
                  child: Text("- OR -",style: TextStyle(
                    fontSize: 22,
                    wordSpacing: 3,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        offset: Offset(1,3),
                        blurRadius: 0.7,
                      )
                    ],
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),),
                ),
                SizedBox(height: 20,),
                ElasticInRight(
                  duration: Duration(milliseconds: 1000),
                  child: Text("Sign in with",style: TextStyle(
                    fontSize: 18,
                    wordSpacing: 3,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        offset: Offset(1,3),
                        blurRadius: 0.7,
                      )
                    ],
                  ),),
                ),
                SizedBox(height: height*0.05),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FadeInLeft(
                      duration: Duration(milliseconds: 1000),
                      delay: Duration(milliseconds: 500),
                      child: InkWell(
                          onTap: ()=>_signInWithFacebook(context),
                          child:CustomIconCreator(
                            icon: BrandIcons.facebook,
                            context: context,
                          )
                      ),
                    ),
                    SizedBox(
                      width: width*0.05,
                    ),
                    FadeInRight(
                      duration: Duration(milliseconds: 1000),
                      delay: Duration(milliseconds: 500),
                      child: InkWell(
                        onTap: ()=>_signInWithGmail(context),
                        child: CustomIconCreator(
                          context: context,
                          icon: BrandIcons.gmail,
                          iconColor: Colors.redAccent,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width*0.05,
                    ),
                    FadeInRight(
                      duration: Duration(milliseconds: 1000),
                      delay: Duration(milliseconds: 500),
                      child: InkWell(
                        onTap: ()=>_signInWithAnonymously(context),
                        child: CustomIconCreator(
                          context: context,
                          icon: Icons.person,
                          iconColor: Colors.redAccent,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: height*0.1,
                ),
                BounceInDown(
                  duration: Duration(milliseconds: 1500),
                  delay: Duration(milliseconds: 500),
                  child: InkWell(
                    onTap: (){
                      setState(() {
                        IsSignUp=true;
                      });
                    },
                    child: Row(
                      children: <Widget>[
                        Text(
                          "Don't have an Account?"
                          ,style: TextStyle(
                          fontSize: 18,
                          wordSpacing: 3,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              color: Colors.black,
                              offset: Offset(0.3,1),
                              blurRadius: 0.7,
                            )
                          ],
                          fontFamily: "Merriweather",
                          fontStyle: FontStyle.italic,
                        ),
                        ),
                        Text(
                          " Sign up"
                          ,style: TextStyle(
                            fontSize: 20,
                            wordSpacing: 3,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                color: Colors.black,
                                offset: Offset(0.3,1),
                                blurRadius: 0.7,
                              )
                            ],
                            fontFamily: "Merriweather",
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold
                        ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ))
          ],
        );
      }else{
        return _getNavigatorPage();
      }
    }else if(_userModel.state == UserState.ErrorUser){
      return ErrorPage(title: "Error : Already have user",);
    }else{
      return Center(
        child: CircularProgressIndicator(backgroundColor: Colors.blueGrey,),
      );
    }
  }

  _signInEmail() async{
    final _userModel = Provider.of<UserViewModel>(context,listen: false);
    try{
      _userModel.signInWithEmailAndPassword(_email, _password).then((user){
        _getNavigatorPage();
      });
    }on PlatformException catch(e){
      debugPrint("Widget Hata Yakalandı ${e.message}");
      showDialog(context: context,builder: (context){
        return PlatformSensitiveDialog(
          header: "Error",
          message: e.message,
          mainButtonWords: "OK",
        );
      },barrierDismissible: false);
      _login_formKey.currentState.reset();
      setState(() {
        _autofocus = true;
      });
    }
  }
}
