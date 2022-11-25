import 'package:app/Cubits/clients_cubit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app/Widgets/decoration_text_field.dart';
import 'package:app/Widgets/text.dart';
//import 'package:easy_mask/easy_mask.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:app/Functions/clients_model.dart';
import 'package:app/Repository/database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Clients extends StatelessWidget {
  const Clients({
    key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ClientsCubit>(context).init();
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
                  "$title",
                  style: TextStyle(fontSize: 26),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                  height: 400,
                  padding: EdgeInsets.all(2),
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
                            width: MediaQuery.of(context).size.width * 0.25,
                            child: text("Cliente"),
                          ),
                          Spacer(),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.25,
                            child: text("Telefone"),
                          ),
                          Spacer(),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.32,
                            child: text("Valor Hora"),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      BlocBuilder<ClientsCubit, List<TableRow>>(
                          builder: (context, list_row) {
                        return SizedBox(
                          height: 305,
                          child: SingleChildScrollView(
                            child: Table(
                                // defaultVerticalAlignment: TableCellVerticalAlignment.bottom,
                                // border:TableBorder.all(width: 2.0,color: Colors.red),
                                children: list_row),
                          ),
                        );
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
                _addClient(context);
              },
              label: Text("Cadastrar Cliente"),
            )
          ],
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}

void _addClient(context) {
  var client = ClientsModel();
  var money_mask = new MoneyMaskedTextController(leftSymbol: 'R\$ ');

  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (builder) {
        return Container(
          height: 600,
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              const Text("Adicionar Cliente"),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: decoration("Cliente"),
                onChanged: (value) {
                  client.nome = value;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: new MaskedTextController(mask: '(00) 00000-0000'),
                decoration: decoration("Telefone"),
                onChanged: (value) {
                  client.fone = value;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: money_mask,
                decoration: decoration("Valor hora"),
                onChanged: (value) {
                  client.valor = money_mask.numberValue;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    addClientDB(client.dados());
                    Get.back();
                  },
                  child: Text("Cadastrar Cliente"))
            ],
          ),
        );
      });
}
