import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class MovimentacaoBloc {
  final db = FirebaseFirestore.instance;

  listarAnotacoesMovimentacao(user, list) async {
    List listFilter = [];
    final QuerySnapshot result = await Future.value(
        FirebaseFirestore.instance.collection("CadastroMovimentacao").get());
    for (var i = 0; i < result.size; i++) {
      listFilter.add(result.docs[i].data());
      listFilter[i]["Data"];
      if (listFilter[i]["id"] == user.uid) {
        list.add(listFilter[i]);
      }
    }
    return list;
  }

  listarUltimaAnotacao(user, list) async {
    List listFilter = [];
    final QuerySnapshot result = await Future.value(
        FirebaseFirestore.instance.collection("CadastroMovimentacao").get());
    for (var i = 0; i < result.size; i++) {
      listFilter.add(result.docs[i].data());
      listFilter[i]["Data"];
      if (listFilter[i]["id"] == user.uid) {
        list.add(listFilter[i]);
      }
    }
    return list;
  }

  movimentoPoridUsuario(user) async {
    final QuerySnapshot result = await Future.value(FirebaseFirestore.instance
        .collection("CadastroMovimentacao")
        .where("id", isEqualTo: user.uid)
        .get());
  }

  movimentacao(listMovimentacao, movimento) {
    if (movimento == true) {
    } else if (movimento == false) {}
  }

  // ignore: non_constant_identifier_names
  CadastroAnotacaoMovimentacao(valor, user, movimentacao) async {
    List listMovimetacao = [];

    await listarAnotacoesMovimentacao(user, listMovimetacao);
    if (listMovimetacao.isNotEmpty) {
      for (var i = 0; i < listMovimetacao.length; i++) {
        print(listMovimetacao[i].db);
        // if (listMovimetacao[i]["id"] == user.uid) {
        //   print(listMovimetacao[i].reference.id);
        //   db.collection('CadastroMovimentacao').doc(user.uid).set(
        //     {
        //       "valor": valor,
        //     },
        //   );
        // } else {
        //   print(listMovimetacao[i].reference.id);
        //   db.collection('CadastroMovimentacao').add(
        //     {
        //       "id": user.uid,
        //       "valor": valor,
        //       "movimentacao": movimentacao,
        //       "data": DateFormat("yyyy-MM-dd").format(DateTime.now())
        //     },
        //   );
        // }
      }
    } else {
      db.collection('CadastroMovimentacao').add(
        {
          "id": user.uid,
          "valor": valor,
          "movimentacao": movimentacao,
          "data": DateFormat("yyyy-MM-dd").format(DateTime.now())
        },
      );
    }

    // db.collection('CadastroMovimentacao').add(
    //   {
    //     "id": user.uid,
    //     "Valor": valor,
    //     "Movimentação": movimentacao,
    //     "Data": DateFormat("yyyy-MM-dd").format(DateTime.now())
    //   },
    // );
  }
  // // ignore: non_constant_identifier_names
  // CadastroAnotacaoMovimentacao(valor, user, movimentacao) async {
  //   List listMovimetacao = [];
  //   List ultimoMovimento = [];
  //   await listarAnotacoesMovimentacao(user, listMovimetacao);

  //   for (var i = 0; i < listMovimetacao.length; i++) {
  //     print('PELO MENOS ENTREI AQUI');

  //     if (ultimoMovimento.isEmpty) {
  //       ultimoMovimento.add(listMovimetacao[i]);
  //     } else if (DateTime.parse(listMovimetacao[i]["Data"])
  //         .isBefore(DateTime.parse(ultimoMovimento[0]["Data"]))) {
  //       ultimoMovimento.clear();
  //       ultimoMovimento.add(listMovimetacao[i]);
  //       print("Entrou   AQUI NESSA else");
  //     }
  //   }

  //   // db.collection('CadastroMovimentacao').add(
  //   //   {
  //   //     "id": user.uid,
  //   //     "Valor": valor,
  //   //     "Movimentação": movimentacao,
  //   //     "Data": DateFormat("yyyy-MM-dd").format(DateTime.now())
  //   //   },
  //   // );
  // }

  // @override
  // void dispose() {}
}
