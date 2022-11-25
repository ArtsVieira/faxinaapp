import 'package:app/Repository/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/Widgets/text.dart';
import 'package:intl/intl.dart';

class ClientsCubit extends Cubit<List<TableRow>> {
  ClientsCubit() : super(<TableRow>[]);

  final currency = new NumberFormat("#,##0.00", "pt_BR");

  void increment(client) {
    state.add(client);
    emit(state);
  } 

  init()async {   
    var list_repo = await getClients(); 
   var list_row =await mountList(list_repo);
    emit(list_row);
  }

mountList(List list){

   var tableRowList = <TableRow>[];

  list.forEach((element) {
    tableRowList.add(TableRow(
                children: [
                  text("${element["nome"]}",12),
                  text("${element["fone"]}",12),
                  text("R\$ ${currency.format(element["valor"])}",12)
                ]
              ),);
  });
  return tableRowList;
}
  //void decrement() 
}