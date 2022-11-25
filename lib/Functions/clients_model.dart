class ClientsModel {
  String? id;
  String? nome;
  String? fone;
  double? valor;

  dados() {
    return {
      'id': id,
      'nome': nome,
      'fone': fone,
      'valor': valor,
    };
  }

  ClientsModel({this.id, this.nome, this.fone, this.valor});

  factory ClientsModel.fromJson(Map<String, dynamic> clientsjson) =>
      ClientsModel(
          id: clientsjson["id"],
          nome: clientsjson["nome"],
          fone: clientsjson["fone"],
          valor: clientsjson["valor"]);

  factory ClientsModel.fromMap(Map<dynamic, dynamic> map) {
    return ClientsModel(
      id: map['id'] ?? '',
      nome: map['nome'] ?? '',
      fone: map['fone'] ?? '',
      valor: map['valor'] ?? '',
    );
  }
}
