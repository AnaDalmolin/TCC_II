// ignore: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_bottom_navigation_2/fancy_bottom_navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickalert/quickalert.dart';
import 'package:scaled_list/scaled_list.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:tcc_ll/src/bloc/movimentacao.dart';
import 'package:tcc_ll/src/bloc/objetivo.dart';
import 'package:tcc_ll/src/views/TelaConquista.dart';
import 'package:tcc_ll/src/views/cadastroObjetivo.dart';
import 'package:tcc_ll/src/views/depositoObjetivo.dart';
import 'package:tcc_ll/src/views/objetivosConcluidos.dart';
import 'package:tcc_ll/src/views/singup.dart';
import 'package:tcc_ll/src/views/telaPrincipal.dart';

class TelaObjetivo extends StatefulWidget {
  const TelaObjetivo({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  State<TelaObjetivo> createState() => _TelaObjetivoState();
}

class _TelaObjetivoState extends State<TelaObjetivo> {
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
        title: const Text("Tela Objetivo"),
        backgroundColor: const Color.fromARGB(255, 230, 46, 0),
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
                color: const Color.fromARGB(255, 230, 46, 0),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                            margin: const EdgeInsets.only(left: 60, right: 5),
                            child: StreamBuilder<QuerySnapshot>(
                                stream: DatabaseObjetivo.readItems(
                                    userId: widget.user.uid),
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) {
                                    return const Text('Something went wrong');
                                  } else if (snapshot.hasData ||
                                      snapshot.data != null) {
                                    int numObjetivo =
                                        snapshot.data!.docs.length;
                                    return TextButton(
                                      onPressed: () {
                                        if (numObjetivo >= 5) {
                                          QuickAlert.show(
                                            context: context,
                                            type: QuickAlertType.error,
                                            title: 'Oops...',
                                            text:
                                                'Você já cadastrou o maximo de objetivos liberados!',
                                          );
                                        } else {
                                          DatabaseObjetivo.validaTotalObjetivo(
                                              user: widget.user.uid);
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CadastroObjetivo(
                                                        user: widget.user,
                                                      )));
                                        }
                                      },
                                      child: Text(
                                        "Criar Novo Objetivo +",
                                        style: GoogleFonts.poppins(
                                          color: const Color.fromARGB(
                                              255, 230, 46, 0),
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
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
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
                stream: DatabaseObjetivo.readItems(userId: widget.user.uid),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
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
                        String idDoc = snapshot.data!.docs[index].id;
                        var doc = snapshot.data!.docs[index];
                        var data = doc.data() as Map;
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.only(left: 25, right: 0),
                                  child: StreamBuilder<QuerySnapshot>(
                                      stream: MovimentacaoBloc.readItems(
                                          userId: widget.user.uid),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasError) {
                                          return const Text(
                                              'Something went wrong');
                                        } else if (snapshot.hasData ||
                                            snapshot.data != null) {
                                          var doc = snapshot.data!.docs[0];
                                          var dataSaldo = doc.data() as Map;
                                          return IconButton(
                                              icon: const Icon(Icons.delete),
                                              color: Colors.white,
                                              onPressed: () async {
                                                await DatabaseObjetivo
                                                    .deleteItemESaldo(
                                                        docId: idDoc,
                                                        userId: widget.user.uid,
                                                        docIdSaldo: snapshot
                                                            .data!.docs[0].id,
                                                        saldoAtual:
                                                            dataSaldo['valor'],
                                                        valorObjetivo:
                                                            data['deposito']);
                                              });
                                        }
                                        return const Center(
                                          child: CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                              Colors.orangeAccent,
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 160, right: 0),
                                  child: IconButton(
                                      icon: const Icon(
                                          Icons.attach_money_rounded),
                                      color: Colors.white,
                                      onPressed: () {
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CadastroDepositoObjetivo(
                                                      user: widget.user,
                                                      objetivo: data,
                                                      docId: snapshot
                                                          .data!.docs[index].id,
                                                    )));
                                      }),
                                ),
                              ],
                            ),
                            Text(data['nome'],
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  letterSpacing: 0.5,
                                  fontSize: 30,
                                )),
                            SizedBox(
                              height: he * 0.04,
                            ),
                            Text("Valor Objetivo: " + data['valor'].toString(),
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  letterSpacing: 0.5,
                                  fontSize: 20,
                                )),
                            SizedBox(
                              height: he * 0.02,
                            ),
                            Text(
                                "Valor Guardado: " +
                                    data['deposito'].toString(),
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  letterSpacing: 0.5,
                                  fontSize: 20,
                                )),
                            SizedBox(
                              height: he * 0.04,
                            ),
                            StepProgressIndicator(
                              totalSteps: data['valor'].toInt(),
                              currentStep: data['deposito'].toInt(),
                              size: 6,
                              padding: 0,
                              roundedEdges: Radius.circular(10),

                              // ignore: prefer_const_constructors
                              selectedGradientColor: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Colors.deepOrange, Colors.orange],
                              ),
                              // ignore: prefer_const_constructors
                              unselectedGradientColor: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Colors.grey, Colors.white],
                              ),
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
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                margin: const EdgeInsets.only(left: 5, right: 5),
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => TelaObjetivoConcluido(
                              user: widget.user,
                            )));
                  },
                  child: Text(
                    "Objetivos Concluidos",
                    style: GoogleFonts.poppins(
                      color: const Color.fromARGB(255, 230, 46, 0),
                      letterSpacing: 0.2,
                      fontSize: 10.0,
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
    Colors.purple,
    Colors.blue,
    Colors.red,
  ];
}
