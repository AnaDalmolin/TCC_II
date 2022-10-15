// ignore_for_file: prefer_const_constructors
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:fancy_bottom_navigation_2/fancy_bottom_navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickalert/quickalert.dart';
import 'package:tcc_ll/src/bloc/basebloc.dart';
import 'package:tcc_ll/src/bloc/movimentacao.dart';
import 'package:tcc_ll/src/bloc/objetivo.dart';
import 'package:tcc_ll/src/views/TelaConquista.dart';
import 'package:tcc_ll/src/views/anmition/fadeanimation.dart';
import 'package:tcc_ll/src/views/telaObjetivo.dart';
import 'package:tcc_ll/src/views/telaPrincipal.dart';

// ignore: must_be_immutable
class CadastroDepositoObjetivo extends StatefulWidget {
  const CadastroDepositoObjetivo(
      {Key? key,
      required this.user,
      required this.objetivo,
      required this.docId})
      : super(key: key);
  final User user;
  final Object objetivo;
  final String docId;
  @override
  State<CadastroDepositoObjetivo> createState() =>
      _CadastroDepositoObjetivoState();
}
// TRUE = ANOTAÇÃO DE DEPOSITO
// FALSE = ANOTAÇÃO DE SAQUE
//FORMATAR VALOR COM MASKMONEY valorController.text.replaceAll(RegExp('[^0-9,]'), '')

class _CadastroDepositoObjetivoState extends State<CadastroDepositoObjetivo> {
  int currentPage = 0;
  var bloc = MovimentacaoBloc();
  var blocBase = BaseBloc();

  final TextEditingController valorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var we = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Guardar para objetivo!"),
        backgroundColor: const Color.fromARGB(255, 230, 46, 0),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipPath(
              clipper: WaveClipperOne(),
              child: Container(
                height: 100,
                width: 450,
                color: const Color.fromARGB(255, 230, 46, 0),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 60, right: 0),
                          child: Text("Guardar para objetivo!",
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
                  color: const Color.fromARGB(255, 241, 67, 24),
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
                    hintText: 'Valor Movimentação',
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
                onPressed: () async {
                  var data = widget.objetivo as Map;
                  if (DatabaseObjetivo.somaDeposito(
                          valorExistente: data['deposito'],
                          valorDepositado:
                              blocBase.formatValor(valorController.text)) >
                      data['valor']) {
                    return QuickAlert.show(
                      context: context,
                      type: QuickAlertType.error,
                      title: 'Oops...',
                      text:
                          'O valor do seu deposito é maior que o valor do objetivo!',
                    );
                  } else {
                    await DatabaseObjetivo.updateItem(
                        nome: data["nome"],
                        valor: data["valor"],
                        descricao: data["descricao"],
                        deposito: DatabaseObjetivo.somaDeposito(
                            valorExistente: data['deposito'],
                            valorDepositado:
                                blocBase.formatValor(valorController.text)),
                        userId: widget.user.uid,
                        docId: widget.docId);
                    if (data['valor'] ==
                        DatabaseObjetivo.somaDeposito(
                            valorExistente: data['deposito'],
                            valorDepositado:
                                blocBase.formatValor(valorController.text))) {
                      return QuickAlert.show(
                        context: context,
                        type: QuickAlertType.success,
                        title: 'AEEEEE',
                        text: 'Parabéns você finalizou o seu objetivo!',
                        onConfirmBtnTap: () {
                          DatabaseObjetivo.objetivoConcluido(
                              user: widget.user.uid,
                              valor: data['valor'],
                              nome: data['nome'],
                              docId: widget.docId);
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => TelaObjetivo(
                                      user: widget.user,
                                    )),
                          );
                        },
                      );
                    }
                  }
                },
                child: Text(
                  "Cadastrar Movimentação",
                  style: GoogleFonts.heebo(
                    color: Colors.white,
                    letterSpacing: 0.2,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Color.fromARGB(226, 171, 7, 177),
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
        barBackgroundColor: const Color.fromARGB(255, 230, 46, 0),
        activeIconColor: const Color.fromARGB(255, 230, 46, 0),
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
