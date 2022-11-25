import 'package:app/Repository/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/Widgets/text.dart';
import 'package:app/Functions/call_number.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ChargesCubit extends Cubit<List<TableRow>> {
  ChargesCubit() : super(<TableRow>[]);

  final currency = new NumberFormat("#,##0.00", "pt_BR");

  void increment(client) {
    state.add(client);
    emit(state);
  }

  init() async {
    var list_repo = await getCharges();
    var list_row = await mountList(list_repo);
    emit(list_row);
  }

  mountList(List list) {
    var tableRowList = <TableRow>[];

    list.forEach((element) {
      tableRowList.add(
        TableRow(children: [
          text("${element["nome"]}", 16),
          text("R\$${currency.format(element["total"])}", 12),
          IconButton(
              onPressed: () {
                print("nome" + element["nome"]);
                print("id" + element["id_cliente"]);
                getPhone(element["id_cliente"]).then((fone) {
                  print("Dados:" +
                      element["nome"] +
                      element["total"].toString() +
                      fone);
                  callNumber(Get.context, fone, element["nome"],
                      element["total"].toString());
                });
              },
              icon: Icon(Icons.whatsapp)),
        ]),
      );
    });
    return tableRowList;
  }

  dumpListCharge() {
    disposeCharges();
    emit([]);
  }

  //void decrement()
}
