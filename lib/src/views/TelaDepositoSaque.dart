// ignore_for_file: prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:fancy_bottom_navigation_2/fancy_bottom_navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickalert/quickalert.dart';
import 'package:tcc_ll/src/bloc/basebloc.dart';
import 'package:tcc_ll/src/bloc/conquistas.dart';
import 'package:tcc_ll/src/bloc/movimentacao.dart';
import 'package:tcc_ll/src/bloc/objetivo.dart';
import 'package:tcc_ll/src/views/TelaConquista.dart';
import 'package:tcc_ll/src/views/anmition/fadeanimation.dart';
import 'package:tcc_ll/src/views/telaObjetivo.dart';
import 'package:tcc_ll/src/views/telaPrincipal.dart';

// ignore: must_be_immutable
class CadastroDepositoSaque extends StatefulWidget {
  CadastroDepositoSaque({
    Key? key,
    required this.user,
    required this.movimento,
    required this.docId,
    required this.saldoAtual,
  }) : super(key: key);
  final User user;
  bool movimento;
  String docId;
  double saldoAtual;
  @override
  State<CadastroDepositoSaque> createState() => _CadastroDepositoSaqueState();
}
// TRUE = ANOTAÇÃO DE DEPOSITO
// FALSE = ANOTAÇÃO DE SAQUE
//FORMATAR VALOR COM MASKMONEY valorController.text.replaceAll(RegExp('[^0-9,]'), '')

class _CadastroDepositoSaqueState extends State<CadastroDepositoSaque> {
  int currentPage = 0;
  var bloc = MovimentacaoBloc();
  var blocBase = BaseBloc();
  var blocConquista = ConquistasBloc();

  final TextEditingController valorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var we = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nova movimentação"),
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => TelaInicial(
                      user: widget.user,
                    )));
          },
          iconSize: 30,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipPath(
              clipper: WaveClipperOne(),
              child: Container(
                height: 100,
                width: 450,
                color: Colors.blueAccent,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 5, right: 0),
                          child: Text("Cadastre sua nova movimentação!",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                letterSpacing: 0.5,
                                fontSize: 20,
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: he * 0.04,
            ),
            FadeAnimation(
              delay: 1,
              child: Container(
                width: we * 0.9,
                height: he * 0.071,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.orange,
                ),
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: valorController,
                  onTap: () {},
                  inputFormatters: [
                    CurrencyTextInputFormatter(
                      locale: 'pt_BR',
                    )
                  ],
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    enabledBorder: InputBorder.none,
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.attach_money_rounded,
                      color: Colors.white,
                    ),
                    hintText: 'Valor movimentação',
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: he * 0.04,
            ),
            FadeAnimation(
              delay: 1,
              child: TextButton(
                onPressed: () {
                  double valorMovimento =
                      blocBase.formatValor(valorController.text);
                  if (valorMovimento > widget.saldoAtual &&
                      widget.movimento == false) {
                    print(widget.saldoAtual);
                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.error,
                      title: 'Ops!',
                      text:
                          'Seu saldo é menor que o valor que você deseja sacar!',
                    );
                  } else {
                    MovimentacaoBloc.movimentaSaldo(
                        movimento: widget.movimento,
                        userId: widget.user.uid,
                        docId: widget.docId,
                        saldoAtual: widget.saldoAtual,
                        valoradicionado: valorMovimento);
                    if (widget.movimento &&
                        (widget.docId == null || widget.docId == '')) {
                      blocConquista.DepositoInicial(
                          userId: widget.user.uid, valor: valorMovimento);
                      QuickAlert.show(
                        context: context,
                        type: QuickAlertType.success,
                        title:
                            'Conquista realizada: primeiro deposito a gente nunca esquece!',
                        text: 'AEEE, continue assim! :D',
                        onConfirmBtnTap: () {
                          Navigator.of(context).pop();
                        },
                      );
                    }

                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => TelaInicial(
                              user: widget.user,
                            )));
                  }
                },
                child: Text(
                  "Cadastrar movimentação",
                  style: GoogleFonts.heebo(
                    color: Colors.white,
                    letterSpacing: 0.2,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 80),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: FancyBottomNavigation(
        circleColor: Colors.white,
        barBackgroundColor: Colors.blueAccent,
        activeIconColor: Colors.blueAccent,
        inactiveIconColor: Colors.white,
        textColor: Colors.white,
        tabs: [
          TabData(
            iconData: Icons.military_tech_outlined,
            title: "Conquistas",
            onclick: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => TelaConquista(
                        user: widget.user,
                      )));
            },
          ),
          TabData(
            iconData: Icons.home,
            title: "Inicio",
            onclick: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => TelaInicial(
                        user: widget.user,
                      )));
            },
          ),
          TabData(
              iconData: Icons.radar,
              title: "Objetivo",
              onclick: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => TelaObjetivo(
                          user: widget.user,
                        )));
              })
        ],
        initialSelection: 1,
        onTabChangedListener: (position) {
          setState(() {
            currentPage = position;
          });
        },
      ),
    );
  }
}
