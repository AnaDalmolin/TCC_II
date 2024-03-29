import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('Afiliado');

class ResponsavelBloc {
// ADD ITEM
  static Future<void> cadastroAfiliado(
      {required String userId,
      required String idAfiliado,
      required String nome}) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(userId).collection('afiliadosCadastrados').doc();

    Map<String, dynamic> data = <String, dynamic>{
      "nome": nome,
      "idAfiliado": idAfiliado,
    };

    await documentReferencer
        .set(data)
        // ignore: avoid_print
        .whenComplete(() => print("Note item added to the database"))
        // ignore: avoid_print
        .catchError((e) => print(e));
  }

  // READ ITEM
  static Stream<QuerySnapshot> readItems({userId}) {
    CollectionReference notesItemCollection =
        _mainCollection.doc(userId).collection('afiliadosCadastrados');

    return notesItemCollection.snapshots();
  }

  // // VALIDA AFILIADO
  validarUsuario(user) async {
    final QuerySnapshot result = await Future.value(
        FirebaseFirestore.instance.collection("CadastroPerfil").get());
    bool usuarioExistente = false;

    for (var i = 0; i < result.docs.length; i++) {
      if (result.docs[i]["id"] == user) {
        usuarioExistente = true;
      }
    }

    return usuarioExistente;
  }

  // //LISTAGEM DE AFILIADO
  // static Future<void> listagemAfiliado({
  //   required String filiadoId,
  //   required userId,
  // }) async {
  //   DocumentReference documentReferencer =
  //       _mainCollection.doc(userId).collection('Objetivos').doc(docId);

  //   await documentReferencer
  //       .delete()
  //       .whenComplete(() => print('Note item deleted from the database'))
  //       .catchError((e) => print(e));
  // }
  // @override
  // void dispose() {}
}
