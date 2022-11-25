import 'package:flutter/material.dart';
import 'Screens/menu.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Cubits/clients_cubit.dart';
import 'Cubits/hours_cubit.dart';
import 'Cubits/charges_cubit.dart';
import 'Cubits/gains_cubit.dart';
import 'package:app/Screens/login.dart';
import 'Functions/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<ClientsCubit>(
        create: (BuildContext context) => ClientsCubit(),
      ),
      BlocProvider<HoursCubit>(
        create: (BuildContext context) => HoursCubit(),
      ),
      BlocProvider<ChargesCubit>(
        create: (BuildContext context) => ChargesCubit(),
      ),
      BlocProvider<GainsCubit>(
        create: (BuildContext context) => GainsCubit(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          scaffoldBackgroundColor: Color.fromARGB(255, 69, 47, 116)),
      home: auth.currentUser != null ? const Menu(title: "") : Login(),
    );
  }
}
