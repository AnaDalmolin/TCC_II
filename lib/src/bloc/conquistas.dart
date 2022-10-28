import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quickalert/quickalert.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection =
    _firestore.collection('ListaConquistas');

class ConquistasBloc {
  static String? userUid;

// ADD ITEM
  static Future<void> addItem({
    required String nome,
    required double valor,
    required String fraseConquista,
    required String indentificador,
    required String userId,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(userId).collection('Conquistas').doc();

    Map<String, dynamic> data = <String, dynamic>{
      "nome": nome,
      "valor": valor,
      "descricao": fraseConquista,
      "indentificador": indentificador
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
        _mainCollection.doc(userId).collection('Conquistas');

    return notesItemCollection.snapshots();
  }

  // 1- Conquista
  // ignore: non_constant_identifier_names
  DepositoInicial({valor, userId, context}) async {
    await addItem(
        nome: "Primeiro deposito a gente nunca esquece!",
        valor: valor,
        fraseConquista: "AEEE, continue assim! :D",
        userId: userId,
        indentificador: "primeiroDeposito1");

    return QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      title: 'Conquista Realizada: Primeiro deposito a gente nunca esquece!',
      text: 'AEEE, continue assim! :D',
    );
  }

  // 2- Conquista
  // ignore: non_constant_identifier_names
  PrimeiroObjetivo({valor, userId, context}) async {
    await addItem(
        nome: "Criar um Objetivo!",
        valor: valor,
        fraseConquista: "Pronto! Seu objetivo foi criado! :D",
        userId: userId,
        indentificador: "PrimeiroObjetivo");

    return QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      title: 'Conquista Realizada: Criar um Objetivo!',
      text: 'Pronto! Seu objetivo foi criado! :D',
    );
  }

  // 3- Conquista
  // ignore: non_constant_identifier_names
  FinalizarObjetivo({valor, userId, context}) async {
    await addItem(
        nome: "Finalizar um Objetivo!",
        valor: valor,
        fraseConquista: "Isso aee, objetivo finalizado! :D",
        userId: userId,
        indentificador: "FinalizarObjetivo");

    return QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      title: 'Conquista Realizada: Finalizar um Objetivo!',
      text: 'Isso aee, objetivo finalizado! :D',
    );
  }

  // 4- Conquista
  // ignore: non_constant_identifier_names
  DepositoRealizado({valor, userId, context}) async {
    await addItem(
        nome: "Deposito Realizado!",
        valor: valor,
        fraseConquista: "Isso aee, seu deposito foi realizado! :D",
        userId: userId,
        indentificador: "DepositoRealizado");

    return QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      title: 'Conquista Realizada: Deposito Realizado!',
      text: 'Isso aee, seu deposito foi realizado! :D',
    );
  }

  // 5- Conquista
  // ignore: non_constant_identifier_names
  SaqueRealizado({valor, userId, context}) async {
    await addItem(
        nome: "Saque Realizado!",
        valor: valor,
        fraseConquista: "Cuidado pra não gastar muito! Brincadeirinha hehe :D",
        userId: userId,
        indentificador: "SaqueRealizado");

    return QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      title: 'Conquista Realizada: Saque Realizado!',
      text: 'Cuidado pra não gastar muito! Brincadeirinha hehe :D',
    );
  }
}
