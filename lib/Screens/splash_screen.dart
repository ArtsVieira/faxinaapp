import 'package:flutter/material.dart';





class Login extends StatelessWidget {
 const Login({ key}) : super (key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Faxinei"),
            Image.asset("assets/images/logo.png"),
            CircularProgressIndicator()     
          ],
        ),
      ),   // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
