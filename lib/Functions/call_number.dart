import 'dart:io' show Platform;
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

callNumber(context, String number, String nomecliente, String valor) async {
  number = number.replaceAll(RegExp(r'[\-//(//)//+/\s]'), '');
  //String whatsappURLAndroid = "whatsapp://send?phone=+55$number&text='mepaga'";
  String whatsappURLAndroid =
      "whatsapp://send?phone=+55+$number&text=Olá $nomecliente, segue cobrança tota de horas trabalhadas no valor total R\$$valor";
  var encoded = Uri.encodeFull(whatsappURLAndroid);

  if (await canLaunchUrl(Uri.parse(encoded))) {
    await launchUrl(Uri.parse(encoded));
  } else {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("whatsapp não instalado"),
    ));
  }
}
