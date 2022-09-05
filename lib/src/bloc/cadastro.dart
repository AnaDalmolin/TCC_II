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

  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<User> handleSignInEmail(email, password) async {
    UserCredential result =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    final User user = result.user!;

    return user;
  }

  Future<User> handleSignUp(email, password) async {
    UserCredential result = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    final User user = result.user!;

    return user;
  }

  // static login(email, password) async {
  //   FirebaseAuth auth = FirebaseAuth.instance;
  //   final FirebaseAuth user = (await auth.signInWithEmailAndPassword(
  //           email: email, password: password))
  //       .user as FirebaseAuth;
  //   return user;
  // }

  CadastroPerfil(nome, data, telefone, responsavel, termo) {
    print(nome);
    print(data);
    print(telefone);
    print(responsavel);
    print(termo);
  }

  static void setState(Null Function() param0) {}

  // @override
  // void dispose() {}
}
