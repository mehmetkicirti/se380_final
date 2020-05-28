import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:se380final/common/custom_platform_widget.dart';

class PlatformSensitiveDialog extends CustomPlatformWidget{

  final String header;
  final String message;
  final String cancelButtonWords;
  final String mainButtonWords;

  PlatformSensitiveDialog({@required this.header, @required this.message, this.cancelButtonWords,@required this.mainButtonWords});


  @override
  Widget buildAndroidWidget(BuildContext context) {
    return AlertDialog(
      title: Text(header),
      content: Text(message),
      elevation: 12,
      actions: _buildDialogButtons(context),
    );
  }

  @override
  Widget buildIOSWidget(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(header),
      content: Text(message),
      actions: _buildDialogButtons(context),
    );
  }

  _buildDialogButtons(BuildContext context) {
    final allButton = <Widget>[];

    if(Platform.isIOS){
      if(cancelButtonWords != null){
        allButton.add(CupertinoDialogAction(
          child: Text(cancelButtonWords),
          onPressed: (){

          },
        ));
      }
      allButton.add(CupertinoDialogAction(
        child: Text(mainButtonWords),
        onPressed: (){
          Navigator.pop(context);
        },
      )
      );
    }else{
      if(cancelButtonWords != null){
        allButton.add(FlatButton(
          child: Text(cancelButtonWords),
          onPressed: (){

          },
        ));
      }
      allButton.add(FlatButton(
        child: Text(mainButtonWords),
        onPressed: (){
          Navigator.pop(context);
        },
      )
      );
    }
    return allButton;
  }

}