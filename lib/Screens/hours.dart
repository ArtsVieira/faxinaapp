import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app/Widgets/decoration_text_field.dart';
import 'package:app/Widgets/text.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:app/Repository/database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/Cubits/hours_cubit.dart';

class Hours extends StatelessWidget {
  final String title;

  const Hours({required this.title, key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<HoursCubit>(context).init();
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(2),
                alignment: Alignment.center,
                height: 40,
                width: 300,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 164, 129, 170),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
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
              Container(
                  padding: EdgeInsets.all(8),
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height * 0.60,
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
                            child: text("Horas"),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      BlocBuilder<HoursCubit, List<TableRow>>(
                          builder: (context, list_row) {
                        return Expanded(
                            child: SingleChildScrollView(
                                child: Table(
                                    //border:TableBorder.all(width: 2.0,color: Colors.red),
                                    children: list_row)));
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
                tooltip: 'voltar',
                child: Icon(Icons.arrow_back)),
            Spacer(),
            FloatingActionButton.extended(
              onPressed: () {
                _addHour(context);
              },
              label: Text("Adicionar hora"),
            )
          ],
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}

void _addHour(context) {
  var textController = TextEditingController();
  var cliente;
  var id_client;
  dynamic horas = 0;
  dynamic valor = 0;
  dynamic total;

  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (builder) {
        return Container(
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              const Text("Adicionar hora"),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: decoration("Quantidade de horas"),
                onChanged: (value) {
                  horas = int.tryParse("$value");
                },
              ),
/*              SizedBox(
                height: 10,
              ),*/
              TypeAheadField(
                textFieldConfiguration: TextFieldConfiguration(
                    controller: textController,
                    autofocus: true,
                    decoration: decoration("")),
                suggestionsCallback: (pattern) async {
                  return await searchClient(textController.text);
                },
                itemBuilder: (context, suggestion) {
                  if (suggestion != null && suggestion is Map) {
                    return ListTile(
                      leading: Icon(Icons.person),
                      title: Text(suggestion['nome']),
                      subtitle: Text('Valor hora: R\$ ${suggestion['valor']}'),
                    );
                  } else {
                    return Text("Sem resultado");
                  }
                },
                onSuggestionSelected: (suggestion) {
                  if (suggestion != null && suggestion is Map) {
                    textController.text = suggestion['nome'];
                    cliente = suggestion["nome"];
                    valor = suggestion["valor"];
                    id_client = suggestion["id"];
                  }
                },
              ),
              ElevatedButton(
                  onPressed: () {
                    var date = new DateTime.now();
                    valor = double.tryParse("$valor");
                    horas = double.tryParse("$horas");
                    total = horas * valor;
                    addHourDB({
                      "id_cliente": id_client,
                      'horas': horas,
                      'valor': valor,
                      'total': total,
                      'data': {'mes': date.month, 'ano': date.year},
                      'timestamp': date.millisecondsSinceEpoch,
                      'pago': false,
                      'nome': cliente
                    });
                    Get.back();
                  },
                  child: Text("Adicionar")),
            ],
          ),
        );
      });
}
