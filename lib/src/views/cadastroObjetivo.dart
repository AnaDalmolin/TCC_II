// ignore_for_file: prefer_const_constructors
import 'package:fancy_bottom_navigation_2/fancy_bottom_navigation.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcc_ll/src/views/TelaConquista.dart';
import 'package:tcc_ll/src/views/anmition/fadeanimation.dart';
import 'package:tcc_ll/src/views/singup.dart';
import 'package:tcc_ll/src/views/telaObjetivo.dart';
import 'package:tcc_ll/src/views/telaPrincipal.dart';

class CadastroObjetivo extends StatefulWidget {
  const CadastroObjetivo({Key? key}) : super(key: key);

  @override
  State<CadastroObjetivo> createState() => _CadastroObjetivoState();
}

class _CadastroObjetivoState extends State<CadastroObjetivo> {
  int currentPage = 0;
  bool ispasswordev = true;
  Gender? selected;
  @override
  Widget build(BuildContext context) {
    var we = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tela Conquistas"),
        backgroundColor: const Color.fromARGB(255, 230, 46, 0),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          children: [
            ClipPath(
              clipper: WaveClipperOne(),
              child: Container(
                height: 100,
                width: 400,
                color: const Color.fromARGB(255, 230, 46, 0),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Text(
                          "Criar Novo Objetivo +",
                          style: GoogleFonts.poppins(
                            color: const Color.fromARGB(255, 230, 46, 0),
                            letterSpacing: 0.2,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
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
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => TelaConquista()));
            },
          ),
          TabData(
            iconData: Icons.home,
            title: "Inicio",
            onclick: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => TelaInicial()));
            },
          ),
          TabData(
              iconData: Icons.radar,
              title: "Objetivo",
              onclick: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => TelaObjetivo()));
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
