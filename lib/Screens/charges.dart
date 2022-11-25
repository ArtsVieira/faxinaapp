import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app/Functions/call_number.dart';
import 'package:app/Widgets/text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/Cubits/charges_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

class Charges extends StatelessWidget {
  final String title;

  const Charges({required this.title, key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ChargesCubit>(context).init();
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
                  color: Color.fromARGB(255, 164, 129, 170),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  border: Border.all(color: Colors.white.withOpacity(0)),
                ),
                child: Text(
                  "Cobranças",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                  padding: EdgeInsets.all(8),
                  alignment: Alignment.center,
                  height: 400,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 164, 129, 170),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    border: Border.all(color: Colors.white.withOpacity(0)),
                  ),
                  child: Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.30,
                              child: text("Cliente"),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.30,
                              child: text("Valor"),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.30,
                              child: text("Cobrar"),
                            ),
                          ]),
                      SizedBox(
                        height: 15,
                      ),
                      BlocBuilder<ChargesCubit, List<TableRow>>(
                          builder: (context, list_row) {
                        return Expanded(
                            child: SingleChildScrollView(
                          child: Table(
                              defaultVerticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              // border:TableBorder.all(width: 2.0,color: Colors.red),
                              children: list_row),
                        ));
                      })
                    ],
                  )),
            ],
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 50),
            FloatingActionButton(
                onPressed: () {
                  Get.back();
                },
                tooltip: 'Voltar',
                child: Icon(Icons.arrow_back)),
            Spacer(),
            FloatingActionButton.extended(
              onPressed: () {
                BlocProvider.of<ChargesCubit>(context).dumpListCharge();
              },
              label: Text("Fechar Mês"),
            )
          ],
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
