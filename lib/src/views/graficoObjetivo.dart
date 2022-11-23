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
import 'package:tcc_ll/src/views/anmition/fadeanimation.dart';
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

  @override
  Widget build(BuildContext context) {
    var we = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
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
        title: const Text("Relatório do dependente"),
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
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 70, right: 0),
                  child: Text("Objetivos em andamento.",
                      style: GoogleFonts.poppins(
                        color: Colors.blueAccent,
                        letterSpacing: 0.5,
                        fontSize: 20,
                      )),
                ),
              ],
            ),
            Container(
              child: StreamBuilder<QuerySnapshot>(
                  stream: DatabaseObjetivo.readItems(userId: widget.afiliado),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                    } else if (snapshot.data != null) {
                      return SizedBox(
                        width: 350,
                        child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(8),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (BuildContext context, int index) {
                              var doc = snapshot.data!.docs[index];
                              var data = doc.data() as Map<String, dynamic>;
                              return index > 5
                                  ? SizedBox()
                                  : FadeAnimation(
                                      delay: 1,
                                      child: Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              0, 4, 0, 0),
                                          width: 300,
                                          height: 160,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            color: Colors.orange,
                                          ),
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  IconButton(
                                                    icon: Icon(Icons
                                                        .ads_click_rounded),
                                                    color: Colors.white,
                                                    onPressed: () {},
                                                    iconSize: 30,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text('Objetivo:',
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color: Colors.white,
                                                        letterSpacing: 0.5,
                                                        fontSize: 22,
                                                      )),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(data['nome'].toString(),
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color: Colors.white,
                                                        letterSpacing: 0.2,
                                                        fontSize: 22,
                                                      )),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  IconButton(
                                                    icon: Icon(Icons
                                                        .ads_click_rounded),
                                                    color: Colors.white,
                                                    onPressed: () {},
                                                    iconSize: 30,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text('Valor:',
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color: Colors.white,
                                                        letterSpacing: 0.5,
                                                        fontSize: 22,
                                                      )),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(data['valor'].toString(),
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color: Colors.white,
                                                        letterSpacing: 0.2,
                                                        fontSize: 22,
                                                      )),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  IconButton(
                                                    icon: Icon(Icons
                                                        .ads_click_rounded),
                                                    color: Colors.white,
                                                    onPressed: () {},
                                                    iconSize: 30,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text('Valor guardado:',
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color: Colors.white,
                                                        letterSpacing: 0.5,
                                                        fontSize: 22,
                                                      )),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                      data['deposito']
                                                          .toString(),
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color: Colors.white,
                                                        letterSpacing: 0.2,
                                                        fontSize: 22,
                                                      )),
                                                ],
                                              ),
                                            ],
                                          )),
                                    );
                            }),
                      );
                    } else if (snapshot.data == null) {
                      return Container(
                        margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Text('Nenhum objetivo cadastrado!',
                            style: GoogleFonts.poppins(
                              color: Colors.blueAccent,
                              letterSpacing: 0.5,
                              fontSize: 22,
                            )),
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
              height: he * 0.03,
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 70, right: 0),
                  child: Text("Objetivos em andamento.",
                      style: GoogleFonts.poppins(
                        color: Colors.blueAccent,
                        letterSpacing: 0.5,
                        fontSize: 20,
                      )),
                ),
              ],
            ),
            Container(
              width: 350,
              height: 200,
              child: StreamBuilder<QuerySnapshot>(
                  stream: DatabaseObjetivo.readObjetivosConcluidos(
                      userId: widget.afiliado),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                    } else if (snapshot.data != null) {
                      return SizedBox(
                        width: 350,
                        child: ListView.builder(
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(8),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (BuildContext context, int index) {
                              var doc = snapshot.data!.docs[index];
                              var data = doc.data() as Map<String, dynamic>;
                              return index > 5
                                  ? SizedBox()
                                  : FadeAnimation(
                                      delay: 1,
                                      child: Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              0, 4, 0, 0),
                                          width: 300,
                                          height: 120,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            color: Colors.orange,
                                          ),
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  IconButton(
                                                    icon: Icon(Icons
                                                        .ads_click_rounded),
                                                    color: Colors.white,
                                                    onPressed: () {},
                                                    iconSize: 30,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text('Objetivo:',
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color: Colors.white,
                                                        letterSpacing: 0.5,
                                                        fontSize: 22,
                                                      )),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(data['nome'].toString(),
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color: Colors.white,
                                                        letterSpacing: 0.2,
                                                        fontSize: 22,
                                                      )),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  IconButton(
                                                    icon: Icon(Icons
                                                        .ads_click_rounded),
                                                    color: Colors.white,
                                                    onPressed: () {},
                                                    iconSize: 30,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text('Valor:',
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color: Colors.white,
                                                        letterSpacing: 0.5,
                                                        fontSize: 22,
                                                      )),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(data['valor'].toString(),
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color: Colors.white,
                                                        letterSpacing: 0.2,
                                                        fontSize: 22,
                                                      )),
                                                ],
                                              ),
                                            ],
                                          )),
                                    );
                            }),
                      );
                    } else if (snapshot.data == null) {
                      return Container(
                        margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Text('Nenhum objetivo cadastrado!',
                            style: GoogleFonts.poppins(
                              color: Colors.deepOrange,
                              letterSpacing: 0.5,
                              fontSize: 22,
                            )),
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
          ],
        ),
      ),
    );
  }
}
