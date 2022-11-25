import 'package:app/Repository/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/Widgets/text.dart';
import 'package:app/Functions/call_number.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class GainsCubit extends Cubit<List<TableRow>> {
  GainsCubit() : super(<TableRow>[]);

 final currency = new NumberFormat("#,##0.00", "pt_BR");

  void increment(client) {
    state.add(client);
    emit(state);
  }

  init() async {
    var list_repo = await getGains();
    var list_row = await mountList(list_repo);
    emit(list_row);
  }

  mountList(List list) {
    var tableRowList = <TableRow>[];

    list.forEach((element) {
      tableRowList.add(
        TableRow(children: [
          text("${element["data"]?['mes']}/${element["data"]?['ano']}", 16),
          text("R\$ ${currency.format(element["total"]) }", 12),
        ]),
      );
    });
    return tableRowList;
  }
  //void decrement()
}

getGains() async {
  List hours = await getHours();
  var gains = hours.where((element) => element['pago'] == true);
  var dates = [];
  gains.toList().forEach((element) {
    var key = "${element['data']?['mes']}${element['data']?['ano']}";

    var date = dates.firstWhereOrNull((element) => element["id"] == key);

        date != null
        ? date['total'] = date["total"] + element['total']
        : dates.add({'id': key, 'data': element['data'], 'total': element["total"]});


  });

  return dates;
}
