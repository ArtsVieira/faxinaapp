import 'package:flutter/material.dart';


text(text,[double ? fontSize]){
  fontSize = fontSize == null ? 16.0 : fontSize;
  return Text(
    "$text",textScaleFactor: 1.4,textAlign: TextAlign.center, style: TextStyle(fontSize:fontSize ),);
}