

import 'package:flutter/cupertino.dart';
import 'package:tcc_ll/src/data/user_db.dart';
import 'package:tcc_ll/src/models/user_model.dart';

abstract class Cadastro {

  // final pageController = BehaviorSubject<List<User>>();
  // Stream<List<PaisModel>> get outListPais => pageController.stream;
  // Function(List<PaisModel>) get changeListPaises => pageController.sink.add;
  // List<PaisModel> get listPaises => pageController.value;

  cadastrar(nome, email, senha, telefone, data, responsavel){
    
    final newUser = User(1 ,nome, email, senha, telefone, data, responsavel);
    UserDB().save(newUser).then((value) => print(value));
  }

  @override
  void dispose(){}
  }
