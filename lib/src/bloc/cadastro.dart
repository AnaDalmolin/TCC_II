import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class CadastroBloc {
  bool termo = false;
  bool responsalvel = false;

  final FirebaseAuth auth = FirebaseAuth.instance;

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

  CadastroPerfil(nome, data, telefone, responsavel, termo) {
    print(nome);
    print(data);
    print(telefone);
    print(responsavel);
    print(termo);
  }

  // @override
  // void dispose() {}
}
