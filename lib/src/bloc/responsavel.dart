import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('Afiliado');

class ResponsavelBloc {
// ADD ITEM
  static Future<void> cadastroAfiliado({
    required String userId,
    required String idAfiliado,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(userId).collection('afiliadosCadastrados').doc();

    Map<String, dynamic> data = <String, dynamic>{
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
  // @override
  // void dispose() {}
}
