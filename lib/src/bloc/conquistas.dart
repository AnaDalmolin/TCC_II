import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quickalert/quickalert.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('Conquistas');

class ConquistasBloc {
  static String? userUid;

// ADD ITEM
  static Future<void> addItem({
    required String nome,
    required double valor,
    required double deposito,
    required String descricao,
    required String userId,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(userId).collection('Objetivos').doc();

    Map<String, dynamic> data = <String, dynamic>{
      "nome": nome,
      "valor": valor,
      "deposito": deposito,
      "descricao": descricao,
    };

    await documentReferencer
        .set(data)
        // ignore: avoid_print
        .whenComplete(() => print("Note item added to the database"))
        // ignore: avoid_print
        .catchError((e) => print(e));
  }

// ADD ITEM
  static Future<void> addObjetivoConcluido({
    required String nome,
    required double valor,
    required String userId,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(userId).collection('ObjetivosConcluido').doc();

    Map<String, dynamic> data = <String, dynamic>{
      "nome": nome,
      "valor": valor,
    };

    await documentReferencer
        .set(data)
        // ignore: avoid_print
        .whenComplete(() => print("Note item added to the database"))
        // ignore: avoid_print
        .catchError((e) => print(e));
  }

// UPDATE ITEM
  static Future<void> updateItem({
    required String nome,
    required double valor,
    required double deposito,
    required String descricao,
    required String userId,
    required String docId,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(userId).collection('Objetivos').doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "nome": nome,
      "valor": valor,
      "deposito": deposito,
      "descricao": descricao,
    };

    await documentReferencer
        .update(data)
        .whenComplete(() => print("Note item updated in the database"))
        .catchError((e) => print(e));
  }

// READ ITEM
  static Stream<QuerySnapshot> readItems({userId}) {
    CollectionReference notesItemCollection =
        _mainCollection.doc(userId).collection('Objetivos');

    return notesItemCollection.snapshots();
  }

// DELETE ITEM

  static Future<void> deleteItem(
      {required String docId, required userId}) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(userId).collection('Objetivos').doc(docId);

    await documentReferencer
        .delete()
        .whenComplete(() => print('Note item deleted from the database'))
        .catchError((e) => print(e));
  }
}
