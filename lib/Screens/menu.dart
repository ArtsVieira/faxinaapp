import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app/Screens/clients.dart';
import 'package:app/Screens/gains.dart';
import 'hours.dart';
import 'checkin_checkout.dart';
import 'charges.dart';
import 'login.dart';
import 'package:app/Functions/auth.dart';

class Menu extends StatelessWidget {
  final String title;

  const Menu({required this.title, key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            height: 40,
            width: 100,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 127, 111, 171),
              borderRadius: BorderRadius.all(Radius.circular(20)),
              border: Border.all(color: Colors.white.withOpacity(0)),
            ),
            child: Text(
              "Menu",
              style: TextStyle(fontSize: 26),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              InkWell(
                  onTap: () {
                    Get.to(Clients(
                      title: "Clientes",
                    ));
                  },
                  child: itemMenu("Clientes", "assets/images/people_icon.png")),
              InkWell(
                  onTap: () {
                    Get.to(Hours(
                      title: "Registro de Horas",
                    ));
                  },
                  child: itemMenu(
                      "Registro de Horas", "assets/images/clock_icon.png")),
              InkWell(
                  onTap: () {
                    Get.to(Gains(
                      title: "Registro de Ganhos",
                    ));
                  },
                  child: itemMenu(
                      "Registro de ganhos", "assets/images/chart_icon.png")),
              InkWell(
                  onTap: () {
                    Get.to(Charges(
                      title: '',
                    ));
                  },
                  child: itemMenu("Cobranças", "assets/images/money_icon.png")),
              InkWell(
                  onTap: () {
                    Get.to(CheckinCheckout(
                      title: "Checkin e Checkout",
                    ));
                  },
                  child: itemMenu(
                      "Checkin Checkout", "assets/images/clock_icon.png")),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                  onTap: () {
                    Get.to(Login());
                  },
                  child: Container(
                      width: 200,
                      child: InkWell(
                        onTap: () {
                          logout();
                        },
                        child: Wrap(
                          spacing: 10,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text(
                              "Sair da Conta",
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.8)),
                            ),
                            Icon(
                              Icons.logout,
                              color: Colors.white.withOpacity(0.8),
                            )
                          ],
                        ),
                      ))),
            ],
          )
        ],
      ),
    ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}

itemMenu(text, image) {
  return Container(
      alignment: Alignment.center,
      height: 140,
      width: 140,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 127, 111, 171),
        borderRadius: BorderRadius.all(Radius.circular(20)),
        border: Border.all(color: Colors.white.withOpacity(0)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            height: 50,
            width: 50,
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "$text",
            style: TextStyle(
              fontSize: 18,
              color: Color.fromARGB(255, 23, 75, 26),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ));
}
