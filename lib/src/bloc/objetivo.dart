import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ObjetivoBloc {
  final db = FirebaseFirestore.instance;

  // ignore: non_constant_identifier_names
  CadastroObjetivo(nome, descricao, valor, id, deposito) {
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
    print(result);
    for (var i = 0; i < result.size; i++) {
      print(result.docs[i].data());
      list.add(result.docs[i].data());
    }
    // if(itens.)

    // for (var i = 0; i < itens.length; i++) {
    //   if (itens[i] == user.uid) {
    //     print('---------------------------------------------------');
    //     print('entrou');
    //     print('---------------------------------------------------');
    //   }
    // }

    return list;
  }

  // @override
  // void dispose() {}
}
