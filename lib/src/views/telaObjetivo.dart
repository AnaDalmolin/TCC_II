// ignore: file_names
import 'package:fancy_bottom_navigation_2/fancy_bottom_navigation.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scaled_list/scaled_list.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:tcc_ll/src/bloc/objetivo.dart';
import 'package:tcc_ll/src/views/TelaConquista.dart';
import 'package:tcc_ll/src/views/anmition/fadeanimation.dart';
import 'package:tcc_ll/src/views/cadastroObjetivo.dart';
import 'package:tcc_ll/src/views/singup.dart';
import 'package:tcc_ll/src/views/telaPrincipal.dart';

class TelaObjetivo extends StatefulWidget {
  const TelaObjetivo({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  State<TelaObjetivo> createState() => _TelaObjetivoState();
}

class _TelaObjetivoState extends State<TelaObjetivo> {
  var bloc = ObjetivoBloc();
  List objetivos = [];
  @override
  void initState() {
    bloc.listarObjetivo(widget.user, objetivos);
    print(objetivos);
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
        title: const Text("Tela Objetivo"),
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
                            margin: const EdgeInsets.only(left: 50, right: 5),
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                        builder: (context) => CadastroObjetivo(
                                              user: widget.user,
                                            )));
                              },
                              child: Text(
                                "Criar Novo Objetivo +",
                                style: GoogleFonts.poppins(
                                  color: const Color.fromARGB(255, 230, 46, 0),
                                  letterSpacing: 0.2,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: TextButton.styleFrom(
                                side: const BorderSide(
                                  width: 3.0,
                                  color: Colors.deepPurple,
                                ),
                                backgroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 25),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
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
              child: ClipSmoothRect(
                child: Container(
                  // width: we * 0.6,
                  // height: 120,;
                  decoration: ShapeDecoration(
                    gradient: const LinearGradient(colors: [
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
            ScaledList(
              itemCount: objetivos.length,
              itemColor: (index) {
                return kMixedColors[index % kMixedColors.length];
              },
              itemBuilder: (index, selectedIndex) {
                final obj = objetivos[index];
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FadeAnimation(
                      delay: 1,
                      child: Container(
                        width: we * 0.8,
                        height: 150,
                        decoration: ShapeDecoration(
                          gradient: const LinearGradient(colors: [
                            Colors.deepOrange,
                            Colors.deepPurple,
                          ]),
                          shadows: [
                            BoxShadow(
                              color: Colors.grey,
                              // ignore: unnecessary_new
                              offset: new Offset(10.0, 10.0),
                              blurRadius: 10.0,
                            ),
                          ],
                          shape: SmoothRectangleBorder(
                            borderRadius: SmoothBorderRadius(
                              cornerRadius: 10,
                              cornerSmoothing: 0.5,
                            ),
                          ),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  Text(
                                    // objetivos.Nome[index],
                                    "Teste",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      letterSpacing: 0.2,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "50%",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          letterSpacing: 0.2,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: he * 0.03,
                                    width: he * 0.02,
                                  ),
                                  const SizedBox(
                                    width: 200,
                                    child: StepProgressIndicator(
                                      totalSteps: 100,
                                      currentStep: 50,
                                      size: 12,
                                      padding: 0,
                                      selectedColor: Colors.yellow,
                                      unselectedColor: Colors.cyan,
                                      roundedEdges: Radius.circular(10),
                                      selectedGradientColor: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Colors.yellowAccent,
                                          Colors.deepOrange
                                        ],
                                      ),
                                      unselectedGradientColor: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [Colors.white, Colors.white],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
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

  final List<Color> kMixedColors = [
    Color(0xff71A5D7),
    Color(0xff72CCD4),
    Color(0xffFBAB57),
    Color(0xffF8B993),
    Color(0xff962D17),
    Color(0xffc657fb),
    Color(0xfffb8457),
  ];
}
