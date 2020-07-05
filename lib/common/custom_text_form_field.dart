import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class CustomTextFormField extends StatefulWidget{
  final double padding;
  final Key key;
  final String initialValue;
  FormFieldSetter<String> onSaved;
  FormFieldValidator<String> validator;
  final TextInputType inputType;
  bool hiddenText;
  final IconData prefixIcon;
  final Color iconColor;
  final double iconSize;
  final String labelText;
  final String hintText;
  final Color hintColor;
  final Color labelColor;
  final double radius;
  final Color suffixColor;
  final double radiusCursor;
  final Color enabledBorderColor;
  final Color cursorColor;
  final bool autoValidate;
  final Color textColor;
  bool enabledBorder;
  final bool suffixIcon;
  bool autoFocus;
  CustomTextFormField(
      {this.suffixIcon: false,this.textColor:Colors.black,this.suffixColor:Colors.white, this.key, @required this.padding, this.hintText, this.onSaved, this.initialValue,
        this.validator, this.inputType, this.hiddenText: true, this.prefixIcon,
        this.iconColor: Colors
            .white, this.iconSize, this.labelText, this.hintColor,
        this.labelColor: Colors
            .white, this.radius: 10, this.radiusCursor,
        this.enabledBorderColor, this.enabledBorder,this.cursorColor, this.autoValidate:false,
        this.autoFocus:false
      });

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {

  @override
  Widget build(BuildContext context) {
    return _buildTextField();
  }
  Widget _buildTextField(){
    return Padding(
      padding: EdgeInsets.all(widget.padding),
      child: TextFormField(
        autofocus: widget.autoFocus,
        onSaved:widget.onSaved,
        initialValue: widget.initialValue,
        keyboardType: widget.inputType,
        obscureText: widget.hiddenText,
        showCursor: true,
        cursorWidth: 3,
        autovalidate: widget.autoValidate,
        cursorColor: widget.cursorColor,
        cursorRadius: Radius.circular(widget.radiusCursor),
        decoration: InputDecoration(
          icon:Icon(
            widget.prefixIcon,
            color: widget.iconColor,
            size: widget.iconSize,
          ),
          labelText:widget.labelText,
          labelStyle: GoogleFonts.montserrat(
              fontSize: 19,
              color: widget.labelColor
          ),
          suffixIcon: widget.suffixIcon != false ? IconButton(
              onPressed:(){
                setState(() {
                  widget.hiddenText = widget.hiddenText != false ? false:true;
                });
              },
              icon: widget.hiddenText != true ?
              Icon(Icons.remove_red_eye,color: widget.suffixColor,)
                  :Icon(Icons.remove_red_eye,color: Colors.grey)
          ):null,

          hintStyle: GoogleFonts.timmana(
              color: widget.hintColor,
              fontSize: 18,
          ),
          hintText: widget.hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(widget.radius)),
          ),
          errorStyle: GoogleFonts.adamina(
              color: Colors.redAccent,
              fontSize: 16
          ),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(widget.radius)),
              borderSide: BorderSide(
                  width: 1,
                  color: Colors.red,
                  style: BorderStyle.solid
              )
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(widget.radius)),
              borderSide: BorderSide(
                  color: Colors.white,
                  style: BorderStyle.solid,
                  width: 1
              )
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(widget.radius)),
              borderSide: BorderSide(
                  color: widget.enabledBorderColor,
                  style: BorderStyle.solid,
                  width: 1
              )
          ),
        ),
        style: GoogleFonts.adventPro(
            color: widget.textColor,
            fontSize: 17
        ),
        validator:widget.validator,
      ),

    );
  }
}