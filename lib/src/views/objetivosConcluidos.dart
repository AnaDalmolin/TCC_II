// ignore: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_bottom_navigation_2/fancy_bottom_navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scaled_list/scaled_list.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:tcc_ll/src/bloc/objetivo.dart';
import 'package:tcc_ll/src/views/TelaConquista.dart';
import 'package:tcc_ll/src/views/cadastroObjetivo.dart';
import 'package:tcc_ll/src/views/depositoObjetivo.dart';
import 'package:tcc_ll/src/views/singup.dart';
import 'package:tcc_ll/src/views/telaObjetivo.dart';
import 'package:tcc_ll/src/views/telaPrincipal.dart';

class TelaObjetivoConcluido extends StatefulWidget {
  const TelaObjetivoConcluido({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  State<TelaObjetivoConcluido> createState() => _TelaObjetivoConcluidoState();
}

class _TelaObjetivoConcluidoState extends State<TelaObjetivoConcluido> {
  @override
  void initState() {
    super.initState();
  }

  int currentPage = 0;
  bool ispasswordev = true;
  Gender? selected;
  @override
  Widget build(BuildContext context) {
    var we = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tela objetivos concluídos"),
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => TelaObjetivo(
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
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                            margin: const EdgeInsets.only(left: 60, right: 5),
                            child: Text("Objetivos concluídos",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  letterSpacing: 0.5,
                                  fontSize: 20,
                                )),
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
            StreamBuilder<QuerySnapshot>(
                stream: DatabaseObjetivo.readObjetivosConcluidos(
                    userId: widget.user.uid),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  } else if (snapshot.hasData || snapshot.data != null) {
                    return ScaledList(
                      cardWidthRatio: 0.75,
                      selectedCardHeightRatio: 0.75,
                      unSelectedCardHeightRatio: 0.50,
                      itemCount: snapshot.data!.docs.length,
                      itemColor: (index) {
                        return kMixedColors[index % kMixedColors.length];
                      },
                      itemBuilder: (index, selectedIndex) {
                        var doc = snapshot.data!.docs[index];
                        var data = doc.data() as Map;
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: he * 0.05,
                                ),
                                IconButton(
                                  icon: Icon(Icons.radar),
                                  color: Colors.orange,
                                  onPressed: () {},
                                  iconSize: 30,
                                ),
                                Text(data['nome'],
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      letterSpacing: 0.5,
                                      fontSize: 30,
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: he * 0.04,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: he * 0.05,
                                ),
                                IconButton(
                                  icon: Icon(Icons.monetization_on_outlined),
                                  color: Colors.orange,
                                  onPressed: () {},
                                  iconSize: 30,
                                ),
                                Text(
                                    "Valor: " +
                                        data['valor'].toStringAsFixed(2),
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      letterSpacing: 0.5,
                                      fontSize: 20,
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: he * 0.04,
                            ),
                          ],
                        );
                      },
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
                  builder: (context) => TelaInicial(user: widget.user)));
            },
          ),
          TabData(
              iconData: Icons.radar,
              title: "Objetivo",
              onclick: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => TelaObjetivo(user: widget.user)));
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

  // formatarValor(valor) {
  //   String retorno = valor.replace(/\D/g, '');

  //   print(retorno);
  //   return retorno;
  // }

  final List<Color> kMixedColors = [Colors.blueAccent];
}
