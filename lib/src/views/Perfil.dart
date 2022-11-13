// ignore_for_file: prefer_const_constructors, deprecated_member_use
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_bottom_navigation_2/fancy_bottom_navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcc_ll/src/bloc/cadastro.dart';
import 'package:tcc_ll/src/bloc/movimentacao.dart';
import 'package:tcc_ll/src/views/TelaConquista.dart';
import 'package:tcc_ll/src/views/TelaDepositoSaque.dart';
import 'package:tcc_ll/src/views/TelaPrincipalResponsavel.dart';
import 'package:tcc_ll/src/views/singup.dart';
import 'package:tcc_ll/src/views/telaObjetivo.dart';
import 'package:tcc_ll/src/views/telaPrincipal.dart';

// ignore: must_be_immutable
class TelaPerfil extends StatefulWidget {
  TelaPerfil({Key? key, required this.user, required this.responsavel})
      : super(key: key);
  bool responsavel;
  User user;
  @override
  State<TelaPerfil> createState() => _TelaPerfilState();
}

class _TelaPerfilState extends State<TelaPerfil> {
  int currentPage = 0;
  bool ispasswordev = true;
  Gender? selected;
  List movimentacao = [];

  var bloc = MovimentacaoBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var we = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Perfil"),
        backgroundColor: const Color.fromARGB(255, 230, 46, 0),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            if (widget.responsavel) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => TelaPrincipalResponsavel(
                        user: widget.user,
                        responsavel: widget.responsavel,
                      )));
            } else {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => TelaInicial(
                        user: widget.user,
                      )));
            }
          },
          iconSize: 30,
        ),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<QuerySnapshot>(
            stream: CadastroBloc.readItems(userId: widget.user.uid),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }
              if (snapshot.hasData || snapshot.data != null) {
                var doc = snapshot.data!.docs[0];
                var data = doc.data() as Map;
                return Column(
                  children: [
                    Center(
                      heightFactor: 1.5,
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: IconButton(
                          iconSize: 150,
                          icon: Icon(Icons.person),
                          color: Colors.deepPurple,
                          onPressed: () {},
                        ),
                      ),
                    ),
                    SizedBox(
                      height: he * 0.01,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20, right: 5),
                      child: Text(data['Nome'],
                          style: GoogleFonts.poppins(
                            color: Colors.deepOrange,
                            letterSpacing: 0.5,
                            fontSize: 30,
                          )),
                    ),
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 45, right: 5),
                          child: Text("ID: ",
                              style: GoogleFonts.poppins(
                                color: Colors.deepOrange,
                                letterSpacing: 0.5,
                                fontSize: 25,
                              )),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 5, right: 5),
                          child: Text(doc.id,
                              style: GoogleFonts.poppins(
                                color: Colors.purple[900],
                                letterSpacing: 0.5,
                                fontSize: 20,
                              )),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: he * 0.02,
                    ),
                    TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Política de privacidade."),
                              content: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Text(
                                    "Ao utilizar as aplicações  Ana Caroline Dal Molin, você concorda com estas condições. Por gentileza, leia com atenção todas as informações. Caso não concorde com estas condições, não utilize a aplicação.  Sobre o Aplicativo É um aplicativo mobile, onde tem o intuído de fazer com que adolecentes e jovens aprendam a gerenciar seu dinheirode uma maneira organizada e divertida. No aplicativo é possível iniciar com alguns objetivos para guardar o dinheiro para comprar um determinado item que esse usuário deseja. Além disso é possível depositar algum valor direto no objetivo para saber o quanto já tem e quanto falta para conseguir alcançar. Além disso a aplicação, tem a opção de depositar e sacar valores que já foram inseridos na aplicação. Todas os calculos de quanto o usuário já tem na aplicação ou retirou fica armazenado nos históricos. Depois que o usuário já atingiu alguma conquista essa fica armazenada nas conquistas. Existe a possibilidade de ter um usuário que vai ser o responsável, no qual vai conseguir acompanhar as movimentações, objetivos e conquistas de se afiliados. Essa funcionalidade é para os pais terem controle sobre como os seus filhos estão gerenciando seu dinheiro e aonde está sendo gasto esses valores que estarem visiveis nas conquistas. CONTATO: anadv21@gmail.com. Princípios de Privacidade Sobre as principais práticas de privacidade: ● Essa aplicação foi desenvolvida para auxiliar os adolecentes e jovens a controlar sua vida financeira; ● As informações coletadas no aplicativo mobile vão ser utilizados somente para uso na aplicação; ● Não é feita a venda de informações pessoais ou quais quer tipos de informações coletadas no aplicativo. ● Suas informações são armazenadas em bancos de dados onde os dados sensíveis serão criptografados. CONTATO: anadv21@gmail.com. Informações pessoais que podemos coletar: As informações coletadas no aplicativo são as informações inseridas na hora do cadastro. Não vamos perdir para informar novamente os dados durante o usuário da aplicação. Os seus dados serão utilizados dentro da aplicação para exibição, autenticação e validação. CONTATO: anadv21@gmail.com. Mudanças na Política de privacidade Quaisquer mudanças que venham a ocorrer na política de privacidade ou em outra área da aplicação serão enviadas aos usuários através dos meios de comunicação como e-mail, redes sociais e até mesmo avisos no aplicativo. CONTATO: anadv21@gmail.com. Termos de serviço SUA CONTA Ao utilizar o aplicativo Ana Caroline Dal Molin você é responsável por manter a confidencialidade de sua conta e senha e restringir o acesso ao seu aparelho celular, e responsabiliza-se por todas as atividades que ocorram com sua conta ou sua senha.  reserva-se o direito de encerrar contas, remover ou editar conteúdo da aplicação; CONTATO: anadv21@gmail.com."),
                              ),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text("OK"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Text(
                        "Termos de condição",
                        style: GoogleFonts.poppins(
                          color: Color.fromARGB(226, 171, 7, 177),
                          letterSpacing: 0.2,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        side: BorderSide(
                          width: 3.0,
                          color: Color.fromARGB(226, 171, 7, 177),
                        ),
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 25),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                  ],
                );
              }
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.orangeAccent,
                  ),
                ),
              );
            }),
      ),
    );
  }
}
