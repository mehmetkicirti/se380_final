import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:se380final/common/colors.dart';
import 'package:se380final/common/platform_sensitive_dialog.dart';
import 'package:se380final/models/User/users.dart';
import 'package:se380final/pages/error_page.dart';
import 'package:se380final/pages/login_page.dart';
import 'package:se380final/utils/formOptions.dart';
import 'package:se380final/viewModels/userViewModel.dart';

class CustomStepper extends StatefulWidget {
  final double height;
  final double width;
  Function isChanged;
  CustomStepper({this.height, this.width,this.isChanged});

  @override
  _CustomStepperState createState() => _CustomStepperState();
}

class _CustomStepperState extends State<CustomStepper> {
  var key0 = GlobalKey<FormFieldState>();
  var key1 = GlobalKey<FormFieldState>();
  var key2 = GlobalKey<FormFieldState>();
  List<Step> _allSteps;
  bool error = false;
  int _activeStep = 0;
  String _name = "";
  String _email= "";
  String _password = "";

  @override
  Widget build(BuildContext context) {
    _allSteps = _steps();
    return Positioned(
      top: widget.height*0.15,
      left: widget.width*0.009,
      right: widget.width*0.009,
      child: BounceInRight(
        duration: Duration(milliseconds: 1000),
        delay: Duration(milliseconds: 500),
        child: Container(
          width: widget.width,
          height: widget.height*0.5,
          child: SingleChildScrollView(
            child: Theme(
              data:ThemeData(
                  accentColor: Colors.red
              ),
              child: Stepper(
                physics: ClampingScrollPhysics(),
                type: StepperType.vertical,
                controlsBuilder:(BuildContext context,{VoidCallback  onStepContinue, VoidCallback  onStepCancel}){
                  return Row(
                    children: <Widget>[
                      RaisedButton(
                        color: success,
                        elevation: 10,
                        onPressed: onStepContinue,
                        child:Text(_activeStep==2?"SignUp":"Continue!",style: TextStyle(color: Colors.white,fontSize: 16),),
                      ),
                      SizedBox(width: 30,),
                      RaisedButton(
                        onPressed:_activeStep==0 ?null:onStepCancel,
                        color: danger,
                        child: Text("Back!",style: TextStyle(color: Colors.white,fontSize: 16)),
                      )
                    ],
                  );
                },
                currentStep: _activeStep,
                steps: _allSteps,
                onStepContinue: (){
                  setState(() {
                    _nextStateControl();
                  });
                },
                onStepCancel: (){
                  setState(() {
                    _activeStep>0 ? _activeStep-- : _activeStep = 0 ;
                  });
                },
              ),
            ),
          ),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 236, 215, 235),
                    Color.fromARGB(145, 26, 236, 235)
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
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                  topLeft: Radius.elliptical(20, 30),
                  topRight: Radius.elliptical(20, 30)
              )
          ),
        ),
      ),
    );
  }
  List<Step> _steps(){
    List<Step> stepler = [
      Step(
        title: Text("Name",style: TextStyle(color: Colors.white,fontSize: 18,fontFamily: "Merriweather",fontWeight: FontWeight.bold),),
        state: _configureState(0),
        isActive: true,
        content: TextFormField(
          style: TextStyle(
              color: Colors.white
          ),
          key: key0,
          decoration: InputDecoration(
            labelText: "Name",
            prefixIcon: Icon(
                Icons.person
            ),
            errorStyle: TextStyle(
                fontSize: 18
            ),
            hintText: "Please enter a name",
            border: OutlineInputBorder(
            ),
          ),
          validator: (value) => FormOptions.validateName(value),
          onSaved: (value) {
            _name = value;
          },
        ),
      ),
      Step(
        title: Text("Email",style: TextStyle(color: Colors.white,fontSize: 18,fontFamily: "Merriweather",fontWeight: FontWeight.bold),),
        state: _configureState(1),
        isActive: true,
        content: TextFormField(
          keyboardType: TextInputType.emailAddress,
          key: key1,
          decoration: InputDecoration(
              labelText: "Email",
              prefixIcon: Icon(
                  Icons.alternate_email
              ),
              hintText: "you@example.com",
              errorStyle: TextStyle(
                  fontSize: 18
              ),
              border: OutlineInputBorder()),
          validator: (value) => FormOptions.validateEmail(value),

          onSaved: (value) {
            _email = value;
          },
        ),
      ),
      Step(
        title: Text("Password",style: TextStyle(color: Colors.white,fontSize: 18,fontFamily: "Merriweather",fontWeight: FontWeight.bold)),
        state: _configureState(2),
        isActive: true,
        content: TextFormField(
          key: key2,
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
          decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.vpn_key,
              ),
              errorStyle: TextStyle(
                  fontSize: 18
              ),
              labelText: "Password",
              hintText: "Please enter a password",
              border: OutlineInputBorder()),
          validator: (value) => FormOptions.validatePassword(value),
          onSaved: (value) {
            _password = value;
          },
        ),
      ),
    ];
    return stepler;
  }
  StepState _configureState(int activeStep){
    if (_activeStep == activeStep) {
      if (error) {
        return StepState.error;
      } else {
        return StepState.editing;
      }
    } else
      return StepState.complete;
  }
  void _nextStateControl(){
    switch (_activeStep) {
      case 0:
        if (key0.currentState.validate()) {
          key0.currentState.save();
          error = false;
          _activeStep= 1;
        } else {
          error = true;
        }
        break;

      case 1:
        if (key1.currentState.validate()) {
          key1.currentState.save();
          error = false;
          _activeStep = 2;
        } else {
          error = true;
        }
        break;

      case 2:
        if (key2.currentState.validate()) {
          key2.currentState.save();
          error = false;
          _activeStep = 2;
          formCompleted();
        } else {
          error = true;
        }
        break;
    }
  }
  formCompleted() async{
    final _userModel = Provider.of<UserViewModel>(context,listen: false);
    try{
      User user =await _userModel.createUserWithEmailAndPassword(_email, _password);
      if(user!= null){
        await _userModel.signOut();
        widget.isChanged();
      }
    }on PlatformException catch(e){
      debugPrint("Widget Hata Yakalandı ${e.message}");
      showDialog(context: context,builder: (context){
        return PlatformSensitiveDialog(
          header: "Error",
          message: e.message,
          mainButtonWords: "OK",
        );
      },barrierDismissible: false);
    }
  }
}
