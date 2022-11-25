import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app/Widgets/decoration_text_field.dart';
import 'package:app/Widgets/text.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:app/Repository/database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/Cubits/hours_cubit.dart';
import 'package:intl/intl.dart';

var textController = TextEditingController();
var cliente;
var id_client;
dynamic horas = 0;
dynamic valor = 0;
dynamic total;

class CheckinCheckout extends StatelessWidget {
  final String title;

  const CheckinCheckout({required this.title, key}) : super(key: key);

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
            ), /*
            Container(
                child: TextButton(
                    child: Text('Checkin'),
                    onPressed: () {
                      print('Pressed');
                    })),
            FloatingActionButton.extended(
              onPressed: () async {
                var date = DateTime.now();
                valor = double.tryParse("$valor");
                //horas = double.tryParse("$horas");
                //total = horas * valor;
                bool existe = false;
                ExistsCheckinHourDB(id_client).then((existe) {
                  if (!existe) {
                    final f = NumberFormat('00');
                    addHourDB({
                      "id_cliente": id_client,
                      'horainicial': f.format(date.hour).toString() +
                          ":" +
                          f.format(date.minute).toString(),
                      'horafinal': "0",
                      'horas': 0,
                      'valor': valor,
                      'total': 0,
                      'data': {'mes': date.month, 'ano': date.year},
                      'timestamp': date.millisecondsSinceEpoch,
                      'pago': false,
                      'nome': cliente
                    });
                    Get.back();
                  } else {
                    _showAlertDialog(context, "Alerta!!",
                        "Já foi feito checkin para esse cliente, só pode fazer checkout");
                  }
                });
              },
              label: Text("Checkin"),
            ),
            FloatingActionButton.extended(
              onPressed: () {
                var datefinal = new DateTime.now();
                final f = NumberFormat('00');
                String dateFinalStr = f.format(datefinal.hour).toString() +
                    ":" +
                    f.format(datefinal.minute).toString();
                //horas = double.tryParse("$horas");
                //total = horas * valor;
                CheckoutHourDB(id_client, dateFinalStr);
                Get.back();
              },
              label: Text("Checkout"),
            ),*/
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(width: 30),
          FloatingActionButton.extended(
            onPressed: () async {
              var date = DateTime.now();
              valor = double.tryParse("$valor");
              //horas = double.tryParse("$horas");
              //total = horas * valor;
              bool existe = false;
              ExistsCheckinHourDB(id_client).then((existe) {
                if (!existe) {
                  final f = NumberFormat('00');
                  addHourDB({
                    "id_cliente": id_client,
                    'horainicial': f.format(date.hour).toString() +
                        ":" +
                        f.format(date.minute).toString(),
                    'horafinal': "0",
                    'horas': 0,
                    'valor': valor,
                    'total': 0,
                    'data': {'mes': date.month, 'ano': date.year},
                    'timestamp': date.millisecondsSinceEpoch,
                    'pago': false,
                    'nome': cliente
                  });
                  Get.back();
                } else {
                  _showAlertDialog(context, "Alerta!!",
                      "Já foi feito checkin para esse cliente, só pode fazer checkout");
                }
              });
            },
            label: Text("Checkin"),
          ),
          FloatingActionButton.extended(
            onPressed: () {
              var datefinal = new DateTime.now();
              final f = NumberFormat('00');
              String dateFinalStr = f.format(datefinal.hour).toString() +
                  ":" +
                  f.format(datefinal.minute).toString();
              //horas = double.tryParse("$horas");
              //total = horas * valor;
              CheckoutHourDB(id_client, dateFinalStr);
              Get.back();
            },
            label: Text("Checkout"),
          ),
        ],
      ),
    ); // This trailing comma makes auto-formatting nicer for build methods.
  }
}

void _showDialog(BuildContext context, String tittle, String msg) {
  _buttonPreview(double _height, double _width) {
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      minimumSize: Size(_width, _height),
      backgroundColor: Colors.grey,
      padding: EdgeInsets.all(0),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(tittle),
          content: new Text(msg),
          actions: <Widget>[
            TextButton(
              style: flatButtonStyle,
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "ok",
                style: TextStyle(color: Colors.white),
              ),
            ),
            /*new FlatButton(
            child: new Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),*/
          ],
        );
      },
    );
  }
}

Future<void> _showSimpleDialog(context) async {
  await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          // <-- SEE HERE
          title: const Text('Select Booking Type'),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('General'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Silver'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Gold'),
            ),
          ],
        );
      });
}
// --- Button Widget --- //

Future<void> _showAlertDialog(context, String tittle, String msg) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        // <-- SEE HERE
        title: Text(tittle),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(msg),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
