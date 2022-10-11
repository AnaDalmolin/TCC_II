// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:tcc_ll/src/models/baseModel.dart';

// class Movimentacao extends BaseModel {
//   String _documentId;
//   DateTime data;
//   bool movimentacao;
//   double valor;
//   String id;

//   Movimentacao(
//       this._documentId , required this.data, required this.movimentacao, required this.valor, this.id);

//   // Movimentacao.fromMap(
//   //     this._documentId, this.data, this.movimentacao, this.valor, this.id) {
//   //   _documentId = document.documentID;

//   //   data = document.data["data"];
//   //   movimentacao = document.data["movimentacao"] ?? false;
//   //   valor = document.data["valor"];
//   //   id = document.data["id"];
//   // }
//   Movimentacao.fromMap(Map<String, dynamic> documentacao)
//       : data = documentacao["data"],
//         movimentacao = documentacao["movimentacao"],
//         valor = documentacao["valor"],
//         id = documentacao["id"];

//   // ignore: unnecessary_this

//   @override
//   toMap() {
//     var map = <String, dynamic>{};
//     map['data'] = data;
//     map['movimentacao'] = movimentacao;
//     map['valor'] = valor;
//     map['id'] = id;
//     return map;
//   }

//   @override
//   String documentId() => _documentId;
// }
