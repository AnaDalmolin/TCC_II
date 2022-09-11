// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcc_ll/src/views/anmition/fadeanimation.dart';

class TelaInicial extends StatefulWidget {
  const TelaInicial({Key? key}) : super(key: key);

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  @override
  Widget build(BuildContext context) {
    var we = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tela Inicial"),
        backgroundColor: const Color.fromARGB(255, 230, 46, 0),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipPath(
              clipper: WaveClipperOne(),
              child: Container(
                height: 100,
                color: const Color.fromARGB(255, 230, 46, 0),
                child: const Center(),
              ),
            ),
            SizedBox(
              height: he * 0.04,
            ),
            FadeAnimation(
              delay: 1,
              child: Container(
                width: we * 0.6,
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: const Color.fromARGB(187, 171, 7, 177),
                ),
                child: Column(
                  children: [
                    Row(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            margin: const EdgeInsets.only(
                              left: 100,
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.remove_red_eye),
                              color: Colors.white,
                              onPressed: () {},
                              iconSize: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            margin: const EdgeInsets.only(left: 20, right: 5),
                            child: Text("Saldo",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  letterSpacing: 0.5,
                                  fontSize: 30,
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            margin: const EdgeInsets.only(left: 20, right: 5),
                            child: Text(
                              "0,00",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                letterSpacing: 0.5,
                                fontSize: 25,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                // padding: const EdgeInsets.all(8.0),
              ),
            ),
            SizedBox(
              height: he * 0.02,
            ),
          ],
        ),
      ),
    );
  }
}
