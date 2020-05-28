import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Text getCategoryHeader(String header, double fontSize){
  return Text(
    header.toUpperCase(),
    style: GoogleFonts.adventPro(
        color: Colors.white,
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        shadows: [
          Shadow(
              color: Colors.black45,
              offset: Offset(-1,1),
              blurRadius: 12
          )
        ]
    ),
  );
}