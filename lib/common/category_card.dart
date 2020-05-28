import 'dart:math';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:se380final/common/fadeAnimation.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final String imgUrl;

  const CategoryCard({Key key, this.title, this.imgUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeAnimation(
      delay: 1.2,
      child: Material(
        elevation: 16,
        color: title.length > 6 ? Colors.redAccent : Colors.indigoAccent,
        borderRadius: BorderRadius.all(Radius.circular(16)),
        child: Stack(
          fit: StackFit.loose,
          children: <Widget>[
            Positioned(
              top: 15,
              left: 5,
              child: BounceInLeft(
                delay: Duration(milliseconds: 1200),
                child: Container(
                  width: MediaQuery.of(context).size.width / 4,
                  child: Text(
                    title,
                    style: GoogleFonts.rubik(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              right: -15,
              top: 15,
              child: Transform.rotate(
                angle: pi / 10,
                child: BounceInRight(
                  delay: Duration(milliseconds: 1200),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 16,
                          offset: Offset(-1,1),
                          color: Colors.black38,
                          spreadRadius: 8
                        )
                      ]
                    ),
                    height: 65,
                    width: 95,
                    child: Image.asset(
                      imgUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
