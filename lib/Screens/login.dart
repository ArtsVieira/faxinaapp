import 'package:flutter/material.dart';
import 'package:app/Widgets/decoration_text_field.dart';
import 'package:get/get.dart';
import 'menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app/Functions/auth.dart';


var cad_visible = false.obs;
class Login extends StatelessWidget {
  Login({ key}) : super (key: key);

  String email = '';
  String _senha ='';
  String _senha2 ='';
  var text = "Cadastrar".obs; 


  @override
  Widget build(BuildContext context) {
        auth
  .authStateChanges()
  .listen((User? user) {
    if (user == null) {
           
    } else {

    }
  });

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           Container(
            alignment: Alignment.center,
            height: 70,
            width: 200,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 127, 111, 171),
              borderRadius: BorderRadius.all(Radius.circular(20)),
              border: Border.all(color: Colors.white.withOpacity(0)),
            ),
            child: const Text(
              "Faxinei",
              style: TextStyle(
                fontSize: 55,
                fontFamily: "Lemonada"
                ),
            ),
          ), 
             Image.asset("assets/images/logo.png", height: 200,width: 200,),
            SizedBox(width: 300,
            child: Column(children: [
            TextFormField(
              decoration: decoration("Email"),
              onChanged: (email) {
                this.email = email;
              },
            ),
            const SizedBox(height: 15,),
            TextFormField(
              obscureText: true,
              decoration: decoration("Senha"),
              onChanged: (password) {
                _senha = password;
              },
              ),
              SizedBox(height: 15,), 
                 Obx((){
               return Visibility(
            visible: cad_visible.value,
            child:
            TextFormField(
             obscureText: true,
              decoration: decoration("Confirmar senha"),
              onChanged: (password2) {
                _senha2 = password2;
              },
              ),
            );
            }),
            const SizedBox(height: 10,)
            ],),

            ),
        
        
                       ElevatedButton(
                
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(200, 70),
                  backgroundColor: Colors.deepPurple[200]),
                onPressed: () {
                  
                cad_visible.value == true? signUp(email,_senha, _senha2) : login(email, _senha);
               }, child: Text("Entrar")),
               SizedBox(height: 10,),
             
                 InkWell(
                onTap: () {
                   cad_visible.value = !cad_visible.value;
                   cad_visible.value == true ? text.value= "Já tenho cadastro" : text.value = "Cadastrar"; 
                },
                child:  Obx((){ 
                  return Text(
                  "${text.value}",
                 style: TextStyle(color: Colors.white.withOpacity(0.8))
                 ,);
           }),) 
          ],
        ) ,) ,
      ),   // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


