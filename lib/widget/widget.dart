import 'package:flutter/material.dart';

Widget appBarMain() {
  return AppBar(
    title: Text("E-Grocery",
    style: TextStyle(fontFamily:'DancingScript')
    )
  );
}

InputDecoration textFieldInputDecoration(String hintText,{iconic}) {
  return InputDecoration(
      
      prefixIcon: Icon(iconic,color: Colors.white60,),
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
  return TextStyle(color: Colors.white, fontSize: 18);
}
