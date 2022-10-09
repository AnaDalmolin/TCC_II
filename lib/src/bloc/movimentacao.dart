import 'package:cloud_firestore/cloud_firestore.dart';

class ObjetivoBloc {
  final db = FirebaseFirestore.instance;

  // ignore: non_constant_identifier_names
  CadastroAnotacaoSaque(valor, id) {
    db.collection('CadastroAnotacaoSaque').add(
      {
        "id": id,
        "Valor": valor,
      },
    );
  }

  // ignore: non_constant_identifier_names
  CadastroAnotacaoDeposito(valor, id) {
    db.collection('CadastroAnotacaoDeposito').add(
      {
        "id": id,
        "Valor": valor,
      },
    );
  }

  listarAnotacoesDepositos(user, list) async {
    final QuerySnapshot result = await Future.value(
        FirebaseFirestore.instance.collection("CadastroAnotacaoSaque").get());
    for (var i = 0; i < result.size; i++) {
      list.add(result.docs[i].data());
    }

    return list;
  }

  listarAnotacoesSaques(user, list) async {
    final QuerySnapshot result = await Future.value(FirebaseFirestore.instance
        .collection("CadastroAnotacaoDeposito")
        .get());
    for (var i = 0; i < result.size; i++) {
      list.add(result.docs[i].data());
    }

    return list;
  }

  // @override
  // void dispose() {}
}
