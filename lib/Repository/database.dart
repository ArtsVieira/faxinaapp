import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'dart:convert' as convert;
import 'package:app/Functions/auth.dart';

import '../Functions/clients_model.dart';

var id = auth.currentUser!.uid;

addClientDB(data) async {
  print(id);

  DatabaseReference ref = FirebaseDatabase.instance.ref("/$id/clientes").push();
  await ref.set(data);
  ref.onChildAdded.listen((event) {
    event.snapshot.ref.child("id").set(event.snapshot.ref.key);
  });
}

addHourDB(data) async {
  DatabaseReference ref =
      FirebaseDatabase.instance.ref('/$id/trabalhos').push();
  await ref.set(data);
}

Future<bool> ExistsCheckinHourDB(idClient) async {
  DatabaseReference ref = FirebaseDatabase.instance.ref('/$id/trabalhos/');
  bool pode = false;
  var list = await ref.get();

  list.children.forEach((element) async {
    DatabaseReference new_ref = FirebaseDatabase.instance
        .ref('/$id/trabalhos/${element.key}/id_cliente');
    DatabaseEvent event = await new_ref.once();

    if (event.snapshot.value.toString() == idClient) {
      DatabaseReference finalhour = FirebaseDatabase.instance
          .ref('/$id/trabalhos/${element.key}/horafinal');
      DatabaseEvent eventHF = await finalhour.once();
      DatabaseReference inicialhour = FirebaseDatabase.instance
          .ref('/$id/trabalhos/${element.key}/horainicial');
      DatabaseEvent eventHI = await inicialhour.once();
      if (eventHF.snapshot.value.toString() == "0") {
        pode = true;
      }
    }
  });
  return Future.delayed(Duration(seconds: 1), () => pode);
}

CheckoutHourDB(id_client, String hora_final) async {
  DatabaseReference ref = FirebaseDatabase.instance.ref('/$id/trabalhos/');
  Duration total;
  var list = await ref.get();
  list.children.forEach((element) async {
    DatabaseReference new_ref = FirebaseDatabase.instance
        .ref('/$id/trabalhos/${element.key}/id_cliente');
    DatabaseEvent event = await new_ref.once();

    if (event.snapshot.value.toString() == id_client) {
      DatabaseReference finalhour = FirebaseDatabase.instance
          .ref('/$id/trabalhos/${element.key}/horafinal');
      DatabaseEvent eventHF = await finalhour.once();
      DatabaseReference inicialhour = FirebaseDatabase.instance
          .ref('/$id/trabalhos/${element.key}/horainicial');
      DatabaseEvent eventHI = await inicialhour.once();

      if ((eventHF.snapshot.value.toString() == "0") &&
          (eventHI.snapshot.value.toString() != "0")) {
        DateTime dtfim = DateTime.parse("2022-21-11T" + hora_final + ":00");
        DateTime dtini = DateTime.parse(
            "2022-21-11T" + eventHI.snapshot.value.toString() + ":00");
        total = dtfim.difference(dtini);
        double totalminutes = total.inMinutes / 60;
        totalminutes = double.parse(totalminutes.toStringAsFixed(2));
        finalhour.set(hora_final.toString());
        DatabaseReference totalhoras = FirebaseDatabase.instance
            .ref('/$id/trabalhos/${element.key}/horas');

        totalhoras.set(totalminutes.toString());

        DatabaseReference valor = FirebaseDatabase.instance
            .ref('/$id/trabalhos/${element.key}/valor');
        DatabaseEvent valore = await valor.once();
        DatabaseReference totalvalor = FirebaseDatabase.instance
            .ref('/$id/trabalhos/${element.key}/total');

        totalvalor
            .set(totalminutes * double.parse(valore.snapshot.value.toString()));
      }
    }
  });
}

getHours() async {
  DatabaseReference ref = FirebaseDatabase.instance.ref('/$id/trabalhos');
  var list = await ref.get();
  var list_formated = [];

  if (list.value is Map) {
    dynamic map = list.value;
    map.forEach((k, v) {
      var data_atual = DateTime.now();

      v["data"]?["mes"] == data_atual.month &&
              v["data"]?["ano"] == data_atual.year
          ? list_formated.add(v)
          : null;
    });
  }

  list_formated.sort((a, b) => b["timestamp"].compareTo(a["timestamp"]));
  // print(convert.jsonDecode("${list.value.}") );
  return list_formated;
}

getClients() async {
  DatabaseReference ref = FirebaseDatabase.instance.ref('/$id/clientes');
  var list = await ref.get();
  var list_formated = [];

  if (list.value is Map) {
    dynamic map = list.value;
    print(list.value);
    map.forEach((k, v) {
      list_formated.add(v);
    });
  }
  // print(convert.jsonDecode("${list.value.}") );
  return list_formated;
}

final List<ClientsModel> clientslist = [];
getClientsModel() async {
  //final snapshot = await FirebaseDatabase.instance.ref('/$id/clientes').get();
  final snapshot = await FirebaseDatabase.instance.ref('/$id/clientes').get();
  final map = snapshot.value as Map<dynamic, dynamic>;
  map.forEach((key, value) {
    final user = ClientsModel.fromMap(value);
    print(user.toString());
    clientslist.add(user);
  });
  return clientslist;
}

getClientsNameList() async {
  List<String> listclient = [];
  //final snapshot = await FirebaseDatabase.instance.ref('/$id/clientes').get();
  final snapshot = await FirebaseDatabase.instance.ref('/$id/clientes').get();
  final map = snapshot.value as Map<dynamic, dynamic>;
  map.forEach((key, value) {
    final user = ClientsModel.fromMap(value);
    listclient.add(user.nome.toString());
  });
  //final mapcli = clientlist.map as Map<dynamic, dynamic>;
  return listclient;
}

searchClient(text) async {
  List clients = await getClients();
  return clients.where((element) => element.toString().contains(text));
}

disposeCharges() async {
  DatabaseReference ref = FirebaseDatabase.instance.ref('/$id/trabalhos');
  var list = await ref.get();
  list.children.forEach((element) {
    DatabaseReference new_ref =
        FirebaseDatabase.instance.ref('/$id/trabalhos/${element.key}/pago');
    new_ref.set(true);
  });
}

getCharges() async {
  List hours = await getHours();
  var charges = hours.where((element) => element['pago'] == false).toList();
  print(charges);
  return charges;
}

Future<String> getPhone(String idclient) async {
  String fone = "";
  DatabaseReference new_ref =
      FirebaseDatabase.instance.ref('/$id/clientes/$idclient/fone');
  DatabaseEvent event = await new_ref.once();
  print(idclient);
  if (event.snapshot.value.toString() != "") {
    fone = event.snapshot.value.toString();
  }
  print(fone);
  return Future.delayed(Duration(seconds: 1), () => fone);
}
