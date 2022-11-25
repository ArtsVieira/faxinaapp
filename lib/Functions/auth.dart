import 'package:app/Screens/login.dart';
import 'package:app/Widgets/toast_notify.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app/Screens/menu.dart';
import 'package:get/get.dart';

BuildContext ? context = Get.context;

FirebaseAuth auth = FirebaseAuth.instance;

signUp(email, password, confirm_password) async {
  if (password == confirm_password) {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      Get.to(Menu(title: "Menu"));
      notify(context,'Cadastrado com sucesso');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        notify(context,'Digite uma senha maior');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        notify(context,'Email já está cadastrado');
      }
    } catch (e) {
      print(e);
      notify(context,'Tente novamente mais tarde');
    }
  } else {
    notify(context,"Senhas precisam ser iguais");
  }
}

login(String email, String password) async {

  email.isEmpty || password.isEmpty ? notify(context,"Digite os dados de login") :null;
  try {
    final credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    Get.to(Menu(title: "Menu"));
    notify(context,'Logado Sucesso');
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
      notify(context,'Email não cadastrado');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
      notify(context,'Senha incorreta');
    }
  }
}


logout() async {
//await auth.signOut();
Get.to(Login());
Get.clearRouteTree();
}
