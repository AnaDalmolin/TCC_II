import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tcc_ll/src/models/objetivoModel.dart';
import 'package:tcc_ll/src/models/response.dart';

class ObjetivoBloc {
  final db = FirebaseFirestore.instance;

  // ignore: non_constant_identifier_names
  CadastroObjetivo(id, nome, valor, descricao, deposito) {
    db.collection('CadastroObjetivo').add(
      {
        "id": id,
        "Nome": nome,
        "Valor": valor,
        "Desposito": deposito,
        "Descricao": descricao,
      },
    );
  }

  // static Future<Response> addEmployee({
  //   required String nome,
  //   required double valor,
  //   required double deposito,
  //   required String descricao,
  //   required String idUsuario,
  // }) async {
  //   Response response = Response();
  //   DocumentReference documentReferencer =
  //       FirebaseFirestore.instance.collection("CadastroObjetivo").doc();

  //   Map<String, dynamic> data = <String, dynamic>{
  //     "nome": nome,
  //     "valor": valor,
  //     "deposito": deposito,
  //     "descricao": descricao,
  //     "idUsuario": idUsuario,
  //   };

  //   var result = await documentReferencer.set(data).whenComplete(() {
  //     response.code = 200;
  //     response.message = "Sucessfully added to the database";
  //   }).catchError((e) {
  //     response.code = 500;
  //     response.message = e;
  //   });

  //   return response.;
  // }

  listarObjetivo(user, list) async {
    final QuerySnapshot result = await Future.value(
        FirebaseFirestore.instance.collection("CadastroObjetivo").get());
    for (var i = 0; i < result.size; i++) {
      print(result.docs[i].data());
      list.add(result.docs[i].data());
      print(list);
    }

    return list;
  }

  // @override
  // void dispose() {}
}
