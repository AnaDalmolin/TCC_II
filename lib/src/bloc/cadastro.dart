import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CadastroBloc {
  bool termo = false;
  bool responsalvel = false;

  final FirebaseAuth auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;

  //FUNCAO PARA USUARIO LOGAR COM A CONTA CRIADA NO FIREBASE
  static Future<User?> signInUsingEmailPassword({
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    User? user;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // ignore: avoid_print
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        // ignore: avoid_print
        print('Wrong password provided.');
      } else {
        // ignore: avoid_print
        print("dados incoretos");
      }
    }

    return user;
  }

  IndentificarResponsavel(user, responsavel) async {
    final QuerySnapshot result = await Future.value(
        FirebaseFirestore.instance.collection("CadastroPerfil").get());
  }

  //FUNCAO PARA O USUARIO CRIAR UMA CONTA NO FIREBASE
  static Future<User?> registerUsingEmailPassword({
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        // ignore: avoid_print
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        // ignore: avoid_print
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return user;
  }

  // ignore: non_constant_identifier_names
  CadastroPerfil(nome, data, telefone, responsavel, termo, id) {
    db.collection('CadastroPerfil').add(
      {
        "id": id,
        "Nome": nome,
        "Data": data,
        "Telefone": telefone,
        "Responsavel": responsavel,
        "termo": termo,
      },
    );
  }

  // ignore: non_constant_identifier_names
  ValidaCadastro(user) async {
    final QuerySnapshot result = await Future.value(
        FirebaseFirestore.instance.collection("CadastroPerfil").get());
    bool validacaoCadastro = false;

    // ignore: unnecessary_null_comparison
    if (result != null) {
      for (var i = 0; i < result.docs.length; i++) {
        if (result.docs[i]["id"] == user) {
          validacaoCadastro = true;
        }
      }
    }
    return validacaoCadastro;
  }

  validarTipoUsuario(user) async {
    final QuerySnapshot result = await Future.value(
        FirebaseFirestore.instance.collection("CadastroPerfil").get());
    bool responsalvel = false;

    for (var i = 0; i < result.docs.length; i++) {
      if (result.docs[i]["id"] == user) {
        responsalvel = result.docs[i]["Responsavel"];
      }
    }

    return responsalvel;
  }

  // @override
  // void dispose() {}
}
