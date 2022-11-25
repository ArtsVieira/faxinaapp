import 'package:flutter/material.dart';

notify(context, String text){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
    ));
}