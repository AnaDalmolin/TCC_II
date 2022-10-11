import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  listarObjetivo(user, list) async {
    final QuerySnapshot result = await Future.value(
        FirebaseFirestore.instance.collection("CadastroObjetivo").get());
    for (var i = 0; i < result.size; i++) {
      list.add(result.docs[i].data());
    }

    return list;
  }

  // @override
  // void dispose() {}
}
