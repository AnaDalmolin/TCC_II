// ignore_for_file: prefer_const_constructors
import 'package:avatars/avatars.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcc_ll/src/bloc/cadastro.dart';
import 'package:tcc_ll/src/bloc/movimentacao.dart';
import 'package:tcc_ll/src/views/Perfil.dart';
import 'package:tcc_ll/src/views/anmition/fadeanimation.dart';
import 'package:tcc_ll/src/views/singup.dart';

// ignore: must_be_immutable
class TelaPrincipalResponsavel extends StatefulWidget {
  TelaPrincipalResponsavel({Key? key, required this.user}) : super(key: key);
  User user;
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
                width: 450,
                color: const Color.fromARGB(255, 230, 46, 0),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Avatar(
                          elevation: 3,
                          shape: AvatarShape.rectangle(
                              50, 50, BorderRadius.all(Radius.circular(20.0))),
                          name: 'Ana Dal Molin',
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => TelaPerfil(
                                  user: widget.user,
                                  responsavel: responsalvel,
                                ),
                              ),
                            );
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            margin: const EdgeInsets.only(left: 20, right: 5),
                            child: Text("Ana Dal Molin",
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
              height: he * 0.02,
            ),
            FadeAnimation(
              delay: 1,
              child: ClipSmoothRect(
                child: Container(
                  width: 300,
                  height: 70,
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
                  child: Column(
                    children: [
                      Row(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              margin: const EdgeInsets.only(),
                              child: IconButton(
                                icon: const Icon(Icons.remove_red_eye),
                                color: Colors.white,
                                onPressed: () {},
                                iconSize: 30,
                              ),
                            ),
                          ),
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
                              margin: const EdgeInsets.only(left: 8, right: 5),
                              child: StreamBuilder<QuerySnapshot<Object?>>(
                                  stream: MovimentacaoBloc.readItems(
                                      userId: widget.user.uid),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasError) {
                                      print('');
                                    } else if (snapshot.data?.docs.length ==
                                            0 ||
                                        snapshot.data == null) {
                                      return Text(
                                        '0.00',
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          letterSpacing: 0.5,
                                          fontSize: 30,
                                        ),
                                      );
                                    } else if (snapshot.hasData ||
                                        snapshot.data != null) {
                                      var doc = snapshot.data!.docs[0];
                                      var data = doc.data() as Map;
                                      return Text(
                                        data['valor'].toString(),
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          letterSpacing: 0.5,
                                          fontSize: 30,
                                        ),
                                      );
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
                          ),
                        ],
                      ),
                    ],
                  ),
                  // padding: const EdgeInsets.all(8.0),
                ),
              ),
            ),
            SizedBox(
              height: he * 0.02,
            ),
            const Divider(
              height: 5,
              thickness: 4,
              indent: 10,
              endIndent: 10,
              color: Color.fromARGB(255, 230, 46, 0),
            ),
            SizedBox(
              height: he * 0.03,
            ),
            Text("Historico de movimentação",
                style: GoogleFonts.poppins(
                  color: Colors.deepPurple,
                  letterSpacing: 0.5,
                  fontSize: 22,
                )),
            SizedBox(
              height: he * 0.03,
            ),
          ],
        ),
      ),
    );
  }
}
