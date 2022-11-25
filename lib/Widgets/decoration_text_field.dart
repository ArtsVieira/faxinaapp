import 'package:flutter/material.dart';


var borda =   OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
            borderSide: const BorderSide(color: Color.fromARGB(255, 7, 7, 7), width: 2.0),
          );

       decoration(text){
        return  InputDecoration(
        focusedBorder: borda,
        border: borda,
        labelText: "$text",
        fillColor: Colors.white,
        filled: true,
        labelStyle: TextStyle(color: Color.fromARGB(255, 92, 92, 92)) 
           );
       }  