import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget appBarMain(BuildContext context) {
  return AppBar(
    title: (Text("E-Groc",
    style:GoogleFonts.piedra(),
    ))
    
  );
}

InputDecoration textFieldInputDecoration(String hintText, {iconic}) {
  return InputDecoration(
      prefixIcon: Icon(
        iconic,
        color: Colors.white60,
      ),
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.white54),
      focusedBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      enabledBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)));
}

TextStyle simpleTextStyle() {
  return TextStyle(color: Colors.white, fontSize: 16);
}

TextStyle biggerTextStyle() {
  return TextStyle(color: Colors.white, fontSize: 20);
}
