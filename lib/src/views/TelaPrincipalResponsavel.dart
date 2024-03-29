// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcc_ll/src/bloc/cadastro.dart';
import 'package:tcc_ll/src/bloc/movimentacao.dart';
import 'package:tcc_ll/src/bloc/responsavel.dart';
import 'package:tcc_ll/src/views/ListarAfiliado.dart';
import 'package:tcc_ll/src/views/Perfil.dart';
import 'package:tcc_ll/src/views/anmition/fadeanimation.dart';
import 'package:tcc_ll/src/views/cadastroAfiliados.dart';
import 'package:tcc_ll/src/views/login.dart';
import 'package:tcc_ll/src/views/singup.dart';

// ignore: must_be_immutable
class TelaPrincipalResponsavel extends StatefulWidget {
  TelaPrincipalResponsavel(
      {Key? key, required this.user, required this.responsavel})
      : super(key: key);
  User user;
  bool responsavel;
  @override
  State<TelaPrincipalResponsavel> createState() =>
      _TelaPrincipalResponsavelState();
}

class _TelaPrincipalResponsavelState extends State<TelaPrincipalResponsavel> {
  int currentPage = 0;
  bool ispasswordev = true;
  bool responsalvel = false;
  Gender? selected;
  List movimentacao = [];

  var bloc = MovimentacaoBloc();
  var blocCadastro = CadastroBloc();

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
        title: const Text("Tela inicial"),
        backgroundColor: Colors.blueAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.login),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => Login()));
            },
          ),
        ],
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
                    child: StreamBuilder<QuerySnapshot>(
                        stream: CadastroBloc.readItems(userId: widget.user.uid),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return const Text('Something went wrong');
                          }
                          if (snapshot.hasData || snapshot.data != null) {
                            var doc = snapshot.data!.docs[0];
                            var data = doc.data() as Map;
                            return Row(
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  ),
                                  child: IconButton(
                                    iconSize: 30,
                                    icon: Icon(Icons.person),
                                    color: Colors.white,
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushReplacement(MaterialPageRoute(
                                              builder: (context) => TelaPerfil(
                                                    user: widget.user,
                                                    responsavel: responsalvel,
                                                  )));
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        left: 20, right: 5),
                                    child: Text(data['Nome'],
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          letterSpacing: 0.5,
                                          fontSize: 20,
                                        )),
                                  ),
                                ),
                              ],
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
              ),
            ),
            SizedBox(
              height: he * 0.04,
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => CadastroAfiliado(
                          user: widget.user,
                          responsalvel: widget.responsavel,
                        )));
              },
              child: Text(
                "Cadastrar dependente",
                style: GoogleFonts.heebo(
                  color: Colors.white,
                  letterSpacing: 0.2,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: TextButton.styleFrom(
                backgroundColor: Colors.orange,
                padding:
                    const EdgeInsets.symmetric(vertical: 15.0, horizontal: 80),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
            SizedBox(
              height: he * 0.04,
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => ListarAfiliado(
                          user: widget.user,
                          responsalvel: widget.responsavel,
                        )));
              },
              child: Text(
                "Lista de dependente",
                style: GoogleFonts.heebo(
                  color: Colors.white,
                  letterSpacing: 0.2,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: TextButton.styleFrom(
                backgroundColor: Colors.orange,
                padding:
                    const EdgeInsets.symmetric(vertical: 15.0, horizontal: 80),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
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
