import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget appBarMain(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.blueAccent,
    title: (Text(
      "Daily Kirana",
      style: GoogleFonts.pacifico(),
    )),
  );
}

InputDecoration textFieldInputDecoration(String hintText, {iconic}) {
  return InputDecoration(
    prefixIcon: Icon(
      iconic,
      color: Colors.black,
    ),
    border: new OutlineInputBorder(
      borderRadius: new BorderRadius.circular(25.0),
      borderSide: new BorderSide(),
    ),
    hintText: hintText,
    hintStyle: TextStyle(color: Colors.black),
  );
}

TextStyle simpleTextStyle() {
  return TextStyle(color: Colors.black, fontSize: 16);
}

TextStyle biggerTextStyle() {
  return TextStyle(color: Colors.white, fontSize: 20);
}
