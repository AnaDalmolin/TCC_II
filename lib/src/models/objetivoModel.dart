// import 'dart:core';
// import 'dart:core';
// import 'dart:ffi';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:tcc_ll/src/models/baseModel.dart';

// class ObjetivoModel extends BaseModel {
//   int id;
//   var nome;
//   Float valor;
//   Float deposito;
//   var descricao;
//   var _documentId;

//   ObjetivoModel(this.id, this.nome, this.valor, this.deposito, this.descricao);

//   ObjetivoModel.fromMap(DocumentSnapshot document, this.id, this.nome,
//       this.valor, this.deposito, this.descricao) {

//     this.id = document.data["id"];
//     this.nome = document.data["nome"];
//     this.valor = document.data["valor"] ?? false;
//     this.deposito = document.data["deposito"] ?? false;
//     this.descricao = document.data["descricao"] ?? false;
//     this._documentId; = document.data["_documentId;"] ?? false;

//   }
//   @override
//   toMap() {
//     var map = new Map<String, dynamic>();
//     map['name'] = this.name;
//     map['active'] = this.active;
//     map['birthDate'] = this.birthDate;
//     return map;
//   }

//   @override
//   String documentId() => _documentId;
// }
