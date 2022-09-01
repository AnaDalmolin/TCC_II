import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class CadastroBloc {
  bool termo = false;
  bool responsalvel = false;

  //CRIANDO PELO FIREBASE
  static register(email, password) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  static login(email, password) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
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
