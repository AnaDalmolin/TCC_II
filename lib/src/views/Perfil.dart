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
                      onPressed: () {},
                      child: Text(
                        "Trocar senha",
                        style: GoogleFonts.poppins(
                          color: const Color.fromARGB(255, 230, 46, 0),
                          letterSpacing: 0.2,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        side: BorderSide(
                          width: 3.0,
                          color: const Color.fromARGB(255, 230, 46, 0),
                        ),
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 25),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
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
                              title: Text("Termos de condição."),
                              content: Text(
                                  "Por este instrumento particular de Contrato de Prestação de Serviços, de um lado a, (Aplicativo desenvolvido pela estudante Ana Caroline), com sede a rua Mário de barros, nº 922, residência – Centro Sul – Dois Vizinhos - Paraná, CEP nº 85660-000, doravante denominada simplesmente  CONTRATADA, e de outro lado, como CONTRATANTE  a pessoa física/ jurídica identificada no “TERMO DE ADESÃO” , tem entre si justo e acordado uma vez aceita a referida proposta, o que se segue”: 1- OBJETO Na qualidade de prestador de serviços de controle financeiro para jovens e adolescentes, a CONTRATADA  coloca a disposição da CONTRATANTE os serviços de serviços de controle financeiro para jovens e adolescentes  via online descritos no “TERMO DE ADESÃO”. – Os serviços oferecidos são: - Cadastro de progressão e conclusão de objetivos. - Anotações de depósitos e saques. - Movimentações e gráficos referentes a das as ações realizadas pelo afiliado no aplicativo. - Controle para os responsáveis referentes as movimentações realizadas pelos jovens e adolescentes. - Disponibilização de conquistas referentes a progressão do usuário. 3 – DAS OBRIGAÇÕES DA CONTRATADA 3.1 – A  CONTRATADA disponibilizará um “username” (“Nome do Usuário”) e um “password” (“Senha de Acesso”), “Data de Nascimento”(Data de nascimento do usuário), “Telefone” e “Email”   que serão sua identificação junto a CONTRATADA; 3.2 – A CONTRATADA disponibilizará os serviços ora contratados e manterá os serviços conforme o plano escolhido pela CONTRATANTE especificado no Termo de Adesão, enviando a CONTRATANTE as informações via e-mail, ao endereço previamente fornecido pela  CONTRATANTE. 3.3 – A CONTRATADA envidará os melhores esforços para assegurar e desenvolver a qualidade do serviço ora contratado, comprometendo-se ainda, a respeitar a privacidade do CONTRATANTE, garantindo que não divulgara sua senha de acesso ou e-mail de acesso. Não será efetuada nenhum tipo de MULTA/REAJUSTE devido aos serviços fornecidos serem completamente gratuitos. Sendo contratado o acesso à Prestação de Serviços via on-line (Aplicativo móvel), o mesmo poderá, eventualmente, sofrer interrupções devido a: (a) manutenções técnicas e/ou operacionais que exijam o desligamento temporário do sistema ou impossibilitem o acesso; (b) casos fortuitos ou força maior; (c) falta de fornecimento de energia elétrica para o sistema da CONTRATADA; (e) ocorrências de falhas no sistema de transmissão e/ou roteamento no acesso à internet;"),
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
