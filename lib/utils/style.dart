import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// colors
var blue = const Color(0xff0032A0);
var blueLight = const Color(0xff86AAFF);
var red = const Color(0xffBF0D3E);
var redLight = const Color(0xffFFDACC);
var white = const Color(0xffFFFFFF);
var yellow = const Color(0xffFED141);
var yellowLight = const Color(0xffFFFF9F);
var textLight = const Color(0xffF0F0F0);
// ignore: use_full_hex_values_for_flutter_colors
var textDark = const Color(0xfff262626);
var transparent = const Color(0x000000ff);

List<Color> colorList = [
  const Color(0xff0032A0), // blue
  const Color(0xff86AAFF), // blueLight
  const Color(0xffBF0D3E), // red
  const Color(0xffFFDACC), // redLight
  const Color(0xffFED141), // yellow
  const Color(0xffFFFF9F), // yellowLight
  const Color.fromARGB(255, 167, 7, 241), // purple
  const Color.fromARGB(255, 220, 143, 255), // light purplr
  const Color.fromARGB(255, 24, 238, 131), // teal
  const Color.fromARGB(255, 142, 248, 195) // light teal
];

// TextStyle
TextStyle heading1L = GoogleFonts.poppins(
  fontWeight: FontWeight.w600, color: textLight, fontSize: 20);
TextStyle heading1D = GoogleFonts.poppins(
  fontWeight: FontWeight.w600, color: textDark, fontSize: 20);  
TextStyle heading2D = GoogleFonts.poppins(
  fontWeight: FontWeight.w600, color: textDark, fontSize: 18);
  TextStyle heading2L = GoogleFonts.poppins(
  fontWeight: FontWeight.w600, color: textLight, fontSize: 18);
TextStyle heading3 = GoogleFonts.poppins(
  fontWeight: FontWeight.w600, color: textDark, fontSize: 16);
  TextStyle heading3L = GoogleFonts.poppins(
  fontWeight: FontWeight.w600, color: textLight, fontSize: 16);
  TextStyle heading4 = GoogleFonts.poppins(
  fontWeight: FontWeight.w600, color: textDark, fontSize: 14);
  TextStyle heading4L = GoogleFonts.poppins(
  fontWeight: FontWeight.w600, color: textLight, fontSize: 14);


//Paragraph
TextStyle pBold = GoogleFonts.poppins(
  color: textDark, fontSize: 14, fontWeight: FontWeight.w700);
TextStyle p1 = GoogleFonts.poppins(
  color: textDark, fontSize: 14);
TextStyle p2 = GoogleFonts.poppins(
  color: textDark, fontSize: 12);
TextStyle p3 = GoogleFonts.poppins(
  color: textDark, fontSize: 10);  

//Gaps
var large = 50.0;
var medium = 30.0;
var small = 14.0;
var xsmall = 10.0;


