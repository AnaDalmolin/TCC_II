import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ObjetivoBloc {
  final db = FirebaseFirestore.instance;

  // ignore: non_constant_identifier_names
  CadastroObjetivo(nome, descricao, valor, id) {
    db.collection('CadastroPerfil').doc(id).set(
      {
        "id": id,
        "Nome": nome,
        "valor": valor,
        "Descrição": descricao,
      },
    );
  }
  // @override
  // void dispose() {}
}
