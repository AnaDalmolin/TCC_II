import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quickalert/quickalert.dart';
import 'package:tcc_ll/src/bloc/movimentacao.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('Objetivo');

class DatabaseObjetivo {
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
  static Future<void> updateItem(
      {required String nome,
      required double valor,
      required double deposito,
      required String descricao,
      required String userId,
      required String docId,
      required double saldo,
      required double valorDigitado,
      required String docIdSaldo}) async {
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

    await MovimentacaoBloc.movimentaSaldo(
        saldoAtual: saldo,
        valoradicionado: valorDigitado,
        userId: userId,
        movimento: false,
        docId: docIdSaldo);
  }

// READ ITEM
  static Stream<QuerySnapshot> readItems({userId}) {
    CollectionReference notesItemCollection =
        _mainCollection.doc(userId).collection('Objetivos');

    return notesItemCollection.snapshots();
  }

// READ OBJETIVOS CONCLUIDOS
  static Stream<QuerySnapshot> readObjetivosConcluidos({userId}) {
    CollectionReference notesItemCollection =
        _mainCollection.doc(userId).collection('ObjetivosConcluido');

    return notesItemCollection.snapshots();
  }

// DELETE ITEM

  static Future<void> deleteItemESaldo(
      {required String docId,
      required userId,
      required saldoAtual,
      required valorObjetivo,
      required docIdSaldo}) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(userId).collection('Objetivos').doc(docId);

    await documentReferencer
        .delete()
        .whenComplete(() => print('Note item deleted from the database'))
        .catchError((e) => print(e));

    await MovimentacaoBloc.movimentaSaldo(
        saldoAtual: saldoAtual,
        valoradicionado: valorObjetivo,
        userId: userId,
        movimento: true,
        docId: docIdSaldo);
  }

  static Future<void> deleteItem({
    required String docId,
    required userId,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(userId).collection('Objetivos').doc(docId);

    await documentReferencer
        .delete()
        .whenComplete(() => print('Note item deleted from the database'))
        .catchError((e) => print(e));
  }

  //PORCENTAGEM OBJETIVO
  static porcentagemObjetivo({valorObjetivo, valorDepositado}) {
    double total = valorObjetivo - valorDepositado;
    return total;
  }

  //VALOR A SER DEPOSITADO NO OBJETIVO
  static somaDeposito({valorExistente, valorDepositado}) {
    double total = valorExistente + valorDepositado;
    //
    return total;
  }

  //VALIDAR OBJETIVO CONCLUIDO E MOVER PARA LISTA DE FINALIZADO
  static objetivoConcluido({
    user,
    docId,
    nome,
    valor,
  }) async {
    addObjetivoConcluido(nome: nome, userId: user, valor: valor);
    await deleteItem(docId: docId, userId: user);
  }

  //VALIDAR A QUANTIDADE DE OBJETIVO CADASTRADO
  static validaTotalObjetivo({user}) {
    CollectionReference notesItemCollection =
        _mainCollection.doc(user).collection('Objetivos');
    print(notesItemCollection);

    return notesItemCollection.snapshots();
  }
}
