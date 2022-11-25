import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app/Widgets/text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/Cubits/gains_cubit.dart';

class Gains extends StatelessWidget {
  final String title;

  const Gains({required this.title, key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
            BlocProvider.of<GainsCubit>(context).init();
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                height: 40,
                width: 300,
                decoration: BoxDecoration(
                  color:const  Color.fromARGB(255, 164, 129, 170),
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  border: Border.all(color: Colors.white.withOpacity(0)),
                ),
                child: Text(
                  "$title",
                  style: TextStyle(fontSize: 26),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Column(
                children: [
                  Container(
                      height: 400,
                      padding: EdgeInsets.all(8),
                      alignment: Alignment.topCenter,
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
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: text("Mês/Ano"),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: text("Ganho Total"),
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                   
                         BlocBuilder<GainsCubit, List<TableRow>>(
                          builder: (context, list_row) {
                            return SizedBox(
                          height: 300,
                        child:SingleChildScrollView(
                          child: Table(
                            // defaultVerticalAlignment: TableCellVerticalAlignment.bottom,
                            // border:TableBorder.all(width: 2.0,color: Colors.red),
                            children:list_row) ,) ,
                        );
                          })
                                  
                        ],
                      )),
                ],
              )
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
                tooltip: 'voltar',
                child: Icon(Icons.arrow_back)),
          ],
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
