// ignore_for_file: prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_bottom_navigation_2/fancy_bottom_navigation.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcc_ll/src/bloc/conquistas.dart';
import 'package:tcc_ll/src/views/anmition/fadeanimation.dart';
import 'package:tcc_ll/src/views/singup.dart';
import 'package:tcc_ll/src/views/telaObjetivo.dart';
import 'package:tcc_ll/src/views/telaPrincipal.dart';

// ignore: must_be_immutable
class TelaConquista extends StatefulWidget {
  TelaConquista({Key? key, required this.user}) : super(key: key);
  User user;
  @override
  State<TelaConquista> createState() => _TelaConquistaState();
}

class _TelaConquistaState extends State<TelaConquista> {
  int currentPage = 0;
  bool ispasswordev = true;
  Gender? selected;

  var blocConquista = ConquistasBloc();

  @override
  Widget build(BuildContext context) {
    var we = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Suas conquistas"),
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
        scrollDirection: Axis.vertical,
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
                          margin: const EdgeInsets.only(left: 100, right: 0),
                          child: Text("Suas conquistas",
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
            FadeAnimation(
              delay: 1,
              child: ClipSmoothRect(
                child: Container(
                  // width: we * 0.6,
                  // height: 120,;
                  decoration: ShapeDecoration(
                    gradient: LinearGradient(colors: const [
                      Colors.deepOrange,
                      Color.fromARGB(255, 221, 27, 37),
                    ]),
                    shape: SmoothRectangleBorder(
                      borderRadius: SmoothBorderRadius(
                        cornerRadius: 10,
                        cornerSmoothing: 0.5,
                      ),
                    ),
                  ),
                  // padding: const EdgeInsets.all(8.0),
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
                    if (snapshot.hasError) {
                      print('');
                    } else if (snapshot.data?.docs.length == 0 ||
                        snapshot.data == null) {
                      return Container(
                        width: we * 0.9,
                        height: he * 0.11,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.orange,
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.military_tech),
                              color: Colors.white,
                              onPressed: () {},
                              iconSize: 30,
                            ),
                            Text("Depositar qualquer valor.",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  letterSpacing: 0.5,
                                  fontSize: 18,
                                )),
                            IconButton(
                              icon: Icon(Icons.cancel_presentation_sharp),
                              color: Colors.red,
                              onPressed: () {},
                              iconSize: 30,
                            ),
                          ],
                        ),
                      );
                    } else if (snapshot.hasData || snapshot.data != null) {
                      bool concluida = false;
                      for (var i = 0; i < snapshot.data!.docs.length; i++) {
                        var docFor = snapshot.data!.docs[i];
                        var dataFor = docFor.data() as Map;
                        if (dataFor['indentificador'] == 'primeiroDeposito1') {
                          concluida = true;
                        }
                      }
                      return Container(
                        width: we * 0.9,
                        height: he * 0.11,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.orange,
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.military_tech),
                              color: Colors.white,
                              onPressed: () {},
                              iconSize: 30,
                            ),
                            Text("Depositar qualquer valor.",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  letterSpacing: 0.5,
                                  fontSize: 18,
                                )),
                            IconButton(
                              icon: Icon(concluida == true
                                  ? Icons.task_alt_rounded
                                  : Icons.cancel_presentation_sharp),
                              color: concluida == true
                                  ? Colors.green
                                  : Colors.white,
                              onPressed: () {},
                              iconSize: 30,
                            ),
                          ],
                        ),
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
            SizedBox(
              height: he * 0.04,
            ),
            FadeAnimation(
              delay: 1,
              child: StreamBuilder<QuerySnapshot>(
                  stream: ConquistasBloc.readItems(userId: widget.user.uid),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      print('');
                    } else if (snapshot.data?.docs.length == 0 ||
                        snapshot.data == null) {
                      return Container(
                        width: we * 0.9,
                        height: he * 0.11,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.orange,
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.military_tech),
                              color: Colors.white,
                              onPressed: () {},
                              iconSize: 30,
                            ),
                            Text("Criar um objetivo.",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  letterSpacing: 0.5,
                                  fontSize: 18,
                                )),
                            IconButton(
                              padding: const EdgeInsets.fromLTRB(85, 0, 0, 0),
                              icon: Icon(Icons.cancel_presentation_sharp),
                              color: Colors.red,
                              onPressed: () {},
                              iconSize: 30,
                            ),
                          ],
                        ),
                      );
                    } else if (snapshot.hasData || snapshot.data != null) {
                      bool concluida = false;
                      for (var i = 0; i < snapshot.data!.docs.length; i++) {
                        var docFor = snapshot.data!.docs[i];
                        var dataFor = docFor.data() as Map;
                        if (dataFor['indentificador'] == 'PrimeiroObjetivo') {
                          concluida = true;
                        }
                      }
                      return Container(
                        width: we * 0.9,
                        height: he * 0.11,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.orange,
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.military_tech),
                              color: Colors.white,
                              onPressed: () {},
                              iconSize: 30,
                            ),
                            Text("Criar um objetivo.",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  letterSpacing: 0.5,
                                  fontSize: 18,
                                )),
                            IconButton(
                              padding: const EdgeInsets.fromLTRB(85, 0, 0, 0),
                              icon: Icon(concluida == true
                                  ? Icons.task_alt_rounded
                                  : Icons.cancel_presentation_sharp),
                              color: concluida == true
                                  ? Colors.green
                                  : Colors.white,
                              onPressed: () {},
                              iconSize: 30,
                            ),
                          ],
                        ),
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
            SizedBox(
              height: he * 0.04,
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
            onclick: () {},
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
        initialSelection: 0,
        onTabChangedListener: (position) {
          setState(() {
            currentPage = position;
          });
        },
      ),
    );
  }
}
