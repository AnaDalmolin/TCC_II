

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:tcc_ll/src/models/user_model.dart';

abstract class Cadastro {

  // final pageController = BehaviorSubject<List<User>>();
  // Stream<List<PaisModel>> get outListPais => pageController.stream;
  // Function(List<PaisModel>) get changeListPaises => pageController.sink.add;
  // List<PaisModel> get listPaises => pageController.value;


  // CRIAR USUÁRIO PELA TABELA DE BANCO DE DADOS.
  // cadastrar(nome, email, senha, telefone, data, responsavel){
    
  //   final newUser = User(1 ,nome, email, senha, telefone, data, responsavel);
  //   UserDB().save(newUser).then((value) => print(value));
  // }

  //CRIANDO PELO FIREBASE
  void register(email, password) async{
    try {
      UserCredential user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      if(email != null && password != null){
        //NAVEGAR PARA PÁGINA DE DASHBOARD
      }
    } catch (e) {
      print(e);
    }
  }
  
  void login(email, password) async{
    try {
      UserCredential user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      if(email != null){
        //NAVEGAR PARA PÁGINA DE DASHBOARD
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose(){}
  }
