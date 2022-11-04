// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:draw_graph/draw_graph.dart';
import 'package:draw_graph/models/feature.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcc_ll/src/bloc/cadastro.dart';
import 'package:tcc_ll/src/bloc/movimentacao.dart';
import 'package:tcc_ll/src/bloc/objetivo.dart';
import 'package:tcc_ll/src/bloc/responsavel.dart';
import 'package:tcc_ll/src/views/TelaPrincipalResponsavel.dart';
import 'package:tcc_ll/src/views/graficoAfiliado.dart';
import 'package:tcc_ll/src/views/singup.dart';

// ignore: must_be_immutable
class GraficoObjetivo extends StatefulWidget {
  GraficoObjetivo({
    Key? key,
    required this.user,
    required this.responsalvel,
    required this.afiliado,
  }) : super(key: key);
  User user;
  bool responsalvel;
  String afiliado;
  @override
  State<GraficoObjetivo> createState() => _GraficoObjetivoState();
}

class _GraficoObjetivoState extends State<GraficoObjetivo> {
  int currentPage = 0;
  bool ispasswordev = true;
  bool responsalvel = false;
  Gender? selected;
  List movimentacao = [];

  final TextEditingController idAfiliadoController = TextEditingController();

  var bloc = MovimentacaoBloc();
  var blocCadastro = CadastroBloc();
  var blocResponsavel = ResponsavelBloc();

  @override
  void initState() {
    blocCadastro.IndentificarResponsavel(widget.user, responsalvel);
    // TODO: implement initState
    super.initState();
  }

  final List<Feature> features = [
    Feature(
      title: "Drink Water",
      color: Colors.blue,
      data: [0.2, 0.8, 0.4, 0.7, 0.6],
    ),
    Feature(
      title: "Exercise",
      color: Colors.pink,
      data: [1, 0.8, 0.6, 0.7, 0.3],
    ),
    Feature(
      title: "Study",
      color: Colors.cyan,
      data: [0.5, 0.4, 0.85, 0.4, 0.7],
    ),
    Feature(
      title: "Water Plants",
      color: Colors.green,
      data: [0.6, 0.2, 0, 0.1, 1],
    ),
    Feature(
      title: "Grocery Shopping",
      color: Colors.amber,
      data: [0.25, 1, 0.3, 0.8, 0.6],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    var we = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 230, 46, 0),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => GraficoAfiliado(
                      user: widget.user,
                      responsalvel: widget.responsalvel,
                      afiliado: widget.afiliado,
                    )));
          },
          iconSize: 30,
        ),
        title: const Text("Relatório do afiliado"),
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
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            margin: const EdgeInsets.only(left: 80, right: 5),
                            child: Text("Relatório de objetivos",
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
              height: he * 0.03,
            ),
            StreamBuilder<QuerySnapshot>(
                stream: DatabaseObjetivo.readItems(userId: widget.afiliado),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                  } else if (snapshot.data != null) {
                    var doc = snapshot.data!.docs;
                    // var data = doc.data() as Map<String, dynamic>;
                    LineGraph(
                      features: features,
                      size: Size(320, 300),
                      labelX: ['Day 1', 'Day 2', 'Day 3', 'Day 4', 'Day 5'],
                      labelY: ['20%', '40%', '60%', '80%', '100%'],
                      showDescription: true,
                      graphColor: Colors.white30,
                      graphOpacity: 0.2,
                      verticalFeatureDirection: true,
                      descriptionHeight: 130,
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
    );
  }
}
