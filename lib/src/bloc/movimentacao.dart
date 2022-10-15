import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('Movimento');

class MovimentacaoBloc {
  //FUNÇÃO PARA MOVIMENTAR O SALDO
  static Future<void> movimentaSaldo(
      {required double saldoAtual,
      required double valoradicionado,
      required String userId,
      required bool movimento,
      required String docId}) async {
    double valor;
    if (docId == null || docId == '') {
      if (movimento == true) {
        valor = valoradicionado + saldoAtual;
      } else {
        valor = valoradicionado - saldoAtual;
      }
      DocumentReference documentReferencer =
          _mainCollection.doc(userId).collection('Saldo').doc();

      Map<String, dynamic> data = <String, dynamic>{
        "valor": valor,
      };

      await documentReferencer
          .set(data)
          // ignore: avoid_print
          .whenComplete(() => print("Note item added to the database"))
          // ignore: avoid_print
          .catchError((e) => print(e));
    } else {
      double valor;

      if (movimento == true) {
        valor = valoradicionado + saldoAtual;
      } else {
        valor = valoradicionado - saldoAtual;
      }
      DocumentReference documentReferencer =
          _mainCollection.doc(userId).collection('Saldo').doc(docId);

      Map<String, dynamic> data = <String, dynamic>{
        "valor": valor,
      };

      await documentReferencer
          .update(data)
          .whenComplete(() => print("Note item updated in the database"))
          .catchError((e) => print(e));
    }
  }

  // READ ITEM
  static Stream<QuerySnapshot> readItems({userId}) {
    CollectionReference notesItemCollection =
        _mainCollection.doc(userId).collection('Saldo');

    return notesItemCollection.snapshots();
  }

  // @override
  // void dispose() {}
}
