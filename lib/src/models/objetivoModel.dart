import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tcc_ll/src/models/baseModel.dart';

class Objetivo extends BaseModel {
  String _documentId = '';
  String nome = '';
  double valor = 0;
  double deposito = 0;
  String descricao = '';
  String idUsuario = '';

  Objetivo();

  Objetivo.fromMap(DocumentSnapshot document) {
    _documentId = document.id;

    this.nome = document['name'] ?? '';
    this.valor = document["valor"] ?? 0;
    this.deposito = document["deposito"] ?? 0;
    this.descricao = document["descricao"] ?? '';
    this.idUsuario = document["idUsuario"] ?? '';
  }

  @override
  toMap() {
    var map = new Map<String, dynamic>();
    map['nome'] = this.nome;
    map['valor'] = this.valor;
    map['desposito'] = this.deposito;
    map['descricao'] = this.descricao;
    map['idUsuario'] = this.idUsuario;
    return map;
  }

  @override
  String documentId() => _documentId;
}
