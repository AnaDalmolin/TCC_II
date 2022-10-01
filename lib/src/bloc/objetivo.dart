import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ObjetivoBloc {
  final db = FirebaseFirestore.instance;

  // ignore: non_constant_identifier_names
  CadastroObjetivo(nome, descricao, valor, id, deposito) {
    db.collection('CadastroObjetivo').doc(id).set(
      {
        "id": id,
        "Nome": nome,
        "valor": valor,
        "Descrição": descricao,
        "Deposito": deposito,
      },
    );
  }

  listarObjetivo(user, list) async {
    final QuerySnapshot result = await Future.value(FirebaseFirestore.instance
        .collection("CadastroObjetivo")
        .where(FieldPath.documentId, isEqualTo: user.uid)
        .limit(10)
        .get());

    list = result.docs[0].data();
    return list;
  }

  // @override
  // void dispose() {}
}
