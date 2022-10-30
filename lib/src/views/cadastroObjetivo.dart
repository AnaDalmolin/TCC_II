// ignore_for_file: prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:fancy_bottom_navigation_2/fancy_bottom_navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcc_ll/src/bloc/basebloc.dart';
import 'package:tcc_ll/src/bloc/conquistas.dart';
import 'package:tcc_ll/src/bloc/objetivo.dart';
import 'package:tcc_ll/src/bloc/objetivo.dart';
import 'package:tcc_ll/src/views/TelaConquista.dart';
import 'package:tcc_ll/src/views/anmition/fadeanimation.dart';
import 'package:tcc_ll/src/views/telaObjetivo.dart';
import 'package:tcc_ll/src/views/telaPrincipal.dart';

class CadastroObjetivo extends StatefulWidget {
  const CadastroObjetivo({Key? key, required this.user}) : super(key: key);
  final User user;
  @override
  State<CadastroObjetivo> createState() => _CadastroObjetivoState();
}

class _CadastroObjetivoState extends State<CadastroObjetivo> {
  int currentPage = 0;
  var blocBase = BaseBloc();

  final TextEditingController nomeController = TextEditingController();
  final TextEditingController valorController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var we = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Novo Objetivo"),
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
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                            margin: const EdgeInsets.only(left: 5, right: 0),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                margin:
                                    const EdgeInsets.only(left: 10, right: 5),
                                child: Text("Cadastre Seu Novo Objetivo!",
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      letterSpacing: 0.5,
                                      fontSize: 20,
                                    )),
                              ),
                            ),
                          ),
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
                  controller: nomeController,
                  onTap: () {},
                  decoration: const InputDecoration(
                    enabledBorder: InputBorder.none,
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.radar,
                      color: Colors.white,
                    ),
                    hintText: 'Nome Objetivo',
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
                    hintText: 'Valor Objetivo',
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
              child: Container(
                width: we * 0.9,
                height: he * 0.071,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: const Color.fromARGB(255, 241, 67, 24),
                ),
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: descricaoController,
                  onTap: () {},
                  decoration: const InputDecoration(
                    enabledBorder: InputBorder.none,
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.description_outlined,
                      color: Colors.white,
                    ),
                    hintText: 'Descrição Objetivo',
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
              child: StreamBuilder<QuerySnapshot>(
                  stream: ConquistasBloc.readItems(userId: widget.user.uid),
                  builder: (context, snapshot) {
                    return TextButton(
                      onPressed: () async {
                        bool conquistaLiberada = false;

                        if (snapshot.hasError) {
                          print('');
                        }
                        for (var i = 0; i < snapshot.data!.docs.length; i++) {
                          var docFor = snapshot.data!.docs[i];
                          var dataFor = docFor.data() as Map;
                          if (dataFor['indentificador'] == 'PrimeiroObjetivo') {
                            conquistaLiberada = true;
                          }
                        }

                        await DatabaseObjetivo.addItem(
                            nome: nomeController.text,
                            valor: blocBase.formatValor(valorController.text),
                            descricao: descricaoController.text,
                            deposito: 0,
                            userId: widget.user.uid);
                        if (conquistaLiberada == false) {
                          ConquistasBloc().PrimeiroObjetivo(
                              context: context,
                              userId: widget.user.uid,
                              valor:
                                  BaseBloc().formatValor(valorController.text));
                        }
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => TelaObjetivo(
                                  user: widget.user,
                                )));
                      },
                      child: Text(
                        "Cadastrar informações",
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
                    );
                  }),
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
        initialSelection: 2,
        onTabChangedListener: (position) {
          setState(() {
            currentPage = position;
          });
        },
      ),
    );
  }
}
